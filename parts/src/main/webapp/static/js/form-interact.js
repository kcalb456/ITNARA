/**
 *
 */
document.addEventListener("input", function () {
  inputLabels = document.querySelectorAll("form .input_label");
  inputs = document.querySelectorAll("form .input_inner");

  inputs.forEach(function (input, index) {
    var inputLabel = inputLabels[index];

    if (input.value !== "") {
      inputAnime(inputLabel);
    } else {
      inputLabel.style.top = "18px";
      inputLabel.style.fontSize = "16px";
      inputLabel.style.color = "black";
    }
  });
});

document.addEventListener(
  "focus",
  function (event) {
    myInput = document.activeElement;
    if (myInput.tagName === "INPUT") {
      var inputLabel = myInput.parentElement.querySelector(".input_label");
      inputAnime(inputLabel);
      myInput.addEventListener("blur", function () {
        // 포커스가 해제되었을 때 애니메이션을 되돌림
        if (myInput.value === "") {
          inputLabel.style.top = "18px";
          inputLabel.style.fontSize = "16px";
          inputLabel.style.color = "black";
        }
      });
    }
  },
  true
);

function inputAnime(label) {
  label.style.transitionProperty = "top, font-size, color";
  label.style.transitionDuration = "0.2s";
  label.style.transitionTimingFunction = "ease-in-out";

  label.style.top = "2px";
  label.style.fontSize = "12px";
  label.style.color = "#0080ff";
}
