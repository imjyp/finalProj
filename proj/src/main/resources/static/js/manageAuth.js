$(function() {
    // 권한 수정 버튼 클릭 시
    $(".editAuthBtn").on("click", function() {
	    const userNo = $(this).data("user-no");
	    const userCode = $(this).data("user-code");
	    const deptNm = $(this).data("dept-nm");
	    const storeNm = $(this).data("store-nm");
	    const positionNm = $(this).data("position-nm");
	    const authName = $(this).data("auth-name");
	    const enabled = $(this).data("enabled");
	
	    
	    console.log(userNo, userCode, deptNm, storeNm, positionNm, authName, enabled);
	
	    // 모달에 값 채우기
	    $("#modalUserNo").val(userNo);
	    $("#modalType").val(userCode === 1 || userCode === 3 ? "본사" : "가맹점");
	    
	 	// 부서 및 가맹점 이름 처리
	    if (userCode === 2 || userCode === 4) {
	        $("#modalStoreNm").val(storeNm); // 가맹점-가맹점 이름
	        $("#deptDiv").css("display", "none"); 
	        $("#storeDiv").css("display", "block"); 
	    } else {
	    	$("#modalDeptNm").val(deptNm); // 본사-부서
	        $("#deptDiv").css("display", "block"); 
	        $("#storeDiv").css("display", "none");
	    }
	    
	    $("#modalPositionNm").val(positionNm);
	    $("#modalAuthName").val(authName);
	    $("#modalEnabled").val(enabled);
	
	    // 모달 띄우기
	    $("#editAuthModal").modal("show");
	});


    // 권한 변경 저장 버튼 클릭 시
    $("#saveAuthChanges").on("click", function() {
        const userNo = $("#modalUserNo").val();
        const authName = $("#modalAuthName").val();
        const enabled = $("#modalEnabled").val();
        const positionNm = $("#modalPositionNm").val();
        const storeNm = $("#modalStoreNm").val();

        
        $.ajax({
            url: '/sys/updateUserAuth',
            method: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify({
                userNo: userNo,
                authName: authName,
                enabled: enabled,
                positionNm: positionNm,
                storeNm: storeNm
            }),
            success: function(response) {
                Swal.fire({
                    icon: 'success',
                    title: '권한이 수정되었습니다.'
                });
                location.reload();  
            },
            error: function() {
                Swal.fire({
                    icon: 'error',
                    title: '권한 수정에 실패했습니다.'
                });
            }
        });
    });
  
  // 검색 - 엔터 키 
    $("#search").on("keydown", function(event) {
        if (event.keyCode === 13) { 
            const keyword = $("#krd").val();
            ajax(keyword, 1);
        }
    });

    // 대분류 변경 시 중분류 옵션 업데이트
    $('#mainCategory').on('change', function() {
		const selected = $(this).val();
		let options = '';
		
		if(selected == 'type'){
			options = '<option value="본사">본사</option><option value="가맹점">가맹점</option>';
		}else if (selected === 'dept') {
	        options = '<option value="경영">경영본부</option><option value="인사/행정">인사/행정과</option><option value="재정/회계">재정/회계과</option><option value="전략/기획">전략/기획과</option><option value="물류">물류과</option>';
	    } else if (selected === 'position') {
	        options = '<option value="본부장">본부장</option><option value="과장">과장</option><option value="사원">사원</option><option value="점주">가맹점주</option><option value="매니저">매니저</option><option value="알바">알바</option>';
	    }
	    
	    $('#subCategory').html(options);
	    
    });
});

	// 체크박스
	/*   전체 선택 체크박스 클릭 시
    $("#masterCheckbox").on("change", function () {
        const isChecked = $(this).is(":checked");
        $("input[name='customCheck']").prop("checked", isChecked);
    });

    // 개별 체크박스 클릭 시
    $("input[name='customCheck']").on("change", function () {
        const total = $("input[name='customCheck']").length; // 전체 체크박스 개수
        const checked = $("input[name='customCheck']:checked").length; // 선택된 체크박스 개수

        // 전체 선택 체크박스 상태 갱신
        $("#masterCheckbox").prop("checked", total === checked);
    });
    
	*/