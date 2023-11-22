/**
 * 
 */

window.addEventListener('DOMContentLoaded', function(){
    dateFomatter();
  })
  function dateFomatter() {
    const dateList = document.querySelectorAll(".date");
    dateList.forEach(
      (dateList) =>
        (dateList.textContent = dateList.textContent
          .toString()
          .replace(dateList.toLocaleString()))
    );
  }
  