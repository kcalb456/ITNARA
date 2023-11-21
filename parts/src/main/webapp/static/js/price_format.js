/**
 *
 */
function priceFomatter() {
  const priceList = document.querySelectorAll(".price");
  priceList.forEach(
    (priceList) =>
      (priceList.textContent = priceList.textContent
        .toString()
        .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","))
  );
}
