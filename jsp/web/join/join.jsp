<%@page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
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
    Date date = new Date();
    String sso=Long.toString(date.getTime());
    String grade="일반";
%>
<%
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");
        sql="select * from user where user_id = ?";
        pstmt=conn.prepareStatement(sql);
        pstmt.setString(1,ID);
        rs=pstmt.executeQuery();
        pstmt.close();
        if(rs.next()) {
            rst="중복아이디";
            msg="이미 등록된 아이디입니다.";
        } else {
            conn.setAutoCommit(false);
            sql="insert into user(user_id, sso_code, user_pw, user_grade, user_name) values (?,?,?,?,?)";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, ID);
            pstmt.setString(2, sso);
            pstmt.setString(3, pw);
            pstmt.setString(4, grade);
            pstmt.setString(5, username);
            pstmt.executeUpdate();

            conn.commit();

            session.setAttribute("ID", ID);
            session.setAttribute("name", username);
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
        out.println("<script>alert('회원가입이 완료되었습니다.');window.location.href=\"../index.jsp\"</script>");
    }
    else {
        if(rst.equals("중복아이디"))
            out.println("<script>alert('이미 등록된 ID 입니다.');history.back()</script>");
        else
            out.println("<script>alert('DB 서버가 작동중이지 않습니다.');history.back()</script>");
    }
%>