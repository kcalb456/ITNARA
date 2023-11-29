<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="/js/add_files.js"></script>
    <script src="/js/category.js"></script>
    <script src="/js/price_format.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Document</title>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
    <div class="container">
      <form class="pay-form" method="post" enctype="multipart/form-data">
        <div>
          <h2>결제</h2>
        </div>
        <input
          type="hidden"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />
        <div class="form-group">
          <label>상품명:</label>
          <div>${item.productName}</div>
        </div>

        <div class="form-group">
          <label>가격:</label>
          <div class="price">${item.productPrice}</div>
          <div>원</div>
        </div>

        <div class="form-group">
          <label>배송비:</label>
          <div>${item.deliveryPrice}</div>
          <div>원</div>
        </div>

        <div class="form-group">
          <label class="input_label">수량:</label>
          <div>${item.productStock}</div>
          <div>개</div>
        </div>

        <div class="form-group">
          <label>상태:</label>
          <div class="productStatus">${item.productStatus}</div>
        </div>

        <div class="form-group">
          <label>수량:</label>
          <div>${item.productStock}</div>
        </div>

        <div>
          <input
            type="text"
            id="sample6_postcode"
            placeholder="우편번호"
            name="zip"
          />
          <input
            type="button"
            onclick="sample6_execDaumPostcode()"
            value="우편번호 찾기"
          /><br />
          <input
            type="text"
            id="sample6_address"
            placeholder="주소"
            name="address1"
          /><br />
          <input
            type="text"
            id="sample6_detailAddress"
            placeholder="상세주소"
            name="address2"
          />
          <input
            type="text"
            id="sample6_extraAddress"
            placeholder="참고항목"
            name="reference"
          />
        </div>

        <div>
          <button>결제 하기</button>
        </div>
      </form>
    </div>
  </body>
  <script>
    function sample6_execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ""; // 주소 변수
          var extraAddr = ""; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === "R") {
            // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else {
            // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if (data.userSelectedType === "R") {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== "" && data.apartment === "Y") {
              extraAddr +=
                extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== "") {
              extraAddr = " (" + extraAddr + ")";
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;
          } else {
            document.getElementById("sample6_extraAddress").value = "";
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample6_postcode").value = data.zonecode;
          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("sample6_detailAddress").focus();
        },
      }).open();
    }
  </script>
</html>
