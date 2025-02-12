package kr.or.ddit.util;

import java.util.List;
import java.util.Map;

//페이징 관련 정보 + 게시글 정보
			//			LprodVO
public class ArticlePage<T> {
	//전체글 수(135)
	private int total;
	// 현재 페이지 번호
	private int currentPage;
	// 전체 페이지수 
	private int totalPages;
	// 블록의 시작 페이지 번호
	private int startPage;
	//블록의 종료 페이지 번호
	private int endPage;
	//검색어
	private String keyword = "";
	//다중검색
	private Map<String,Object> searchMap;
	//요청URL
	private String url = "";
	//select 결과 데이터
	//			LprodVO
	private List<T> content;
	//페이징 처리
	private String pagingArea = "";
	
	//동기 방식
	//생성자(Constructor) : 페이징 정보를 생성
	//					  287			1				10   lprodVOList			 "" 또는 "도서"
	public ArticlePage(int total, int currentPage, int size, List<T> content, String keyword) {
		//size : 한 화면에 보여질 목록의 행 수
		this.total = total;//287
		this.currentPage = currentPage;//1
		this.keyword = keyword;//""
		this.content = content;//lprodVOList
		
		//1. 전체 페이지 수
		//1-1) 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
		this.totalPages = this.total / size;//287 / 10 => 28.7 => 28
		//1-2) 나머지가 있다면(287 / 10 => 28.7), 페이지를 1 증가
		if(this.total % size > 0) {
			this.totalPages++;	//29
		}
		
		//2. 블록 시작번호
		//2-1) 페이지 블록 시작번호를 구하는 공식
		//	   블록시작번호 = 현재페이지 / 블록크기 * 블록크기 + 1
		this.startPage = this.currentPage / 5 * 5 + 1; //1 / 5 * 5 + 1 => 1
		// [1] [2] [3] [4] [5]
		
		//2-2) 현재페이지 % 블록의크기 => 0일 때 보정
		if(this.currentPage % 5 == 0) { //1 % 5
			this.startPage -= 5;
		}
		
		//3. 블록 종료번호
		//3-1) 블록종료번호 = 시작페이지번호 + (블록크기 - 1)
		//	  [1][2][3][4][5][다음]
		this.endPage = this.startPage + (5 - 1); // 1 + 4 => 5
		
		//3-2) 블록종료번호 > 전체페이지수
		if(this.endPage > this.totalPages) {	// 5 > 29 => false
			this.endPage = this.totalPages;
		}
		
		//4. 페이징 블록 시작 /////////
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination justify-content:center;'>";
		pagingArea += "<li class='paginate_button page-item previous "; 
		if(this.startPage<6) {
			pagingArea += "disabled ";
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='"+this.url+"?currentPage="+(this.startPage-5)+"&keyword="+this.keyword+"' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += "class='page-link'>Previous</a></li>";
		
		for(int pNo=this.startPage;pNo<=this.endPage;pNo++) {		
		pagingArea += "<li class='paginate_button page-item ";
			if(this.currentPage == pNo) {
				pagingArea += "active";
			}
			pagingArea += "'>";
			pagingArea += "<a href='"+this.url+"?currentPage="+pNo+"&keyword="+this.keyword+"' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += "class='page-link'>"+pNo+"</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next "; 
		if(this.endPage>=this.totalPages) {
			pagingArea += "disabled";
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='"+this.url+"?currentPage="+(this.startPage+5)+"&keyword="+this.keyword+"' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";
		//4. 페이징 블록 끝 /////////
	}//end ArticlePage
	
	//비동기 방식
	//생성자(Constructor) : 페이징 정보를 생성
	//오버로딩 : 동일한 클래스 내에서 같은 이름의 메소드를 여러번 사용(매개변수의 개수, 매개변수의 타입을 다르게 함)
	//					  287			1				10   lprodVOList	 "" 또는 "도서"  ajax
	public ArticlePage(int total, int currentPage, int size, List<T> content
				, String keyword, String mode) {
		//size : 한 화면에 보여질 목록의 행 수
		this.total = total;//287
		this.currentPage = currentPage;//1
		this.keyword = keyword;//""
		this.content = content;//lprodVOList
		
		//1. 전체 페이지 수
		//1-1) 전체 페이지 수 = 전체글 수 / 한 화면에 보여질 목록의 행 수
		this.totalPages = this.total / size;//287 / 10 => 28.7 => 28
		//1-2) 나머지가 있다면(287 / 10 => 28.7), 페이지를 1 증가
		if(this.total % size > 0) {
			this.totalPages++;	//29
		}
		
		//2. 블록 시작번호
		//2-1) 페이지 블록 시작번호를 구하는 공식
		//	   블록시작번호 = 현재페이지 / 블록크기 * 블록크기 + 1
		this.startPage = this.currentPage / 5 * 5 + 1; //1 / 5 * 5 + 1 => 1
		// [1] [2] [3] [4] [5]
		
		//2-2) 현재페이지 % 블록의크기 => 0일 때 보정
		if(this.currentPage % 5 == 0) { //1 % 5
			this.startPage -= 5;
		}
		
		//3. 블록 종료번호
		//3-1) 블록종료번호 = 시작페이지번호 + (블록크기 - 1)
		//	  [1][2][3][4][5][다음]
		this.endPage = this.startPage + (5 - 1); // 1 + 4 => 5
		
		//3-2) 블록종료번호 > 전체페이지수
		if(this.endPage > this.totalPages) {	// 5 > 29 => false
			this.endPage = this.totalPages;
		}
		
		//4. 페이징 블록 시작 /////////
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers' id='example2_paginate'>";
		pagingArea += "<ul class='pagination justify-content:center;'>";
		pagingArea += "<li class='paginate_button page-item previous "; 
		if(this.startPage<6) {
			pagingArea += "disabled ";
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='#' data-current-page='"+(this.startPage-5)+
				"' data-keyword='"+this.keyword+"' aria-controls='example2' data-dt-idx='0' tabindex='0' ";
		pagingArea += " class='page-link clsPagingArea'>Previous</a></li>";
		
		for(int pNo=this.startPage;pNo<=this.endPage;pNo++) {		
			pagingArea += "<li class='paginate_button page-item ";
			if(this.currentPage == pNo) {
				pagingArea += "active";
			}
			pagingArea += "'>";
			pagingArea += "<a href='#' data-current-page='"+pNo+
					"' data-keyword='"+this.keyword+"' aria-controls='example2' data-dt-idx='1' tabindex='0' ";
			pagingArea += " class='page-link clsPagingArea'>"+pNo+"</a>";
			pagingArea += "</li>";
		}
		pagingArea += "<li class='paginate_button page-item next "; 
		if(this.endPage>=this.totalPages) {
			pagingArea += "disabled";
		}
		pagingArea += "' id='example2_next'><a ";
		pagingArea += "href='#' data-current-page='"+(this.startPage+5)+
				"' data-keyword='"+this.keyword+"' aria-controls='example2' data-dt-idx='7' ";
		pagingArea += " tabindex='0' class='page-link clsPagingArea'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";
		//4. 페이징 블록 끝 /////////
	}//end ArticlePage

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Map<String, Object> getSearchMap() {
		return searchMap;
	}

	public void setSearchMap(Map<String, Object> searchMap) {
		this.searchMap = searchMap;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<T> getContent() {
		return content;
	}

	public void setContent(List<T> content) {
		this.content = content;
	}

	public String getPagingArea() {
		return pagingArea;
	}

	public void setPagingArea(String pagingArea) {
		this.pagingArea = pagingArea;
	}

	@Override
	public String toString() {
		return "ArticlePage [total=" + total + ", currentPage=" + currentPage + ", totalPages=" + totalPages
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", keyword=" + keyword + ", searchMap="
				+ searchMap + ", url=" + url + ", content=" + content + ", pagingArea=" + pagingArea + "]";
	}
	
	
	
}









