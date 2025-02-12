<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 조직도 script 설치 -->
<script src="https://balkan.app/js/OrgChart.js"></script>

<!DOCTYPE html>
<!-- 로그인 권한 -->
<sec:authorize access="isAuthenticated()">
 <!-- 로그인 시 사이드바 시작-->
<%@ include file="../include/header.jsp" %>
       <!-- <div id="main"> -->
            <header class="mb-3">
                <a href="#" class="burger-btn d-block d-xl-none">
                    <i class="bi bi-justify fs-3"></i>
                </a>
            </header>
</sec:authorize>
 <!-- 로그인 시 사이드바 끝-->


<div id="main">
        <%@ include file="../include/top.jsp" %>
        <div class="card">
            <div class="card-header">
                <h1 class="card-title">조직도</h1>
            </div>
            <div class="card-body">
                <!-- 조직도 렌더링 영역 -->
                <div id="tree"></div>
            </div>
        </div>
    </div>
    
    

<script type="text/javascript">
//Ajax를 사용하여 서버에서 데이터 가져오기
$.ajax({
  url: '/orgChart/orgList', // 데이터를 제공하는 서버의 URL
  method: 'GET', // HTTP 요청 메서드
  dataType: 'json', // 서버에서 반환될 데이터 타입
  success: function (orgChartList) {
  // 서버에서 받은 데이터를 기반으로 OrgChart 초기화
        // 서버에서 받은 데이터를 기반으로 OrgChart 초기화
    var chart = new OrgChart(document.getElementById("tree"), {
	    template: "mila",
	    enableSearch: false,
	    mouseScrool: OrgChart.action.none,
	    nodeBinding: {
	        field_0: "name",
	        img_0: "img"
	    },
	    nodes: orgChartList // 서버에서 받은 데이터 사용
	});
  },
  error: function (xhr, status, error) {
    console.error("조직도 데이터를 가져오는 중 오류 발생:", error);
  }
});
</script>


<%@ include file="../include/footer.jsp" %>