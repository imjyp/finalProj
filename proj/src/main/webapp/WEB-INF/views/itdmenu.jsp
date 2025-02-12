<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 소개</title>
       <link rel="stylesheet" href="/css/common2.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>

        .category-tabs {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .category-tab {
            padding: 0.75rem 1.5rem;
            border: 2px solid;
            border-radius: 2rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .category-tab:hover {
            background: var(--primary-color);
            color: white;
        }

        .category-tab.active {
            background: var(--primary-color);
            color: white;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            padding: 1rem;
        }
        .menu-image {
		    width: 100%; /* 부모 요소에 맞게 조정 */
		    height: 250px; /* 동일한 높이 설정 */
		    object-fit: cover; /* 비율을 유지하면서 크롭 */
		    border-radius: 10px; /* 부드러운 모서리 */
		    display: block; /* 가운데 정렬을 위해 block 처리 */
		    margin: 0 auto; /* 중앙 정렬 */
		}

		  #main {
			  margin-top: 140px; 
			}      

        .menus{
        	border:solid 1px white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .menu-item:hover {
            transform: translateY(-5px);
        }

        .menu-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .menu-info {
            padding: 1.5rem;
        }

        .menu-name {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .menu-description {
            color: #6b7280;
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .menu-price {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1.25rem;
        }

        .menu-tags {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }
        

        .menu-tag {
            background: var(--secondary-color);
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.875rem;
            color: #4b5563;
        }

        .special-badge {
            background: var(--accent-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.875rem;
            position: absolute;
            top: 1rem;
            right: 1rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .header h1 {
                font-size: 2rem;
            }

            .menu-grid {
                grid-template-columns: 1fr;
            }
        }

        .search-bar {
            margin-bottom: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .search-input {
            padding: 0.75rem 1.5rem;
            border: 2px solid var(--secondary-color);
            border-radius: 2rem;
            width: 100%;
            max-width: 400px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--primary-color);
        }

        .menu-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--secondary-color);
        }

        .menu-button {
            padding: 0.5rem 1rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .menu-button:hover {
            background-color: #1d4ed8;
        }

        .favorite-button {
            background: none;
            border: none;
            color: #ef4444;
            cursor: pointer;
            font-size: 1.25rem;
            transition: transform 0.3s ease;
        }

        .favorite-button:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>
<%@ include file="./include/header.jsp"%>

    <div id="main">
    <%@ include file="./include/top.jsp" %>
    
    	<header class="mb-3">
		<a href="#" class="burger-btn d-block d-xl-none"><i
			class="bi bi-justify fs-3"></i></a>
	</header>
	
		<div class="row mb-2 align-items-center">
         <ol class="breadcrumb float-sm-end">
            <li class="breadcrumb-item" style="font-size:2rem"><a href="/main">Home</a></li>
            <li class="breadcrumb-item active" style="font-size:2rem"><a href="/itdmenu">메뉴 소개</a></li>
         </ol>
   </div>
   

        <div class="search-bar">
        <input class="form-control form-control-lg search-input" type="text" placeholder="검색">
        </div>

        <div class="category-tabs" style="margin-bottom:60px">
        
        <a href="#" class="btn btn-outline-dark category-tab"  data-category="0">전체</a>
        <a href="#" class="btn btn-outline-dark  category-tab" data-category="1">신메뉴</a>
        <a href="#" class="btn btn-outline-dark category-tab" data-category="2">커피</a>
        <a href="#" class="btn btn-outline-dark category-tab" data-category="3">음료</a>
        <a href="#" class="btn btn-outline-dark category-tab" data-category="4">티</a>
        <a href="#" class="btn btn-outline-dark category-tab" data-category="5">디저트</a>
        </div>
        <div class="menu-grid">
            <c:forEach var="menu" items="${menuList}">
			
			    <div class="menu-item menus" style="border:1px solid; padding:20px" data-category="${menu.ctgryNo}">
			        <h3 class="menu-name">${menu.menuNm}</h3>
			
			        <c:if test="${not empty menu.fileDetailList and not empty menu.fileDetailList[0].fileSaveLocate}">
			            <p><img  class="menu-image"  src="/resources${menu.fileDetailList[0].fileSaveLocate}" style="width:50%;" /></p>
			        </c:if>
			
			        <p class="menu-description">${menu.menuCn}</p>
			        <span class="menu-price">₩${menu.menuPrice}</span>
			        <div class="menu-category" style="display:none;">${menu.ctgryNo}</div>
			        <div class="menu-category-name" style="display:none;">${menu.ctgryNm}</div>
			    </div>
			</c:forEach>

        </div>
    </div>
<!-- </div> -->
<%@ include file="./include/footer.jsp" %>
    <script>
        // 카테고리 필터링 기능
        document.querySelectorAll('.category-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                // 활성 탭 스타일 변경
                document.querySelectorAll('.category-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                
                // 선택된 카테고리 값
                const selectedCategory = this.getAttribute('data-category');
                
                // 메뉴 아이템 필터링
                document.querySelectorAll('.menu-item').forEach(item => {
                    if (selectedCategory === '0' || item.getAttribute('data-category') === selectedCategory) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });

        // 검색 기능 개선
        const searchInput = document.querySelector('.search-input');
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const activeCategory = document.querySelector('.category-tab.active').getAttribute('data-category');
            
            document.querySelectorAll('.menu-item').forEach(item => {
                const menuName = item.querySelector('.menu-name').textContent.toLowerCase();
                const menuDesc = item.querySelector('.menu-description').textContent.toLowerCase();
                const itemCategory = item.getAttribute('data-category');
                
                // 카테고리와 검색어 모두 일치하는 경우에만 표시
                const matchesSearch = menuName.includes(searchTerm) || menuDesc.includes(searchTerm);
                const matchesCategory = activeCategory === '0' || itemCategory === activeCategory;
                
                if (matchesSearch && matchesCategory) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>

