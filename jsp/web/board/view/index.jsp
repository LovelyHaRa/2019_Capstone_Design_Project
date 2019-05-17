<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = (String)session.getAttribute("ID");
    String name = (String)session.getAttribute("name");
    String content="";
    String title="";
    String ownerName="";
    String datetime="";
    int number;
    try {
        number = Integer.parseInt(request.getParameter("contentNumber"));
    } catch (NullPointerException e) {
        number=0;
    } catch (NumberFormatException e) {
        number=0;
    }

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";

    int hit = 0;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>CODE WIKI</title>
    <!-- viewport -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="../../css/bootstrap/bootstrap.css" type="text/css">

    <!-- CSS-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../css/main.css" type="text/css">
    <link rel="stylesheet" href="../../css/board.css" type="text/css">

</head>
<body>
<header>
    <nav class="customnavbar navbar navbar-expand-sm navbar-dark bg-dark" id="mainNav">
        <a class="navbar-brand" href="#">CODE WIKI</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
            Menu
        </button>
        <div class="collapse navbar-collapse" id="navbar">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">최근 변경 <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        특수 기능
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">게시판</a>
                        <a class="dropdown-item" href="#">편집된 지 오래된 문서</a>
                        <a class="dropdown-item" href="#">내용이 짧은 문서</a>
                        <a class="dropdown-item" href="#">내용이 긴 문서</a>
                        <a class="dropdown-item" href="#">무작위 문서</a>
                    </div>
                </li>
                <li class="nav-item">
                    <%
                        // 로그아웃 상태
                        if (ID == null) {
                    %>
                    <a class="nav-link" href="../../login">My Page</a>
                    <%
                        // 로그인 상태
                    } else {
                    %>
                    <a class="nav-link" href="./user"><%= name %> My Page</a>
                    <%
                        }
                    %>
                </li>
            </ul>
        </div>
    </nav>
    <div class="input-group search-box">
      <span class="input-group-btn left-search-btns">
        <a class="imgshuffle btnsearch btn btn-outline-secondary" href="#" role="button"></a>
      </span>
        <input type="text" id="searchInput" class="form-control" placeholder="위키 검색" tabindex="1">
        <span>
        <button id="searchBtn" class="imgsearch btnsearch btn btn-outline-secondary" type="button"></button>
      </span>
        <span>
        <button id="goBtn" class="imggo btnsearch btn btn-outline-secondary" type="button"></button>
      </span>
    </div>
</header>

<section>
    <div class="board-content">
            <%
        try {
          Class.forName("org.mariadb.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi", "!#deu1641");

          sql = "select username, title, content, datetime, hit from board where number=?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, number);
          rs = pstmt.executeQuery();
          pstmt.close();

          if (rs.next()) {
            ownerName=rs.getString(1);
            title=rs.getString(2);
            content=rs.getString(3);
            datetime=rs.getString(4);
            hit=rs.getInt(5);
            hit++;
          }

          sql = "update board set hit=? where number LIKE ?";
          pstmt = conn.prepareStatement(sql);
          pstmt.setInt(1, hit);
          pstmt.setInt(2,number);
          pstmt.executeUpdate();
          pstmt.close();
        } catch (SQLException e) {
          content = "위키 DB에 접속할 수 없습니다.";
        } finally {
          if (pstmt != null)
            pstmt.close();
          if (conn != null)
            conn.close();
        }
      %>
        <h4 class="h4"><%=title%></h4>
        <p class="strOwnerName" style="text-align: right;"><%=ownerName%></p>
        <p class="strDate" style="text-align: right;"><%=datetime%></p>
        <hr>
        <%= content %>
    </div>
    <div class="viewButton center">
        <input type=button class="btn btn-secondary" value="글쓰기"  onclick="location.href='../write'">
        <input type=button class="btn btn-secondary" value="목록" onclick="location.href='../'">
        <input type=button class="btn btn-secondary" value="수정" onclick="location.href='../modify/?contentNumber=<%=number%>'">
        <input type=button class="btn btn-secondary" value="삭제" onclick="location.href='./delete.jsp?contentNumber=<%=number%>'">
    </div>
</section>
<footer></footer>

<!--JavaScript-->
<script src="../../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
</body>
</html>