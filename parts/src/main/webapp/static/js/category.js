/**
 *
 */

function getCategory() {
  var selected = document.getElementById("category1");
  var value = selected.options[selected.selectedIndex].value;
  console.log(value);
  const header = document.querySelector('meta[name="_csrf_header"]').content;
  const token = document.querySelector('meta[name="_csrf"]').content;
  fetch("/api/category", {
    method: "POST",
    headers: {
      header: header,
      "X-Requested-With": "XMLHttpRequest",
      "Content-Type": "application/json",
      "X-CSRF-Token": token,
    },
  })
    .then((resp) => {
      if (!resp.ok) {
        throw new Error(`HTTP error! Status: ${resp.status}`);
      }
      return resp.json();
    })
    .then((result) => {
      category2Change(result);
    })
    .catch((error) => {
      console.error("Error:", error);
      // Handle errors here
    });

  function category2Change(result) {
    var selectElement = document.getElementById("category2");
    selectElement.innerHTML = "";
    for (var i = 0; i < result.length; i++) {
      var option = document.createElement("option");
      if (value == result[i].name) {
        option.value = result[i].name2;
        option.text = result[i].name2;
        selectElement.add(option);
      }
    }
  }
}
