<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<%@ include file="../include/header.jsp" %>

	<div class="table-responsive">
      <table class="table table-striped mb-0">
          <thead>
              <tr>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">순번</font></font></th>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">유형</font></font></th>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">제목</font></font></th>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">내용</font></font></th>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">작성자</font></font></th>
                  <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">게시일</font></font></th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">마이클 라이트</font></font></td>
                  <td><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">$15/시간</font></font></td>
                  <td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">사용자 인터페이스(UI)</font></font></td>
                  <td><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">원격</font></font></td>
                  <td><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">오스틴,세금</font></font></td>
                  <td><a href="#"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-mail badge-circle badge-circle-light-secondary font-medium-1"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg></a></td>
              </tr>
          </tbody>
      </table>
  </div>

<%@ include file="../include/footer.jsp" %>