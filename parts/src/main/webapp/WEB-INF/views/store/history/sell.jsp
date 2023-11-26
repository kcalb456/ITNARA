<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<script>
  function trackingUpdate(productId) {
    if (
      !document.getElementById("tracking-number").readOnly &&
      !document.getElementById("delivery").disabled
    ) {
      const formData = new URLSearchParams();

      formData.append("t_key", "btym3M1V7b4xVDCKRpixdw");
      formData.append(
        "t_invoice",
        document.getElementById("tracking-number").value
      );
      formData.append("t_code", document.getElementById("delivery").value);

      const url = new URL("http://info.sweettracker.co.kr/api/v1/trackingInfo");
      url.search = formData.toString();

      fetch(url, {
        method: "GET",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      })
        .then((response) => response.json())
        .then((result) => {
          console.log();
          let statusCode = 0;
          if (result.code) {
            statusCode = result.code;
          }
          if (statusCode == "104") {
            document.getElementById("tracking-number").focus;
            butterup.toast({
              title: "송장번호 등록에 실패하였습니다",
              message: result.msg,
              location: "bottom-center",
              icon: true,
              dismissable: false,
              type: "error",
              theme: "grass",
            });
          } else {
            const csrfHeader = document.querySelector(
              'meta[name="_csrf_header"]'
            ).content;
            const csrfToken =
              document.querySelector('meta[name="_csrf"]').content;

            var path = window.location.pathname;

            // 경로에서 userId 추출하기
            var userIdMatch = path.match(/\/store\/(\d+)/);

            // userId가 존재하면 값을 추출
            userId = userIdMatch ? userIdMatch[1] : null;

            const orderList1 = orderInfo.find(
              (order) => order.productId == productId
            );

            console.log(orderList1);

            fetch("/api/store/order/tracking", {
              method: "PATCH",
              headers: {
                [csrfHeader]: csrfToken,
                "Content-Type": "application/json",
              },
              body: JSON.stringify({
                userId: orderList1.userId,
                productId: productId,
                tracking: document.getElementById("tracking-number").value,
                trackingCode: document.getElementById("delivery").value,
              }),
            })
              .then((response) => {
                if (!response.ok) {
                  throw new Error(`HTTP error! Status: ` + response.status);
                }
                return response.text();
              })
              .then((data) => {
                butterup.toast({
                  title: "송장번호 등록에 성공하였습니다",
                  message: result.msg,
                  location: "bottom-center",
                  icon: true,
                  dismissable: false,
                  type: "success",
                  theme: "grass",
                });
                orderList();
              })
              .catch((error) => {
                console.error("Fetch error:", error);
              });
          }
        })
        .catch((error) => {
          console.error("에러:", error);
          throw error; // 이 부분은 필요에 따라 수정할 수 있습니다.
        });
      OrderModalClose();
    } else {
      if (document.getElementById("tracking-number").value == "") {
        butterup.toast({
          title: "송장번호를 등록해주세요!",
          message: "송장번호 미입력 시 결제가 취소됩니다.",
          location: "bottom-center",
          icon: true,
          dismissable: false,
          type: "error",
          theme: "grass",
        });
      }
      OrderModalClose();
    }
  }
</script>

