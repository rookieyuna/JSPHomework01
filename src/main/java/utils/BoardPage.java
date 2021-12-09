package utils;

//게시판 목록 하단에 페이지 번호를 출력하기 위한 클래스
public class BoardPage {
	
	//매개변수(전체게시물 개수, 한페이지 출력개수, 한블럭당출력페이지, 현재페이지번호, 현재페이지명)
	public static String pagingStr(int totalCount, int pageSize, int blockPage, 
			int pageNum, String reqUrl) {
		
		String pagingStr ="";
		//전체 페이지 수 계산
		int totalPages = (int)(Math.ceil((double)totalCount / pageSize));
		
		//페이지 블럭의 첫번째 수를 계산
		int pageTemp = (((pageNum - 1) / blockPage)* blockPage )+1;
		
		//이전블럭으로 바로가기 링크(첫번째 블럭에서는 숨김처리)
		if(pageTemp != 1) {
			pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='" 
						+ reqUrl + "?pageNum=1'><i class='bi bi-skip-backward-fill'></i></a></li>";
			pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='" + reqUrl + "?pageNum=" + (pageTemp - 1)
						+ "'><i class='bi bi-skip-start-fill'></i></a></li>";
		}
		
		//각 페이지로 바로가기 링크(blockPage수 만큼 출력됨)
		int blockCount = 1;
		while (blockCount <= blockPage && pageTemp <=totalPages) {
			if(pageTemp == pageNum) {
				pagingStr += "<li class=\"page-item active\"><a class=\"page-link\">" + pageTemp + "</a></li>";
			} else {
				pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='" + reqUrl + "?pageNum=" + pageTemp
							+ "'>" + pageTemp + "</a></li>";
			}
			pageTemp++;
			blockCount++;
		}
		
		//다음블럭으로 바로가기 링크
		if(pageTemp <= totalPages) {
			pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='" + reqUrl 
						+ "?pageNum=" + pageTemp + "'><i class='bi bi-skip-end-fill'></i></a></li>";
			pagingStr += "<li class=\"page-item\"><a class=\"page-link\" href='" + reqUrl 
						+ "?pageNum=" + totalPages + "'><i class='bi bi-skip-forward-fill'></i></a></li>";
		}	
		
		return pagingStr;
	}
}
