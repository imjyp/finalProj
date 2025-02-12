<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!DOCTYPE html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>부서 관리</title>
	<link rel="stylesheet" href="/dist/assets/compiled/css/app.css">
	<link rel="stylesheet" href="/css/common2.css">
	<link rel="shortcut icon" type="image/x-icon" href="/kor/images/favicon.ico">
<!-- 	<link rel="stylesheet" href="/dist/assets/compiled/css/app-dark.css"> -->
	<link rel="stylesheet" href="/dist/assets/compiled/css/iconly.css">
<!-- 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	
	
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/top.jsp"%>
</head>

<style>
.swal-body{
	font-family : 'NotoSansKR' ; 
	font-size :500 !important;
}

#main {
  margin-top: 141px; 
}
</style>

<!-- 시작 -->
<div id="main">
	 <!-- 왼쪽: 제목과 브레드크럼 (col-md-6) -->
	        <div class="col-md-6 d-flex align-items-center">
	          <nav aria-label="breadcrumb" class="ms-3">
	            <ol class="breadcrumb mb-0">
	              <li class="breadcrumb-item"><a href="/main">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/deptManage/test">부서 관리</a></li>
	            </ol>
	          </nav>
	        </div>
	        
	 <div class="card">
	     <!-- 메인 리스트 시작 -->
	     <div class="card-content">
	         <!-- table striped -->
	         <div class="tableType01">
	             <table class="board">
	                 <thead>
	                     <tr>
	                     	<th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">선택</font></font></th>
	                         <th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">부서이름</font></font></th>
<!-- 	                         <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">권한번호</font></font></th> -->
	                         <th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">상위부서</font></font></th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="dept" items="${getDeptList}" varStatus="status">
	                     	<tr>
	             				<td class="text-bold-500 text-center"><input class="form-check-input selectRow" type="radio" name="flexRadioDefault" data-no="${dept.deptNo}"></td>
								<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${dept.deptNm}</font></font></td>
<%-- 	                          	<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${dept.authNo}</font></font></td> --%>
<%-- 	                          	<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${dept.deptSuprr}</font></font></td> --%>
	                          	
	                          	<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
	                          	
					                <!-- 반복문으로 리스트 전체 가져오기 -->
			                        <c:forEach var="item" items="${getDeptList}">
			                        	<!-- 조건 확인 번호 == 상위번호 같을 때 실행 -->
			                            <c:if test="${item.deptNo == dept.deptSuprr}">
			                            	<!-- 번호와 상위번호가 같은 이름+(상위번호) 출력 -->
			                                ${item.deptNm} 
									</c:if></c:forEach></font></font></td>
	                     	</tr>
	                 	</c:forEach>
	                 </tbody>
	             </table>
	         </div>
	     </div>
	 </div>
	 <div class="buttons">
			<button id="editButton" class="btn btn-warning ms-1">수정</button>
			<button id="deleteButton" class="btn btn-warning ms-1">삭제</button>
	     	<button id="saveButton" class="btn btn-dark ms-1">등록</button>
	 </div>
</div><!--/.main  -->


<!-- 수정 Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <div class="mb-3">
                        <label for="editNo" class="form-label">부서번호</label>
                        <input type="number" class="form-control" id="editNo" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">부서이름</label>
                        <input type="text" class="form-control" id="editName" >
                    </div>
<!--                     <div class="mb-3"> -->
<!--                         <label for="editAuthNo" class="form-label">권한번호</label> -->
<!--                         <input type="number" class="form-control" id="editAuthNo"> -->
<!--                     </div> -->
                    <div class="mb-3">
                        <label for="editSuprr" class="form-label">상위부서번호</label>
<!--                         <input type="number" class="form-control" id="editSuprr"> -->
						<select id="editSuprr" class="form-select">
							<option value=null>최상위부서</option>
                        	<c:forEach var="item" items="${getDeptList}">
                        		<option value="${item.deptNo}">${item.deptNm}</option>
                        	</c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning ms-1" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-dark ms-1" id="saveEdit">저장</button>
            </div>
        </div>
    </div>
</div>

<!-- 등록 Modal -->
<div class="modal fade" id="saveModal" tabindex="-1" aria-labelledby="saveModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="saveModalLabel">등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="saveForm">
<!--                     <div class="mb-3"> -->
<!--                         <label for="saveNo" class="form-label">부서번호</label> -->
<!--                         <input type="number" class="form-control" id="saveNo"> -->
<!--                     </div> -->
                    <div class="mb-3">
                        <label for="saveName" class="form-label">부서이름</label>
                        <input type="text" class="form-control" id="saveName">
                    </div>
					<!-- <div class="mb-3">
                        <label for="saveAuthNo" class="form-label">권한번호</label>
                        <input type="number" class="form-control" id="saveAuthNo">
                    </div> -->
                    <div class="mb-3">
                        <label for="saveSuprr" class="form-label">상위부서번호</label>
<!--                         <input type="number" class="form-control" id="saveSuprr"> -->
                        <select id="saveSuprr" class="form-select">
                        	<option value="" disabled selected>선택해주세요</option>
                        	<option value=null>최상위부서</option>
                        	<c:forEach var="item" items="${getDeptList}">
                        		<option value="${item.deptNo}">${item.deptNm}</option>
                        	</c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning ms-1" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-dark ms-1" id="Save">저장</button>
            </div>
        </div>
    </div>
