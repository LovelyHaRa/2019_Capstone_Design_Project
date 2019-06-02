<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

        sql="select varcode_num from varcode order by rand() limit 1";
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
        pstmt.close();

        String codeID="";
        while (rs.next()) {
            codeID=rs.getString(1);
        }
        response.sendRedirect("../wiki/?codeID="+codeID);
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