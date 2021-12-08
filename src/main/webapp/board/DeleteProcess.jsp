<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="IsLoggedIn.jsp" %> <!-- 로그인 확인 -->
<%
//폼값 받기
String num = request.getParameter("num");

//DTO객체와 DB연결 및 기존 게시물 가져오기
BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO(application);
dto = dao.selectView(num);

//세션영역에 저장된 아이디를 문자열로 반환
String sessionId = session.getAttribute("UserId").toString();

int delResult = 0;

//현재삭제하는 사람이 해당글의 작성자가 맞는지 확인
if(sessionId.equals(dto.getId())){ //본인이 맞으면..
	
	///DTO객체에 일련번호를 저장한 후 DAO로 매개변수 전달
	//dto.setNum(num);
	delResult = dao.deletePost(dto);
	//연결해제
	dao.close();
	
	if (delResult ==1){
		//게시물 삭제에 성공하면 리스트로 이동
		JSFunction.alertLocation("삭제되었습니다", "../board/listT.jsp", out);
	}
	else{
		JSFunction.alertBack("삭제에 실패하였습니다", out);
	}
}
else{
	JSFunction.alertBack("본인만 삭제 가능합니다.", out);
	return;
}
%>
