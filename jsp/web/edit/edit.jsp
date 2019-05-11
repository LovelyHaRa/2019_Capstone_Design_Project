<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String)session.getAttribute("ID");
    String contentText = request.getParameter("editor1");
    String codeID=request.getParameter("codeID");

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";

    boolean newDocument = true;
    int revision_count = 1;
%>
<!--
<html>
<head>
    <title>결과</title>
</head>
<body>
    <p><%=codeID%></p>
    <%=contentText%>
</body>
</html>
-->
<%
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

        sql="select count(*) as docu_count from varcode_docu where varcode_num LIKE ? ";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1, codeID);
        rs=pstmt.executeQuery();
        pstmt.close();

        if(rs.next()) {
            revision_count=rs.getInt("docu_count");
        }
        if(revision_count>0)
            newDocument=false;
        revision_count++;
        if(newDocument) {
            sql="insert into varcode values (?)";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, codeID);
            pstmt.executeUpdate();
            pstmt.close();

        }
        sql="insert into varcode_docu values (?, ?, ?, ?, now())";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, codeID);
        pstmt.setInt(3, revision_count);
        pstmt.setString(4, contentText);
        pstmt.executeUpdate();

    } catch(SQLException e) {
        rst="DB 연동 오류";
        msg=e.getMessage();
    } finally {
        if(pstmt!=null)
            pstmt.close();
        if(conn!=null)
            conn.close();
    }
    if(rst.equals("success"))
        response.sendRedirect("../wiki/?codeID="+codeID);
    else {
        out.println("<script>alert('등록 실패');history.back()</script>");
    }
%>
