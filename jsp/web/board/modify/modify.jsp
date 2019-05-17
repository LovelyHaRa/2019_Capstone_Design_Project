<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = (String)session.getAttribute("ID");
    String userName = (String)session.getAttribute("name");

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";

    String title=request.getParameter("subject");
    String content=request.getParameter("content");
    int number;
    try {
        number = Integer.parseInt(request.getParameter("contentNumber"));
    } catch (NullPointerException e) {
        number=0;
    } catch (NumberFormatException e) {
        number=0;
    }

%>
<%
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

        sql="update board set title=?, content=?, datetime=now(), hit=0 where number=?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,title);
        pstmt.setString(2,content);
        pstmt.setInt(3,number);
        pstmt.executeUpdate();
        pstmt.close();

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
        response.sendRedirect("../view/?contentNumber="+number);
    }
    else {
        out.println("<script>alert('글 수정에 실패하였습니다.');history.back()</script>");
    }
%>