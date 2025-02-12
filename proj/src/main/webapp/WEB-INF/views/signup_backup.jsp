<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="./include/header.jsp" %>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>


<section class="d-flex vh-100">
  <div class="container-fluid row justify-content-center align-content-center">
    <div class="card bg-dark" style="border-radius: 1rem;">
      <div class="card-body p-5 text-center">
        <h2 class="text-white">SIGN UP</h2>
        <p class="text-white-50 mt-2 mb-5">서비스 사용을 위한 회원 가입</p>

        <div class = "mb-2">
          <form action="/user" method="POST" enctype="multipart/form-data">
            <!-- 토큰을 추가하여 CSRF 공격 방지 -->
            <div class="mb-3">
              <label class="form-label text-white">아이디</label>
              <input type="text" class="form-control" 
              	name="memId" placeholder="아이디" required />
            </div>
            <div class="mb-3">
              <label class="form-label text-white">이름</label>
              <input type="text" class="form-control" 
              	name="memName" placeholder="이름" required />
            </div>
            <div class="mb-3">
              <label class="form-label text-white">Password</label>
              <input type="password" class="form-control" 
              	name="memPw" placeholder="비밀번호" required />
            </div>
            <div class="mb-3">
              <label class="form-label text-white">회원이미지</label>
              <input type="file" class="form-control" 
              	name="uploadFiles" placeholder="이미지등록" multiple />
            </div>

            <button type="submit" class="btn btn-primary">Submit</button>
<%--             <sec:csrfInput/> --%>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>


<%@ include file="./include/footer.jsp" %>   
