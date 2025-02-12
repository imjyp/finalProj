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
	<title>직책 관리</title>
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
	              <li class="breadcrumb-item"><a href="/main" style="">Home</a></li>
	              <li class="breadcrumb-item active"><a href="/positionManage/test">직책 관리</a></li>
	            </ol>
	          </nav>
	        </div>

   	<div class="card" style="border: none;">
	     <div class="card-content">
	         <!-- table striped -->
	         <div class="tableType01">
	             <table class="board">
	                 <thead>
	                     <tr>
							 <th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">선택</font></font></th>            	
	                         <th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">직책이름</font></font></th>
	                         <th class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">소속</font></font></th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="position" items="${positionList}" varStatus="status">
	                     	<tr>
	             				<td class="text-bold-500 text-center"><input class="form-check-input selectRow" type="radio" name="flexRadioDefault" data-no="${position.positionNo}"></td>
	                          	<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${position.positionNm}</font></font></td>
	                          	<td class="text-bold-500 text-center"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${position.positionAffiliation}</font></font></td>
	                          	
	                          	<!-- C태그 조건식으로 소속 구분한 코드 -->
<!-- 	                          	<td><font style="vertical-align: inherit;"><font style="vertical-align: inherit;"> -->
<%-- 	                          		<c:choose> --%>
<%-- 							        <c:when test="${position.positionNo <= 4}"> --%>
<!-- 							            <font style="vertical-align: inherit;">본사</font> -->
<%-- 							        </c:when> --%>
<%-- 							        <c:otherwise> --%>
<!-- 							            <font style="vertical-align: inherit;">가맹점</font> -->
<%-- 							        </c:otherwise> --%>
<%-- 							    	</c:choose> --%>
<!-- 	                          		</font> -->
<!-- 	                          		</font> -->
<!-- 	                          	</td> -->
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
                        <label for="editNo" class="form-label">직책 번호</label>
                        <input type="number" class="form-control" id="editNo" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">직책 이름</label>
                        <input type="text" class="form-control" id="editName">
                    </div>
                    <div class="mb-3">
                        <label for="editAffiliation" class="form-label">소속 이름</label>
<!--                    <input type="text" class="form-control" id="editAffiliation"> -->
                         <!-- select 선택 시작 -->
						 <select id="editAffiliation" class="form-select">
	                        <option value="본사">본사</option>
	                        <option value="가맹점">가맹점</option>
	                     </select>
						<!-- select 선택 끝 -->
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
                    <!-- saveNo 입력 
                    <div class="mb-3">
                        <label for="saveNo" class="form-label">직책 번호</label>
                        <input type="number" class="form-control" id="saveNo">
                    </div>
                     -->
                    <div class="mb-3">
                        <label for="saveName" class="form-label">직책 이름</label>
                        <input type="text" class="form-control" id="saveName">
                    </div>
					<div class="mb-3">
                        <label for="saveAffiliation" class="form-label">소속 이름</label>
<!--                    <input type="text" class="form-control" id="saveAffiliation"> -->
	                    <!-- select 선택 시작 -->
						 <select id="saveAffiliation" class="form-select">
                            <option value="" disabled selected>선택해주세요</option>
	                        <option value="본사">본사</option>
	                        <option value="가맹점">가맹점</option>
	                     </select>
						<!-- select 선택 끝 -->
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
		//폼 초기화
        //$('#saveNo').val(null);
        $('#saveName').val('');
        $('#saveAffiliation').val('');
        
        $('#saveModal').modal('show');
    });
    
    // 등록모달 저장 버튼 클릭 이벤트
    $('#Save').on('click', function() {
        //const no = $('#saveNo').val();
        const name = $('#saveName').val();
        const affiliation = $('#saveAffiliation').val();
        //console.log('입력한 직책 이름:', no);
        console.log('입력한 직책 이름:', name);
        console.log('입력한 직책 소속:', affiliation);

        if (!name || !affiliation) {
            alert('모든 값을 입력해야 합니다.');
            return;
        }

        // AJAX 호출 예시
        $.ajax({
            url: '/positionManage/create',
            method: 'POST',
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({ 
            	//positionNo: no,
            	positionNm: name,
            	positionAffiliation: affiliation
            }),
            success: function(response) {
	                alert('등록되었습니다.');
	                $('#saveModal').modal('hide');
	                location.reload(); //새로고침
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
        const no = selected.data('no');
        const name = selected.closest('tr').find('td:nth-child(2)').text();
        const affiliation = selected.closest('tr').find('td:nth-child(3)').text();
        console.log('선택된 부서정보:', { no, name, affiliation });
        
        $('#editNo').val(no);
        $('#editName').val(name);
        $('#editAffiliation').val(affiliation);
        
        $('#editModal').modal('show');
    });
    
    // 수정모달 저장 버튼 클릭 이벤트
    $('#saveEdit').on('click', function() {
        const no = $('#editNo').val();
        const name = $('#editName').val();
        const affiliation = $('#editAffiliation').val();
        
        // AJAX 호출 예시
        $.ajax({
            url: '/positionManage/update',
            method: 'POST',
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({ 
            	positionNo: no,
            	positionNm: name,
            	positionAffiliation: affiliation 
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
                url: '/positionManage/delete',
                method: 'POST',
                contentType:"application/json;charset=utf-8",
                data: JSON.stringify({ 
                	positionNo: no
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