<script>
  function OrderModalClose() {
    const modals = document.querySelectorAll(".modal");

    modals.forEach((modal) => {
      modal.classList.remove("show");
      modal
        .querySelector(".modal_body")
        .classList.remove("animate__fadeInUp", "animate__animated");
    });
  }

  function modal(id) {
    const order = document.querySelector(".order");
    const modalBody = document.querySelector(".order .modal_body");
    if (modalBody.querySelector("div .delivery-info")) {
      modalBody.querySelector("div .delivery-info").remove();
    }

    modalBody.classList.add("animate__fadeInUp", "animate__animated");

    var path = window.location.pathname;

    // 경로에서 userId 추출하기
    var userIdMatch = path.match(/\/store\/(\d+)/);

    // userId가 존재하면 값을 추출
    userId = userIdMatch ? userIdMatch[1] : null;

    const orderList = orderInfo.find((order) => order.productId == id);

    console.log(orderList.userId + " " + userId);

    var inputBar = document.createElement("div");
    inputBar.className = "inputbar delivery-info";

    var input = document.createElement("input");
    input.id = "tracking-number";
    input.className = "input_inner";
    input.readOnly = true;

    var label = document.createElement("label");
    label.className = "input_label";

    var select = document.createElement("select");
    select.id = "delivery";

    // inputBar에 자식 요소 추가
    inputBar.appendChild(input);
    inputBar.appendChild(label);
    inputBar.appendChild(select);

    // 만들어진 요소를 원하는 위치에 추가
    modalBody
      .querySelector("div .address-info")
      .parentNode.insertBefore(
        inputBar,
        modalBody.querySelector("div .address-info").nextSibling
      );

    document.querySelector(".order-form-confirm").id = id;
    document.getElementById("tracking-number").setAttribute("readonly", "true");

    document.querySelector(".orderId").textContent = orderList.orderId;
    document.querySelector(".orderDate").textContent = orderList.orderDate;
    document.querySelector(".product-title").textContent =
      orderList.productName;
    document.querySelector(".product-detail").textContent =
      orderList.productDetail;
    document.querySelector(".product-image .img-full").src =
      "/upload/" +
      orderList.images[0].uuid +
      "_" +
      orderList.images[0].imageName;

    document.querySelector(".product-list .price").textContent =
      orderList.productPrice;

    document.querySelector(".address1").textContent = orderList.address1;
    document.querySelector(".address2").textContent = orderList.address2;
    document.querySelector(".reference").textContent = orderList.reference;

    document.getElementById("tracking-number").value = orderList.tracking;
    const deliveryInfo = document.querySelector(".delivery-info");

    if (orderList.userId != userId) {
      select.disabled = true;
      deliveryInfo.querySelector("#tracking-number").remove();
      deliveryInfo.querySelector(".input_label").remove();

      var div = document.createElement("div");

      deliveryInfo.insertBefore(div, select);

      div.textContent = orderList.tracking;

      if (orderList.tracking == null) {
        div.textContent = "송장번호가 아직 입력되지 않았습니다";
      } else {
        const formData = new URLSearchParams();

        formData.append("t_key", "btym3M1V7b4xVDCKRpixdw");
        formData.append("t_invoice", orderList.tracking);
        formData.append("t_code", orderList.trackingCode);

        const url = new URL(
          "http://info.sweettracker.co.kr/api/v1/trackingInfo"
        );
        url.search = formData.toString();

        fetch(url, {
          method: "GET",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
          .then((response) => response.json())
          .then((result) => {
            console.log();
            let statusCode = 0;
            if (result.code) {
              statusCode = result.code;
            }
            if (statusCode == "104") {
              document.getElementById("tracking-number").focus;
              butterup.toast({
                title: "송장번호가 올바르지 않은것 같습니다.",
                message: result.msg,
                location: "bottom-center",
                icon: true,
                dismissable: false,
                type: "error",
                theme: "grass",
              });
            } else {
              result.trackingDetails.forEach((item) => {
                const div = document.createElement("div");
                div.textContent = item.kind;

                deliveryInfo.appendChild(div);

                console.log(item);
              });
            }
          });
      }
    } else {
      // 조건이 충족되었을 때의 로직

      if (orderList.tracking == null) {
        div.textContent = "송장번호가 아직 입력되지 않았습니다";
      } else {
        const formData = new URLSearchParams();

        formData.append("t_key", "btym3M1V7b4xVDCKRpixdw");
        formData.append("t_invoice", orderList.tracking);
        formData.append("t_code", orderList.trackingCode);

        const url = new URL(
          "http://info.sweettracker.co.kr/api/v1/trackingInfo"
        );
        url.search = formData.toString();

        fetch(url, {
          method: "GET",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
          .then((response) => response.json())
          .then((result) => {
            console.log();
            let statusCode = 0;
            if (result.code) {
              statusCode = result.code;
            }
            if (statusCode == "104") {
              document.getElementById("tracking-number").focus;
              butterup.toast({
                title: "송장번호가 올바르지 않은것 같습니다.",
                message: result.msg,
                location: "bottom-center",
                icon: true,
                dismissable: false,
                type: "error",
                theme: "grass",
              });
            } else {
              result.trackingDetails.forEach((item) => {
                const div = document.createElement("div");
                div.textContent = item.kind;

                deliveryInfo.appendChild(div);

                console.log(item);
              });
            }
          });
      }
      label.appendChild(document.createTextNode("송장번호 입력"));
      input.onclick = function () {
        unlock(this);
      };
    }

    // 이벤트 전파 방지 함수
    function stopPropagation(e) {
      e.stopPropagation();
    }
    order.classList.toggle("show");
    inputNullCheck();

    order.addEventListener("mousedown", () => {
      if (!modalBody.contains(event.target)) {
        order.classList.remove("show");
      }
    });
    deliveryCompanyList(orderList.trackingCode);
    priceFomatter();
  }
</script>

<script>
  function deliveryCompanyList(trackingCode) {
    fetch(
      "http://info.sweettracker.co.kr/api/v1/companylist?t_key=btym3M1V7b4xVDCKRpixdw",
      {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
        },
      }
    )
      .then((resp) => resp.json())
      .then((result) => {
        console.log(result);
        result.Company.forEach((item) => {
          var newOption = document.createElement("option");
          newOption.value = item.Code;
          newOption.text = item.Name;

          var selectElement = document.getElementById("delivery");
          selectElement.add(newOption);
          if (trackingCode == item.Code) {
            newOption.selected = true;
          }
        });
      });
  }
</script>

<script>
  function unlock(inputElement) {
    inputElement.removeAttribute("readonly");
  }
</script>

<div class="modal order">
  <div id="order-form" class="modal_body animate__faster">
    <div>
      <div class="order-title">
        <h2>거래정보</h2>
      </div>
      <div class="order-number">
        <div>
          <label>거래번호 : </label>
          <div class="orderId"></div>
        </div>
        <div class="orderDate"></div>
      </div>
      <div class="product-list">
        <div class="product-image">
          <img class="img-full" src="" onerror="handleImageError(this)" />
        </div>
        <div class="product-info">
          <div class="product-title"></div>
          <div class="product-detail"></div>
        </div>
        <div class="product-price">
          <div class="price"></div>
          <div>원</div>
        </div>
      </div>
      <h2>배송정보</h2>
      <div class="address-info">
        <div class="address1"></div>
        <div class="address2"></div>
        <div class="reference"></div>
      </div>

      <button
        class="long-button c-blue order-form-confirm"
        onclick="trackingUpdate(this.id);"
      >
        확인
      </button>
    </div>
  </div>
</div>
