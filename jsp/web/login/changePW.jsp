<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = request.getParameter("ID");
    String name = request.getParameter("name");
    String pw = request.getParameter("pw");

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

        sql="select user_id, user_name from user where user_id LIKE ? and user_name LIKE ?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,ID);
        pstmt.setString(2,name);
        rs=pstmt.executeQuery();
        pstmt.close();

        if(!rs.next()) {
            rst="fail";
        } else {
            sql = "update user set user_pw = ? where user_id LIKE ? and user_name LIKE ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pw);
            pstmt.setString(2, ID);
            pstmt.setString(3, name);
            int resNum=pstmt.executeUpdate();
            pstmt.close();

            if(resNum<1)
                rst="fail";
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
        out.print("<script>alert('비밀번호가 재설정 되었습니다.');window.location.href = '../login';</script>");
    }
    else {
        out.println("<script>alert('잘못된 접근입니다.');window.location.href = '../wiki/?codeID=codewiki';</script>");
    }
%>