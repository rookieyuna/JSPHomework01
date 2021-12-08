<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");//게시물의 일련번호받기
BoardDAO dao = new BoardDAO(application);//DB연결
dao.updateVisitCount(num);//조회수 증가 메서드 호출
//일련번호에 해당하는 게시물 조회
BoardDTO dto = dao.selectView(num);
dao.close();
%>
<%@ include file="./commons/header.jsp" %>
<body>
<script>
function deletePost() {
	var confirmed = confirm("정말로 삭제하시겠습니까?");
	if(confirmed) {
		var form = document.writeFrm;
		form.method = "post"; //전송방식 설정
		form.action = "DeleteProcess.jsp"; //전송할 URL
		form.submit(); //폼값 전송
	}
}
</script>
<div class="container">
    <!-- Top영역 -->
    <%@ include file="./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file="./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 내용보기 - <small>자유게시판</small></h3>
            
            <form name="writeFrm">
            <input type="hidden" name="num" value="<%=num%>"/>
                <table class="table table-bordered">
                <colgroup>
                    <col width="20%"/>
                    <col width="30%"/>
                    <col width="20%"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성자</th>
                        <td>
                            <%= dto.getName() %>
                        </td>
                        <th class="text-center" 
                            style="vertical-align:middle;">작성일</th>
                        <td>
                            <%= dto.getPostdate() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">이메일</th>
                        <td>
                            rookie@naver.com
                        </td>
                        <th class="text-center" 
                            style="vertical-align:middle;">조회수</th>
                        <td>
                            <%= dto.getVisitcount() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">제목</th>
                        <td colspan="3">
                            <%= dto.getTitle() %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">내용</th>
                        <td colspan="3"  height="200">
                            <%= dto.getContent().replace("\r\n", "<br>") %>
                        </td>
                    </tr>
                    <tr>
                        <th class="text-center" 
                            style="vertical-align:middle;">첨부파일</th>
                        <td colspan="3">
                            파일명.jpg
                        </td>
                    </tr>
                </tbody>
                </table>

                <!-- 각종버튼 -->
                <div class="row mb-3">
                    <div class="col d-flex justify-content-end">
                    <%
					/*로그인 및 작성자본인확인*/
					if(session.getAttribute("UserId") != null
						&& session.getAttribute("UserId").toString().equals(dto.getId())){
					%>
                        <button type="button" class="btn btn-secondary"
                        	onclick="location.href='Edit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
                        <button type="button" class="btn btn-danger" onclick="deletePost();">삭제하기</button>
                    <%
					}
					%>
                        <button type="button" class="btn btn-primary" onclick="location.href='writeT.jsp';">글쓰기</button>
                        <button type="button" class="btn btn-warning" onclick="location.href='listT.jsp';">목록보기</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>