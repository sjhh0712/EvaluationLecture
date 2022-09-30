<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%!  // 선언문 반드시 사용!!!
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
<%
UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	if(request.getParameter("evaluationID") != null){
		evaluationID = request.getParameter("evaluationID");
	}	
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	EvaluationDTO evaluationDTO = new EvaluationDTO();
	LikeyDTO likeyDTO = new LikeyDTO();
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	if(evaluationDAO.getUserID(evaluationID).equals(userID)){
		PrintWriter script = response.getWriter();	
		script.println("<script>");
		script.println("alert('자신의 글은 추천할 수 없습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;	
	}
	else{
		if(result == 1){ // 삽입 성공시
			result = evaluationDAO.like(evaluationID);  // 해당 id의 평가글에 추천 카운트 + 1
			if(result == 1){ // 평가글 추천 카운트 + 1이 성공했다면
				PrintWriter script = response.getWriter();	
				script.println("<script>");
				script.println("alert('추천하였습니다.')");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;			
			}
			else{
				PrintWriter script = response.getWriter();	
				script.println("<script>");
				script.println("alert('데이터 베이스 오류가 발생했습니다.')");
				script.println("history.back();");
				script.println("</script>");
				script.close();
				return;
			}
		}
		else {
			PrintWriter script = response.getWriter();	
			script.println("<script>");
			script.println("alert('이미 추천하셨습니다.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}
%>