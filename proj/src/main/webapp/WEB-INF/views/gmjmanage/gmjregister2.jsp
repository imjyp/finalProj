<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>가맹점 관리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .search-container input {
            width: 300px;
        }
        .table th, .table td {
            vertical-align: middle;
            white-space: nowrap;  
            padding: 8px;         
        }
        .table {
            min-width: 100%;     
            margin-left: 10px;    
        }
        .pagination {
            margin-bottom: 0;
        }
        .main-content {
            padding: 50px;
            margin-left: 300px;  
        }
        .page-heading {
            margin-bottom: 20px;
        }
        .modal-dialog {
            max-width: 600px;
        }
        .table-responsive {
            overflow-x: auto;    
            padding-left: 15px;  
        }
        .checkbox-column {
            width: 40px;        
            min-width: 40px;    
            text-align: center; 
        }
        .action-column {
            width: 120px;       
            min-width: 120px;   
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/include/header.jsp"%>
    
    <div class="container-fluid">
        <div class="main-content">
        <%@ include file="./include/top.jsp" %>
            <div class="page-heading">
                <h3>가맹점 관리</h3>
            </div>
            
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h4>가맹점 목록</h4>
                                <div class="search-container">
                                    <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요">
                                    <button class="btn btn-primary" onclick="searchGmj()">검색</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th class="checkbox-column">
                                                <input type="checkbox" class="form-check-input" id="selectAll">
                                            </th>
                                            <th>가맹점 번호</th>
                                            <th>가맹점 이름</th>
                                            <th>가맹점 주소</th>
                                            <th>우편번호</th>
                                            <th class="action-column">보기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="gmj" items="${gmjList}">
                                            <tr>
                                                <td class="checkbox-column">
                                                    <input type="checkbox" class="form-check-input gmj-check" value="${gmj.storeNo}">
                                                </td>
                                                <td>${gmj.storeNo}</td>
                                                <td>${gmj.storeNm}</td>
                                                <td>${gmj.storeAddr1}</td>
                                                <td>${gmj.storeZip}</td>
                                                <td class="action-column">
                                                    <button class="btn btn-sm btn-info" onclick="viewGmjDetail(${gmj.storeNo})">상세</button>
                                                    <button class="btn btn-sm btn-warning" onclick="editGmj(${gmj.storeNo})">수정</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- 페이지네이션 -->
                           <div class="d-flex justify-content-center mt-4">
							    <nav aria-label="Page navigation">
							        <ul class="pagination">
							            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
							                <a class="page-link" href="/gmj/register?page=1&size=10"><<</a>
							            </li>
							            <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>">
							                <a class="page-link" href="/gmj/register?page=${currentPage - 1}&size=10"><</a>
							            </li>
							            <c:forEach var="i" begin="1" end="${totalPages}">
							                <li class="page-item <c:if test='${currentPage == i}'>active</c:if>">
							                    <a class="page-link" href="/gmj/register?page=${i}&size=10">${i}</a>
							                </li>
							            </c:forEach>
							            <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
							                <a class="page-link" href="/gmj/register?page=${currentPage + 1}&size=10">></a>
							            </li>
							            <li class="page-item <c:if test='${currentPage == totalPages}'>disabled</c:if>">
							                <a class="page-link" href="/gmj/register?page=${totalPages}&size=10">>></a>
							            </li>
							        </ul>
							    </nav>
							</div>
                            
                            <div class="d-flex justify-content-end mt-3 gap-2">
                                <button class="btn btn-danger" onclick="deleteSelectedGmj()">삭제</button>
                                <button class="btn btn-primary" onclick="openNewGmjModal()">가맹점 등록</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 가맹점 등록/수정 모달 -->
    <div class="modal fade" id="gmjModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">가맹점 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="gmjForm">
                        <input type="hidden" id="storeNo" name="storeNo">
                        <div class="mb-3">
                            <label class="form-label">가맹점 이름</label>
                            <input type="text" class="form-control" id="storeNm" name="storeNm" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">주소</label>
                            <input type="text" class="form-control" id="storeAddr1" name="storeAddr1" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">상세주소</label>
                            <input type="text" class="form-control" id="storeAddr2" name="storeAddr2">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">우편번호</label>
                            <input type="number" class="form-control" id="storeZip" name="storeZip" required>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">위도</label>
                                <input type="number" class="form-control" id="storeLat" name="storeLat">
                            </div>
                            <div class="col">
                                <label class="form-label">경도</label>
                                <input type="number" class="form-control" id="storeLot" name="storeLot">
                            </div>
                        </div>
                        <div class="row mb-3">
                        	<!-- 카카오맵 영역 -->
                        	<div id="map" style="width:500px;height:400px;"></div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" onclick="saveGmj()">저장</button>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86230698ce774a3d05d0780b53b5009b"></script>
    <script type="text/javascript">
        let gmjModal;
        
        //카카오맵 불러오기 시작 /////////////////////
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(36.32501909047191, 127.40864264918022), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
		
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		//카카오맵 불러오기 끝 /////////////////////
		
		//카카오맵 클릭 위치 가져오기 시작 ///////////////////
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    console.log("message : ", message);
		    
		    $("#storeLat").val(latlng.getLat());
		    $("#storeLot").val(latlng.getLng());
		    
// 		    var resultDiv = document.getElementById('clickLatlng'); 
// 		    resultDiv.innerHTML = message;
		    
		});
		//카카오맵 클릭 위치 가져오기 시작 ///////////////////
		
		
        
        $(document).ready(function() {
            gmjModal = new bootstrap.Modal(document.getElementById('gmjModal'));
            
            $('#selectAll').change(function() {
                $('.gmj-check').prop('checked', $(this).prop('checked'));
            });

            $('.gmj-check').change(function() {
                var allChecked = $('.gmj-check:checked').length === $('.gmj-check').length;
                $('#selectAll').prop('checked', allChecked);
            });

            // Add event listener for Enter key in search input
            $('#searchInput').keypress(function(e) {
                if (e.which == 13) {
                    searchGmj();
                }
            });
        });

        function searchGmj() {
            var searchTerm = $('#searchInput').val().trim();
            
            if (!searchTerm) {
                alert('검색어를 입력하세요.');
                return;
            }
            
            $.ajax({
                url: '/gmj/search',
                type: 'GET',
                data: { keyword: searchTerm },
                success: function(response) {
                    var tbody = $('tbody');
                    tbody.empty();
                    
                    if (!response || response.length === 0) {
                        tbody.append(`
                            <tr>
                                <td colspan="6" class="text-center">검색 결과가 없습니다.</td>
                            </tr>
                        `);
                    } else {
                        response.forEach(function(gmj) {
                            var row = `
                                <tr>
                                    <td class="checkbox-column">
                                        <input type="checkbox" class="form-check-input gmj-check" value="\${gmj.storeNo}">
                                    </td>
                                    <td>\${gmj.storeNo || ''}</td>
                                    <td>\${gmj.storeNm || ''}</td>
                                    <td>\${gmj.storeAddr1 || ''}</td>
                                    <td>\${gmj.storeZip || ''}</td>
                                    <td class="action-column">
                                        <button class="btn btn-sm btn-info" onclick="viewGmjDetail('\${gmj.storeNo}')">상세</button>
                                        <button class="btn btn-sm btn-warning" onclick="editGmj('\${gmj.storeNo}')">수정</button>
                                    </td>
                                </tr>
                            `;
                            tbody.append(row);
                        });
                    }
                    
                    // 페이지네이션 숨기기
                    $('.pagination').parent().hide();
                    
                    // 검색 결과가 있을 때 체크박스 이벤트 다시 바인딩
                    if (response && response.length > 0) {
                        $('.gmj-check').change(function() {
                            var allChecked = $('.gmj-check:checked').length === $('.gmj-check').length;
                            $('#selectAll').prop('checked', allChecked);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error('검색 오류:', error);
                    alert('검색 중 오류가 발생했습니다.');
                    var tbody = $('tbody');
                    tbody.empty().append(`
                        <tr>
                            <td colspan="6" class="text-center">검색 중 오류가 발생했습니다.</td>
                        </tr>
                    `);
                }
            });
        }

   
        function deleteSelectedGmj() {
            var selectedGmj = [];
            $('.gmj-check:checked').each(function() {
                selectedGmj.push($(this).val());
            });

            if (selectedGmj.length === 0) {
                alert('삭제할 가맹점을 선택해주세요.');
                return;
            }

            if (confirm('선택한 ' + selectedGmj.length + '개의 가맹점을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '/gmj/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(selectedGmj),
                    success: function(response) {
                        alert('선택한 가맹점이 삭제되었습니다.');
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('삭제 중 오류가 발생했습니다.');
                        console.error('Error:', error);
                    }
                });
            }
        }

        function viewGmjDetail(storeNo) {
            $.ajax({
                url: '/gmj/detail',
                type: 'GET',
                data: { storeNo: storeNo },
                success: function(response) {
                    fillGmjForm(response);
                    $('#modalTitle').text('가맹점 상세 정보');
                    $('#gmjForm input').prop('readonly', true);
                    $('.modal-footer').hide();
                    gmjModal.show();
                },
                error: function(xhr, status, error) {
                    alert('상세 정보 조회 중 오류가 발생했습니다.');
                    console.error('Error:', error);
                }
            });
        }

        function editGmj(storeNo) {
            $.get('/gmj/detail', { storeNo: storeNo })
                .done(function(response) {
                    fillGmjForm(response);
                    $('#modalTitle').text('가맹점 수정');
                    $('#gmjForm input').prop('readonly', false);
                    $('.modal-footer').show();
                    gmjModal.show();
                })
                .fail(function(error) {
                    alert('가맹점 정보 조회 중 오류가 발생했습니다.');
                    console.error('Error:', error);
                });
        }

        function openNewGmjModal() {
            $('#gmjForm')[0].reset();
            $('#storeNo').val('');
            $('#modalTitle').text('가맹점 등록');
            $('#gmjForm input').prop('readonly', false);
            $('.modal-footer').show();
            gmjModal.show();
        }

        function fillGmjForm(data) {
            $('#storeNo').val(data.storeNo);
            $('#storeNm').val(data.storeNm);
            $('#storeAddr1').val(data.storeAddr1);
            $('#storeAddr2').val(data.storeAddr2);
            $('#storeZip').val(data.storeZip);
            $('#storeLat').val(data.storeLat);
            $('#storeLot').val(data.storeLot);
        }

        function validateForm() {
            if (!$('#storeNm').val().trim()) {
                alert('가맹점 이름을 입력하세요.');
                $('#storeNm').focus();
                return false;
            }
            if (!$('#storeAddr1').val().trim()) {
                alert('주소를 입력하세요.');
                $('#storeAddr1').focus();
                return false;
            }
            if (!$('#storeZip').val().trim()) {
                alert('우편번호를 입력하세요.');
                $('#storeZip').focus();
                return false;
            }
            return true;
        }

        function saveGmj() {
            if (!validateForm()) {
                return;
            }

            var formData = {
                storeNm: $('#storeNm').val(),
                storeAddr1: $('#storeAddr1').val(),
                storeAddr2: $('#storeAddr2').val(),
                storeZip: parseInt($('#storeZip').val()) || 0,
                storeLat: parseInt($('#storeLat').val()) || 0,
                storeLot: parseInt($('#storeLot').val()) || 0
            };

            if ($('#storeNo').val()) {
                formData.storeNo = parseInt($('#storeNo').val());
            }

            var url = formData.storeNo ? '/gmj/update' : '/gmj/insert';
            
            $.ajax({
                url: url,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    alert('저장되었습니다.');
                    location.reload();
                },
                error: function(xhr, status, error) {
                    alert('저장 중 오류가 발생했습니다.');
                    console.error('Error:', error);
                    console.error('Response:', xhr.responseText);
                }
            });
        }
    </script>
</body>
</html>