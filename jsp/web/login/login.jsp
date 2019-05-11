<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = request.getParameter("ID");
    String pw = request.getParameter("pw");
    String codeID = request.getParameter("codeID");
    boolean toEdit;
    try {
        toEdit = (Boolean) session.getAttribute("toEdit");
    } catch (NullPointerException e) {
        toEdit=false;
    }
    String name="";

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";


%>
<%
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

        sql="select user_name from user where user_id LIKE ? and user_pw LIKE ?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,ID);
        pstmt.setString(2,pw);
        rs=pstmt.executeQuery();
        pstmt.close();

        if(rs.next()) {
            name=rs.getString("user_name");
            session.setAttribute("ID", ID);
            session.setAttribute("name", name);
        } else {
            rst="로그인에러";
            msg="회원이 아니거나 비밀번호가 잘못되었습니다!";
        }
    } catch(SQLException e) {
        rst="DB 연동 오류";
        msg=e.getMessage();
    } finally {
        if(pstmt!=null)
            pstmt.close();
        if(conn!=null)
            conn.close();
    }
%>
<%
    if(rst.equals("success")) {
        if (toEdit) {
            session.setAttribute("toEdit",new Boolean(false));
            response.sendRedirect("../edit/?codeID=" + codeID);
        }
        else
            response.sendRedirect("../index.jsp");
    }
    else {
        out.println("<script>alert('ID 또는 패스워드가 맞지 않습니다.');history.back()</script>");
    }
%>