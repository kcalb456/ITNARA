<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>

<script src="/js/form-interact.js"></script>
<div class="modal">
  <form method="post" id="signin_form" class="modal_body">
    <div>
      <div class="inputbar" id="id_field">
        <input class="input_inner" type="text" name="email" />
        <label class="input_label">아이디/이메일</label>
      </div>
      <div class="inputbar" id="pw_field">
        <input class="input_inner" type="password" name="passwd" />
        <label class="input_label">비밀번호</label>
      </div>
      <input
        type="hidden"
        name="${_csrf.parameterName}"
        value="${_csrf.token}"
      />
    </div>
    ${SPRING_SECURITY_LAST_EXCEPTION.message}
    <button class="long-button c-blue">로그인</button>
    <div>
      <a href="/auth/signup">회원가입</a>
    </div>
  </form>
</div>

<script>
  var myInput;
  var inputLabels;
  var inputs;

  const form = document.getElementById("signin_form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const payload = new FormData(form);

    fetch("/auth/login", {
      method: "POST",
      headers: {
        "X-CSRF-TOKEN": payload.get("${_csrf.parameterName}"),
      },
      body: payload,
    })
      .then((res) => {
        if (!res.ok) {
          throw new Error(`서버 응답 실패, 상태 코드: ${res.status}`);
        }

        // Content-Type 헤더를 확인하여 JSON 여부를 판단
        const contentType = res.headers.get("Content-Type");
        if (contentType && contentType.includes("application/json")) {
          return res.json(); // JSON 형식으로 변환
        } else {
          return res.text(); // 다른 형식이라면 텍스트로 변환
        }
      })
      .then((data) => {
        // 로그인이 성공했을 때의 추가 로직을 여기에 추가
        // 예: 리디렉션 등
        console.log("로그인 성공:", data);

        // /api/auth에 대한 GET 요청
        fetch("/api/auth", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        })
          .then((res) => {
            if (!res.ok) {
              throw new Error(`서버 응답 실패, 상태 코드: ${res.status}`);
            }

            return res.json(); // JSON 형식으로 변환
          })
          .then((apiData) => {
            // /api/auth 응답 처리
            console.log("/api/auth 응답:", apiData);
            location.reload();
            // 이후 작업을 수행하거나 필요한 처리를 추가
          })
          .catch((error) => {
            console.error("/api/auth 요청 중 에러 발생:", error);
          });
      })
      .catch((error) => {
        console.error("에러 발생:", error);
      });
  });
</script>
