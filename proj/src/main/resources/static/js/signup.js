$(function() {

	// 버튼 클릭 이벤트
    $(".dataInput").click(function(event) {
        event.preventDefault(); // 기본 이벤트(링크 이동) 방지

        // 자동 입력할 데이터
        $("#userBirth").val("1995-03-29"); // 생일
        $("#emailId").val("wlscks8544"); // 이메일 ID
        $("#emailDomain").val("naver.com"); // 이메일 도메인 선택
        // $("#userZip").val("34908"); // 우편번호
        // $("#userAddr1").val("서울특별시 강남구"); // 기본 주소
        // $("#userAddr2").val("테헤란로 123"); // 상세 주소
        $("#userIndate").val("2025-02-05"); // 입사일

        // 이메일 전체 주소 자동 설정
        $("#userMail").val($("#emailId").val() + "@" + $("#emailDomain").val());

        // 직책 자동 선택 (첫 번째 옵션 선택)
        // $("#positionNo").prop("selectedIndex", 1);

        // 가맹점 선택 시 가맹점 번호와 이름 자동 입력
        if ($("#store").is(":visible")) {
            $("input[name='storeNo']").val("1");
            $("input[name='storeNm']").val("대전둔산점");
        }
    });
	
    // 아이디 중복 체크
    $("#btnIdDupChk").on("click", function(){
        let userNo = $.trim($("#userNo").val());
        console.log("userNo: " + userNo);
        
        if(userNo === ""){
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: '아이디를 입력해주세요'
            });
            $("#userNo").focus();
            return;
        }
        
        let data = { "userNo": userNo };
        console.log("data:", data);

        $.ajax({
            url: "/idDupChk",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "text",  // 서버가 숫자 혹은 문자열로 응답할 경우
            success: function(result) {
                console.log("서버 응답:", result);
                var Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000
                });
                if(result == 1) {
                    console.log("아이디 중복됨");
                    Toast.fire({
                        icon: 'warning',
                        title: '아이디가 중복되었습니다.'
                    });
                    $("#userNo").focus();
                } else {
                    console.log("아이디 중복 안됨");
                    Toast.fire({
                        icon: 'success',
                        title: '아이디 사용이 가능합니다.'
                    });
                    $("#userPw").focus();
                }
            },
            error: function(xhr, status, error) {
                console.error("에러 발생:", error);
            }
        });
    });

    // 아이디 유효성 검사 (영문, 숫자 조합 4~15자)
    $("#userNo").on("blur", function() {
        var userId = $.trim($(this).val());
		console.log("userId: [" + userId + "], length: " + userId.length);
        var idRegex = /^[A-Za-z0-9]{4,15}$/;
        if (!idRegex.test(userId)) {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: '아이디는 영문과 숫자 조합으로 4자 이상 15자 이하로 입력해주세요.'
            });
           // $(this).focus();
        }
    });

    // 비밀번호 유효성 검사 (8자 이상, 영문, 숫자, 특수문자 포함)
    $("#userPw").on("blur", function() {
        var password = $.trim($(this).val());
        var pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$/;
        if (!pwRegex.test(password)) {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: '비밀번호는 8자 이상이며, 영문, 숫자, 특수문자를 포함해야 합니다.'
            });
           // $(this).focus();
        }
    });

    // 비밀번호 확인 검사 (비밀번호와 일치하는지)
    $('input[name="userPwCheck"]').on("blur", function() {
        var password = $.trim($("#userPw").val());
        var confirmPassword = $.trim($(this).val());
        var Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000
        });
        if (password !== confirmPassword) {
            Toast.fire({
                icon: 'warning',
                title: '비밀번호가 일치하지 않습니다.'
            });
           // $(this).focus();
        } else {
            Toast.fire({
                icon: 'success',
                title: '비밀번호 확인 완료'
            });
        }
    });

	// 연락처 합치기
    $("form").on("submit", function(event) {
        const fullPhone = $("input[name='userPhone1']").val() + $("input[name='userPhone2']").val() + $("input[name='userPhone3']").val();
        $("#userPhone").val(fullPhone);
    });

    // 이메일 도메인 선택에 따른 '직접 입력' 필드 보이기/숨기기
    $("#emailDomain").on("change", function() {
        const customDomainField = $("#customEmailDomain");
        if ($(this).val() === "custom") {
            customDomainField.show().prop("required", true);
        } else {
            customDomainField.hide().prop("required", false);
        }
    });

    // 폼 제출 전에 이메일 값 처리
    $("form").on("submit", function(event) {
        const emailId = $("#emailId").val().trim();
        const emailDomain = $("#emailDomain").val();
        const customDomain = $("#customEmailDomain").val().trim();

        if (!emailId) {
            showToast("warning", "이메일을 입력해주세요");
            $("#emailId").focus();
            return;
        }

        let finalDomain = emailDomain === "custom" && customDomain ? customDomain : emailDomain;

        if (!finalDomain) {
            showToast("warning", "이메일 도메인을 선택해주세요");
            $("#emailDomain").focus();
            return;
        }

        $("#userMail").val(`${emailId}@${finalDomain}`);
    });
	
	

    // 다음 우편번호 검색
    $("#btnPost").on("click", function() {
        console.log("우편번호 체킁");
        new daum.Postcode({
            oncomplete: function(data) {
                console.log(data);
                $("#userZip").val(data.zonecode);
                $("#userAddr1").val(data.address);
                $("#userAddr2").val(data.buildingName);
            }
        }).open();

        $("#bonsa").addClass("show active");
        $("#store").removeClass("show active");

        $("#bonsa-tab, #store-tab").on("click", function() {
            const activeTab = $(this).attr("id");
            if(activeTab === "bonsa-tab") {
                resetForm("bonsaForm");
            } else if(activeTab === "store-tab") {
                resetForm("storeForm");
            }
        });

        function resetForm(formId) {
            $(`#${formId}`)[0].reset();
            $("#customEmailDomain").hide().prop("required", false);
            $("#fullEmail").val("");
        }
    });

});
