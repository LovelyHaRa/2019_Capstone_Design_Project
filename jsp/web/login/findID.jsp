<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = request.getParameter("ID");
    String name = request.getParameter("name");

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

        if(rs.next()) {
        } else {
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
        %>
<html>
<head></head>
<script type="text/javascript" src="../js/jQuery/jquery-3.3.1.min.js"></script>
<body>
<form id="sendID" method="POST" action="changepassword.jsp">
    <input type="text" id="ID" name="ID" value="<%=ID%>" hidden>
    <input type="text" id="name" name="name" value="<%=name%>" hidden>
</form>
<script type="text/javascript">
    $(function () {
        $(document).ready(function () {
            $("#sendID").submit();
        });
    });
</script>
</body>
</html>
    <%
    }
    else {
        out.println("<script>alert('ID를 찾을 수 없습니다.');history.back()</script>");
    }
%>
