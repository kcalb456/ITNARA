package kr.ac.kopo.itnara.model;

import java.util.List;

public class Category1 {
private String name;
private List<Category2> category2;

public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public List<Category2> getCategory2() {
	return category2;
}
public void setCategory2(List<Category2> category2) {
	this.category2 = category2;
}

}
