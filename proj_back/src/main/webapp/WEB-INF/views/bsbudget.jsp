<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="./include/header.jsp"%>
<div id="main">
	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"> 
			<i class="bi bi-justify fs-3"></i>
		</a>
	</header>
	<div class="page-heading">
		<h3>본사예산관리</h3>
	</div>
	<div class="page-content">
		<p>${bgList }</p>
	</div>
</div>
<%@ include file="./include/footer.jsp"%>

</body>

	</html>