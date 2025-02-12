<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>
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

<!-- 시작 -->
<div id="main">
<%@ include file="../include/top.jsp" %>
	 <div class="card">
	     <div class="card-header">
	         <h1 class="card-title"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">직책관리</font></font></h4>
	     </div>
	     <div class="card-content">
	         <!-- table striped -->
	         <div class="table-responsive">
	             <table class="table table-striped mb-0">
	                 <thead>
	                     <tr>
	                     	<th><input type="radio" id="selectAll"></th>
	                     	<th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">번호</font></font></th>
	                         <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">직책번호</font></font></th>
	                         <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">직책이름</font></font></th>
	                         <th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">소속</font></font></th>
	                     </tr>
	                 </thead>
	                 <tbody>
	                 	<c:forEach var="position" items="${positionList}" varStatus="status">
	                     	<tr>
	             				<td class="text-bold-500"><input class="form-check-input selectRow" type="radio" name="flexRadioDefault" data-no="${position.positionNo}"></td>
	             				<td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${status.index +1}</font></font></td>
								<td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${position.positionNo}</font></font></td>
	                          	<td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${position.positionNm}</font></font></td>
	                          	<td class="text-bold-500"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${position.positionAffiliation}</font></font></td>
	                          	
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
	     <div class="buttons">
	     	<button id="saveButton" class="btn btn-primary">등록</button>
			<button id="editButton" class="btn btn-primary">수정</button>
			<button id="deleteButton" class="btn btn-danger">삭제</button>
		</div>
	 </div>
</div>


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
                        <input type="text" class="form-control" id="editAffiliation">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="saveEdit">저장</button>
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
                    <div class="mb-3">
                        <label for="saveNo" class="form-label">직책 번호</label>
                        <input type="number" class="form-control" id="saveNo">
                    </div>
                    <div class="mb-3">
                        <label for="saveName" class="form-label">직책 이름</label>
                        <input type="text" class="form-control" id="saveName">
                    </div>
					<div class="mb-3">
                        <label for="saveAffiliation" class="form-label">소속 이름</label>
                        <input type="text" class="form-control" id="saveAffiliation">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="Save">저장</button>
            </div>
        </div>
    </div>
</div>

	
<script>
$(function() {
	// 등록 버튼 클릭 이벤트
	$('#saveButton').on('click', function() {
        const no = null;
        const name = "";
        const affiliation = "";
        
        $('#saveNo').val(no);
        $('#saveName').val(name);
        $('#saveAffiliation').val(affiliation);
        
        $('#saveModal').modal('show');
    });
    
    // 등록모달 저장 버튼 클릭 이벤트
    $('#Save').on('click', function() {
        const no = $('#saveNo').val();
        const name = $('#saveName').val();
        const affiliation = $('#saveAffiliation').val();
        alert('affiliation 등록값 : '+affiliation);
        
        if (!no || !name) {
            alert('모든 값을 입력해야 합니다.');
            return;
        }

        // AJAX 호출 예시
        $.ajax({
            url: '/positionManage/create',
            method: 'POST',
            contentType:"application/json;charset=utf-8",
            data: JSON.stringify({ 
            	positionNo: no,
            	positionNm: name,
            	positionAffiliation: affiliation
            }),
            success: function(response) {
            	 if (response === "DUPLICATE") {
                     alert('이미 존재하는 직책 번호입니다.');
                 } else if (response === "SUCCESS") {
	                alert('등록되었습니다.');
	                $('#saveModal').modal('hide');
	                location.reload();
                 }
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
        const name = selected.closest('tr').find('td:nth-child(4)').text();
        const affiliation = selected.closest('tr').find('td:nth-child(5)').text();
        
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




