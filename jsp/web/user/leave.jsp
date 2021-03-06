<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = request.getParameter("ID");
    String pw = request.getParameter("pw");
    String username = request.getParameter("name");
%>
<%
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
        sql="select * from user where user_id = ? and user_name = ?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,ID);
        pstmt.setString(2,username);
        rs=pstmt.executeQuery();
        pstmt.close();
        if(!rs.next()) {
            rst="접근오류";
        } else {
            conn.setAutoCommit(false);
            sql="delete from user where user_id = ? and user_name = ?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, ID);
            pstmt.setString(2, username);
            int res=pstmt.executeUpdate();
            if(res==1) {
                conn.commit();
            }
            else
                rst="접근오류";
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
        out.println("<script>alert('회원탈퇴 처리되었습니다.');window.location.href=\"../login/logout.jsp\"</script>");
    }
    else {
        if(rst.equals("접근오류"))
            out.println("<script>alert('잘못된 접근입니다.');window.location.href=\"../wiki/?codeID=codewiki\"</script>");
        else
            out.println("<script>alert('DB 서버가 작동중이지 않습니다.');window.location.href=\"../wiki/?codeID=codewiki\"</script>");
    }
%>