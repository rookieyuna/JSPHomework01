package membership;

import common.JDBConnect;
/*
DAO(Data Access Object) : 실제 데이터베이스에 접근하여
	여러가지 CRUD작업을 하기 위한 객체
 */

//DB연결을 위한 클래스를 상속한다.
public class MemberDAO extends JDBConnect {
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.
	public MemberDAO() {
		super();
	}
	/*
	사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	존재하는 정보인 경우 DTD 객체에 그 정보를담아 반환한다.
	 */
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			//쿼리문에 사용자가 입력한 아이디, 패스워드를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리 실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO객체에 정보를 저장
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	
	//이름으로 아이디/비번 찾기
	public MemberDTO findMemberDTO(String uId, String uName) {
		MemberDTO dto = new MemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "";
		
		try {
			if(uId == "") { //이름으로 아이디 찾기
				query = "SELECT * FROM member WHERE name=?";
				
				psmt = con.prepareStatement(query);
				//쿼리문에 사용자가 입력한 이름 삽입
				psmt.setString(1, uName);
				//쿼리 실행
				rs = psmt.executeQuery();
			}
			else { //아이디&이름으로 비번 찾기
				query = "SELECT * FROM member WHERE id=? and name=?";
				
				psmt = con.prepareStatement(query);
				//쿼리문에 사용자가 입력한 이름 삽입
				psmt.setString(1, uId);
				psmt.setString(2, uName);
				//쿼리 실행
				rs = psmt.executeQuery();
			}	
			
			//회원정보가 존재한다면 DTO객체에 정보를 저장
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
}
