/**
 *
 */

window.addEventListener("DOMContentLoaded", function () {
  priceFomatter();
  statusFomatter();
});
function priceFomatter() {
  const priceList = document.querySelectorAll(".price");
  priceList.forEach(
    (priceList) =>
      (priceList.textContent = priceList.textContent
        .toString()
        .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
  );
}
function statusFomatter() {
  switch (document.querySelector(".productStatus").textContent) {
    case "0":
      document.querySelector(".productStatus").textContent = "새 상품";
      break;
    case "1":
      document.querySelector(".productStatus").textContent = "중고";
      break;

    default:
  }
}
