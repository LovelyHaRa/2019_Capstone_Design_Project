<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  String ID = (String)session.getAttribute("ID");
  String name = (String)session.getAttribute("name");
  String contentText="코드에 대한 위키내용을 찾을 수 없습니다.";
  String nameText="";
  String dateText="";
  String codeID=request.getParameter("codeID");
  String replaceText="";

  Connection conn=null;
  PreparedStatement pstmt=null;
  ResultSet rs;
  String sql;

  int revision_num = 0;
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
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.css" type="text/css">

  <!-- CSS-->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="../css/main.css" type="text/css">

</head>
<body>
  <header>
    <nav class="customnavbar navbar navbar-expand-sm navbar-dark bg-dark" id="mainNav">
      <a class="navbar-brand" href="./?codeID=codewiki">CODE WIKI</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
        Menu
      </button>
      <div class="collapse navbar-collapse" id="navbar">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="../lately/?isLately=1">최근 변경</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              특수 기능
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <a class="dropdown-item" href="../board">게시판</a>
              <a class="dropdown-item" href="../lately">편집된 지 오래된 문서</a>
              <a class="dropdown-item" href="../contentlist">내용이 짧은 문서</a>
              <a class="dropdown-item" href="../contentlist/?shortText=0">내용이 긴 문서</a>
             <a class="dropdown-item" href="../search/suffle.jsp">무작위 문서</a>
            </div>
          </li>
          <li class="nav-item">
            <%
              // 로그아웃 상태
              if (ID == null) {
            %>
                <a class="nav-link" href="../login">My Page</a>
            <%
              // 로그인 상태
              } else {
            %>
                <a class="nav-link" href="../user"><%= name %> My Page</a>
            <%
              }
            %>
          </li>
        </ul>
      </div>
    </nav>
    <div class="input-group search-box">
      <span class="input-group-btn left-search-btns">
        <a class="imgshuffle btnsearch btn btn-outline-secondary" href="../search/suffle.jsp" role="button"></a>
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

  <article class="container-flui wiki-article">
    <%
      try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi", "!#deu1641");

        sql = "select count(*) as docu_count from varcode_docu where varcode_num LIKE ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, codeID);
        rs = pstmt.executeQuery();
        pstmt.close();

        if (rs.next()) {
          if(request.getParameter("revision")!=null) {
            revision_num=Integer.parseInt(request.getParameter("revision"));
          } else
            revision_num = rs.getInt("docu_count");
        }

        sql = "select varcode_name from varcode where varcode_num LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, codeID);
        rs = pstmt.executeQuery();
        pstmt.close();

        if (rs.next()) {
          nameText=rs.getString("varcode_name");
        }

        sql = "select data, date from varcode_docu where varcode_num LIKE ? and revision_docu = "+revision_num;
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, codeID);
        rs = pstmt.executeQuery();
        pstmt.close();

        if (rs.next()) {
          contentText=rs.getString("data");
          dateText=rs.getString("date");
        }
        replaceText=contentText.replaceAll("\r\n","");
      } catch (SQLException e) {
        contentText = "위키 DB에 접속할 수 없습니다.";
      } finally {
        if (pstmt != null)
          pstmt.close();
        if (conn != null)
          conn.close();
      }
    %>
    <%
      if(revision_num>0) {
    %>
    <div class="wiki-article-menu">
      <div class="btn-group" role="group">
        <!--
        <a class="btn btn-outline-secondary" href="#" role="button">역링크</a>
        <a class="btn btn-outline-secondary" href="#" role="button">토론</a>
        -->
        <a class="btn btn-outline-secondary" rel="nofollow" href="#" role="button" id="btnEdit">편집</a>
        <a class="btn btn-outline-secondary" href="./history/?codeID=<%=codeID%>" role="button">역사</a>
        <!--
        <a class="btn btn-outline-secondary" href="#" role="button">ACL</a>
        -->
      </div>
    </div>
    <%
      }
    %>
    <div class="wiki-content">
      <% if(revision_num==0) {
        %>
      <p><%=replaceText%></p>
      <input type="button" class="btn btn-secondary" value="위키 문서 등록" onclick="location.href='../edit/?codeID=<%=codeID%>'">
      <%
      } else {
        %>
      <h2 class="h2"><%=nameText%></h2>
      <p class="strDate" style="text-align: right;">마지막 수정일 : <%=dateText%></p>
      <hr>
      <p><%= replaceText %></p>
      <%
      }
      String submitText = replaceText.replaceAll("\"","&quot;");
      %>
      <form id="contentForm" action="../edit/?codeID=<%=codeID%>" method="post">
        <input type="text" hidden id="nameText" name="nameText" value="<%=nameText%>">
        <input type="text" hidden id="contentText" name="contentText" value="<%=submitText%>">
      </form>
    </div>
  </article>
  <footer></footer>

  <!--JavaScript-->
  <script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
  <script src="../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
  <script src="../js/edit.js" type="text/javascript"></script>
  <script src="../js/search.js" type="text/javascript"></script>
  </body>
</html>