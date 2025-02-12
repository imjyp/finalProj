<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    
    
</head>
<body>   
    <sec:authorize access="isAuthenticated()"> 
    <%@ include file="./include/header.jsp" %>
    </sec:authorize>  
        <div id="main">
        <div>
    <%@ include file="./include/top.jsp" %>
                     
<div class="page-heading">
    <h3>Profile Statistics</h3>
</div> 
        <div class="card">
          <div class="card-header">
            
        
          <div class="card-body">
            <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
            <h4>메뉴 사진 슬라이드</h4>
              <ol class="carousel-indicators">
                <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class=""></li>
                <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" class="active" aria-current="true"></li>
                <li data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" class=""></li>
              </ol>
              <div class="carousel-inner">
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>First slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item active">
                  <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Second slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="..." style="max-height: 300px; object-fit: cover;">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Third slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
              </div>
              <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </a>
              <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </a>
            </div>
          </div>
        </div>
    <div  style="display:flex; gap:30px; align-items:center; flex-direction:row; justify-content: center">
    <div class="card col-md-6">
          <div class="card-header">
            <h4>소식</h4>
          </div>
          <div class="card-body">
            <div id="carouselExampleCaptions2" class="carousel slide" data-bs-ride="carousel">
              <ol class="carousel-indicators">
                <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="0" class=""></li>
                <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="1" class="active" aria-current="true"></li>
                <li data-bs-target="#carouselExampleCaptions2" data-bs-slide-to="2" class=""></li>
              </ol>
              <div class="carousel-inner">
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>First slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item active">
                  <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Second slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Third slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
              </div>
              <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </a>
              <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </a>
            </div>
          </div>
        </div>

      <div class="card col-md-6 ">
          <div class="card-header">
            <h4>이벤트</h4>
          </div>
          <div class="card-body">
            <div id="carouselExampleCaptions3" class="carousel slide" data-bs-ride="carousel">
              <ol class="carousel-indicators">
                <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="0" class=""></li>
                <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="1" class="active" aria-current="true"></li>
                <li data-bs-target="#carouselExampleCaptions3" data-bs-slide-to="2" class=""></li>
              </ol>
              <div class="carousel-inner">
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/1.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>First slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item active">
                  <img src="./dist/assets/compiled/png/2.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Second slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
                <div class="carousel-item">
                  <img src="./dist/assets/compiled/png/3.png" class="d-block w-100" alt="...">
                  <div class="carousel-caption d-none d-md-block">
                    <h5>Third slide label</h5>
                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                  </div>
                </div>
              </div>
              <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </a>
              <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </a>
            </div>
          </div>
        </div>
       </div> 
       </div> 
     </div>   
      
<%@ include file="./include/footer.jsp" %>

</body>

</html>