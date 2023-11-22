/**
 * 풀스택 개발자가 되겠다
 */

function listUI(result) {
  // 어느 태그에 이 UI 를 갔다가 붙일건지
  const productList = document.querySelector(".store-product-list");

  // 모든 "product" 요소를 제거
  productList.querySelectorAll(".product").forEach((item, index) => {
    item.remove();
  });

  // result와 productList를 매개변수로 받도록 수정
  result.forEach((item) => {
    const div = document.createElement("div");
    div.classList.add("product");

    const div2 = document.createElement("div");
    div2.classList.add("preview-image");

    // "a" 요소를 생성하고 href 속성을 설정
    const a = document.createElement("a");
    const img = document.createElement("img");
    const label = document.createElement("label");
    label.classList.add("sold-label");
    label.textContent = "판매완료";

    const div3 = document.createElement("div");
    div3.classList.add("privew-info");
    const div4 = document.createElement("div");
    div4.classList.add("privew-title");
    div4.textContent = item.productName;
    const div5 = document.createElement("div");
    div5.classList.add("privew-price");
    const div6 = document.createElement("div");
    div6.classList.add("price");
    div6.textContent = item.productPrice;
    const div7 = document.createElement("div");
    div7.textContent = "원";

    

    a.href = "/store/" + item.userId + "/" + item.productId;

    img.classList = "img-full";
    img.src = "/upload/" + item.images[0].uuid + "_" + item.images[0].imageName;
    img.id = item.productId;
    img.alt = item.images[0].imageName;
    img.onerror = () => handleImageError(img);

    // 여기서 내용(content)이나 다른 속성을 "a" 요소에 추가할 수 있음
    // 예를 들어, 내용을 추가하려면:
    // a.textContent = item.name;

    // "a" 요소를 "div"에 추가
    div.appendChild(a);
    a.appendChild(div2);
    a.appendChild(div3);
    div3.appendChild(div4);
    div3.appendChild(div5);
    div5.appendChild(div6);
    div5.appendChild(div7);
    div2.appendChild(img);

    if (item.soldCheck == true) {
      img.style.filter = "brightness(0.5)";
      div2.appendChild(label);
    }
    

    // "div"를 ".store-product-list"에 추가
    productList.appendChild(div);
  });

  formatPrices();
}
