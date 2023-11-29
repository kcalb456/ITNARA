/**
 *
 */

function category1Changed() {
  getCategory().then((result) => {
    category2Change(result);
  });
}

function getCategory() {
  return fetch("/api/category", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  })
    .then((resp) => {
      if (!resp.ok) {
        throw new Error(`HTTP error! Status: ${resp.status}`);
      }
      return resp.json();
    })
    .then((result) => {
      console.log(result);
      return result;
    })
    .catch((error) => {
      console.error("Error:", error);
      // Handle errors here
    });
}
function category2Change(result) {
  var selectElement = document.getElementById("category2");
  var selected = document.getElementById("category1");
  var value = selected.options[selected.selectedIndex].value;
  selectElement.innerHTML = "";
  result.forEach((element) => {
    element.category2
      .filter((category) => value === category.name)
      .forEach((category) => {
        var option = new Option(category.name2, category.name2);
        selectElement.add(option);
      });
  });
}
