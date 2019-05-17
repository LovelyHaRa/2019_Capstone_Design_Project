<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = (String)session.getAttribute("ID");
    String name = (String)session.getAttribute("name");
    int number;
    try {
        number = Integer.parseInt(request.getParameter("contentNumber"));
    } catch (NullPointerException e) {
        number=0;
    }

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
%>
<%
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi", "!#deu1641");

        sql = "select userID from board where number=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, number);
        rs = pstmt.executeQuery();
        pstmt.close();

        if (rs.next()) {
            String ownerID=rs.getString(1);
            if(!ownerID.equals(ID)) {
                out.println("<script>alert('작성자만 삭제할 수 있습니다.');history.back()</script>");
                return;
            }
        }

        sql = "delete from board where number LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1,number);
        pstmt.executeUpdate();
        pstmt.close();

    } catch (SQLException e) {
        rst="DB 연동 오류";
    } finally {
        if (pstmt != null)
            pstmt.close();
        if (conn != null)
            conn.close();
    }
    if(rst.equals("success")) {
        out.println("<script>alert('성공적으로 삭제되었습니다.');location.href='../'</script>");
    }
%>