<%@page import="java.sql.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";

    String query=request.getParameter("query");
    int docuCount=0;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

        sql="select varcode_num from varcode where varcode_num LIKE '"+query+"'";
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
        pstmt.close();

        String codeID="";
        if (rs.next()) {
            codeID=rs.getString(1);
            response.sendRedirect("../wiki/?codeID="+codeID);
            return;
        }

        sql="select count(*), varcode_num from varcode where varcode_name LIKE '%"+query+"%'";
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
        pstmt.close();

        if(rs.next()) {
            docuCount=rs.getInt(1);
            codeID=rs.getString(2);
            if(docuCount>1) {
                response.sendRedirect("./?query="+URLEncoder.encode(query, "UTF-8"));
                return;
            } else if(docuCount==1) {
                response.sendRedirect("../wiki/?codeID="+codeID);
                return;
            }

        }
        /*
        sql="select varcode_num from varcode where varcode_name LIKE '"+query+"'";
        pstmt=conn.prepareStatement(sql);
        rs=pstmt.executeQuery();
        pstmt.close();

        if(rs.next()) {
            codeID=rs.getString(1);
            response.sendRedirect("../wiki/?codeID="+codeID);
            return;
        }
        */

        response.sendRedirect("./?query="+URLEncoder.encode(query, "UTF-8"));

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