</div>

	
<script>
$(function() {
	// 등록 버튼 클릭 이벤트
	$('#saveButton').on('click', function() {
        //$('#saveNo').val(null);
        $('#saveName').val("");
        //$('#saveAuthNo').val(null);
        $('#saveSuprr').val(null);
        
        $('#saveModal').modal('show');
    });
    
    // 등록모달 저장 버튼 클릭 이벤트
    $('#Save').on('click', function() {
        //const no = $('#saveNo').val();
        const name = $('#saveName').val();
        //const authNo = $('#saveAuthNo').val();
        const suprr = $('#saveSuprr').val();
        
        if (!name || !suprr) {
            alert('모든 값을 입력해야 합니다.');
            return;
        }
        // AJAX 호출 예시
        $.ajax({
            url: '/deptManage/create',
            method: 'POST',
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({ 
            	//deptNo: no,
            	deptNm: name,
            	//authNo: authNo,
            	deptSuprr: suprr
            }),
            success: function(response) {
            	 /* if (response === "DUPLICATE") {
                     alert('이미 존재하는 부서번호입니다.');
                 } else if (response === "SUCCESS") {
	                alert('등록되었습니다.');
	                $('#saveModal').modal('hide');
	                location.reload();
                 } */
            	alert('등록되었습니다.');
                $('#saveModal').modal('hide');
                location.reload();
            },
            error: function() {
                alert('등록 실패.');
            }
        });
    });
    
	
    // 수정 버튼 클릭 모달 이벤트
    $('#editButton').on('click', function() {
        const selected = $('input[name="flexRadioDefault"]:checked');
        if (selected.length === 0) {
            alert('수정할 항목을 선택하세요.');
            return;
        }
        
        const no = selected.data('no'); // 부서번호 가져오기
        const name = selected.closest('tr').find('td:nth-child(2)').text().trim(); // 부서이름 가져오기
	    const suprr = selected.closest('tr').find('td:nth-child(3)').text().trim(); // 상위부서 번호 가져오기
        //const authNo = selected.closest('tr').find('td:nth-child(5)').text();
	    console.log('선택된 부서정보:', { no, name, suprr });
	    
//      const suprrText = selected.closest('tr').find('td:nth-child(5)').text().trim();
// 	    const suprrMatch = suprrText.match(/\((\d+)\)/); // 괄호 안의 숫자 추출
//      const suprr = suprrMatch ? suprrMatch[1] : null; // 숫자가 없으면 빈 문자열
//      console.log('선택된 상위부서번호suprr:', suprrText);
//      console.log('선택된 상위부서번호suprr:', suprrMatch);
//      console.log('선택된 상위부서번호suprr:', suprr);

        $('#editNo').val(no);
        $('#editName').val(name);
        //$('#editAuthNo').val(authNo);
        
		// 상위부서 값을 select 태그에서 자동 선택되도록 설정
	    $('#editSuprr option').each(function () {
	    	if (suprr === null || suprr === "null" || suprr === "") {
	    		//값이 null이거나 빈문자열일 경우 최상위부서 선택
	    		$(this).prop('selected', null);
	        }else if ($(this).text().trim() === suprr) {
	        	//select 태그에서 가져온 상위부서 이름과 일치하는 옵션을 찾아 자동으로 선택
	        	$(this).prop('selected', true);
	        }
	    });
        
        
        $('#editModal').modal('show');
    });
    
    // 수정모달 저장 버튼 클릭 이벤트
    $('#saveEdit').on('click', function() {
        const no = $('#editNo').val();
        const name = $('#editName').val();
        //const authNo = $('#editAuthNo').val();
        const suprr = $('#editSuprr').val();
        
        // AJAX 호출 예시
        $.ajax({
            url: '/deptManage/update',
            method: 'POST',
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({ 
            	deptNo: no,
            	deptNm: name,
            	//authNo: authNo,
            	deptSuprr: suprr
            }),
            success: function() {
                alert('수정되었습니다.');
                $('#editModal').modal('hide');
                location.reload();
            },
            error: function() {
                alert('수정 실패.');
            }
        });
    });

    // 삭제 버튼 클릭 이벤트
    $('#deleteButton').on('click', function() {
        const selected = $('input[name="flexRadioDefault"]:checked');
        if (selected.length === 0) {
            alert('삭제할 항목을 선택하세요.');
            return;
        }
        console.log('Selected radio:', selected); //데이터 확인
        const no = selected.data('no');
        const confirmDelete = confirm('정말로 삭제하시겠습니까?');        
        
        if (confirmDelete) {
            // AJAX 호출 예시
            $.ajax({
                url: '/deptManage/delete',
                method: 'POST',
                contentType:"application/json;charset=utf-8",
                data: JSON.stringify({ 
                	deptNo: no
				}),
                success: function() {
                    alert('삭제되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('삭제 실패.');
                }
            });
        }
    });
    
    
});


</script>	
		

<%@ include file="../include/footer.jsp" %>




