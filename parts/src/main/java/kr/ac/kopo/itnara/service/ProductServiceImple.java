package kr.ac.kopo.itnara.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.itnara.dao.ProductDao;
import kr.ac.kopo.itnara.model.Category1;
import kr.ac.kopo.itnara.model.Product;
import kr.ac.kopo.itnara.model.ProductImage;
import kr.ac.kopo.itnara.model.Search;
import kr.ac.kopo.itnara.security.CustomUserDetails;

@Service
public class ProductServiceImple implements ProductService {

	private String uploadPath = "d:/upload/";
	private String cachePath = "d:/cache/";

	@Autowired
	ProductDao dao;

	@Override
	public List<Product> list(Search search) {
		return dao.list(search);
	}

	// 등록한 임시 이미지를 upload 폴더로 옮긴 후 실제적으로 물품 등록및 파일 업로드를 담당하는 부분
	@Transactional
	@Override
	public void add(Product item, Authentication authentication) {

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		String cacheFolderPath = cachePath + userDetails.getUserId() + "/";

		// 특정 폴더에서 파일 목록 가져와서 UUID 와 파일명 분리
		File cacheFolder = new File(cacheFolderPath);
		File[] files = cacheFolder.listFiles();
		List<ProductImage> images = new ArrayList<ProductImage>();
		if (files != null) {
			for (File file : files) {
				if (file.isFile()) {
					String fileName = file.getName();
					int separatorIndex = fileName.indexOf("_");
					if (separatorIndex != -1) {
						String uuid = fileName.substring(0, separatorIndex);
						String actualFileName = fileName.substring(separatorIndex + 1);
						try {
							// 파일 이동
							Path destinationPath = Paths.get(uploadPath, uuid + "_" + actualFileName);
							Files.move(file.toPath(), destinationPath, StandardCopyOption.REPLACE_EXISTING);

							// ProductImage 객체 생성
							ProductImage img = new ProductImage();
							img.setImageName(actualFileName);
							img.setUuid(uuid);

							images.add(img);
						} catch (IOException e) {
							e.printStackTrace();
							// 파일 이동 실패 처리
						}
						System.out.println("UUID: " + uuid + ", FileName: " + actualFileName);
					}
				}
			}
		}
		deleteFolder(cacheFolder);

		item.setUserId(userDetails.getUserId());
		item.setImages(images);

		// TODO Auto-generated method stub
		dao.add(item);

		for (ProductImage image : item.getImages()) {
			image.setProductId(item.getProductId());
			dao.add(image);
		}
	}

	@Override
	public void cacheImageDelete(Authentication authentication) {
		// TODO Auto-generated method stub
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		String cacheFolderPath = cachePath + userDetails.getUserId() + "/";
		File cacheFolder = new File(cacheFolderPath);
		deleteFolder(cacheFolder);
	}

	// 폴더 및 하위 항목 삭제 메서드
	private void deleteFolder(File folder) {
		if (folder.isDirectory()) {
			File[] files = folder.listFiles();
			if (files != null) {
				for (File file : files) {
					deleteFolder(file);
				}
			}
		}
		folder.delete();
	}

	@Override
	public List<Category1> category() {
		// TODO Auto-generated method stub
		return dao.category();
	}

	@Override
	public void uploadedDupleToCache(List<ProductImage> list, Authentication authentication) {
			// TODO Auto-generated method stub
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
			for (ProductImage image : list) {
	            try {
	                String sourceFileUuid = image.getUuid();
	                String sourceFileName = image.getImageName();// assuming UUID is the filename
	                String destinationFileName = sourceFileUuid + "_" + sourceFileName;
	                
	                System.out.println(destinationFileName);

	                Path sourcePath = Paths.get(uploadPath, destinationFileName);
	                Path destinationPath = Paths.get(cachePath + userDetails.getUserId() + "/", destinationFileName);

	                Files.createDirectories(destinationPath.getParent());
	                // Copy the file
	                Files.copy(sourcePath, destinationPath);

	                // You can optionally delete the file from the original uploadPath
	                // Files.delete(sourcePath);
	            } catch (IOException e) {
	                e.printStackTrace(); // Handle the exception based on your requirements
	            }
	        }
			
		
		
	}

	@Override
	public void update(Product item, Authentication authentication) {
		// TODO Auto-generated method stub
		
		
		List <ProductImage> images = dao.getImage(item.getProductId()); 
		
		if(!images.isEmpty())
		{
			dao.deleteImage(images);	
		}

		for (ProductImage image : images) {
			File file = new File(uploadPath + image.getUuid() + "_" + image.getImageName());
			if (file.exists()) {
				file.delete();
			}
		}
		
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
		String cacheFolderPath = cachePath + userDetails.getUserId() + "/";

		// 특정 폴더에서 파일 목록 가져와서 UUID 와 파일명 분리
		File cacheFolder = new File(cacheFolderPath);
		File[] files = cacheFolder.listFiles();
		images = new ArrayList<ProductImage>();
		if (files != null) {
			for (File file : files) {
				if (file.isFile()) {
					String fileName = file.getName();
					int separatorIndex = fileName.indexOf("_");
					if (separatorIndex != -1) {
						String uuid = fileName.substring(0, separatorIndex);
						String actualFileName = fileName.substring(separatorIndex + 1);
						try {
							// 파일 이동
							Path destinationPath = Paths.get(uploadPath, uuid + "_" + actualFileName);
							Files.move(file.toPath(), destinationPath, StandardCopyOption.REPLACE_EXISTING);

							// ProductImage 객체 생성
							ProductImage img = new ProductImage();
							img.setImageName(actualFileName);
							img.setUuid(uuid);

							images.add(img);
						} catch (IOException e) {
							e.printStackTrace();
							// 파일 이동 실패 처리
						}
						System.out.println("UUID: " + uuid + ", FileName: " + actualFileName);
					}
				}
			}
		}
		deleteFolder(cacheFolder);

		item.setUserId(userDetails.getUserId());
		item.setImages(images);
		


		
		
		for (ProductImage image : item.getImages()) {
			image.setProductId(item.getProductId());
			dao.add(image);
		}
		
		dao.update(item);
	}
}
