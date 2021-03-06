<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String ID = (String)session.getAttribute("ID");
  String name = (String)session.getAttribute("name");
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
  <link rel="stylesheet" href="css/bootstrap/bootstrap.css" type="text/css">

  <!-- CSS-->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="css/main.css" type="text/css">

</head>
<body>
  <header>
    <nav class="customnavbar navbar navbar-expand-sm navbar-dark bg-dark" id="mainNav">
      <a class="navbar-brand" href="./wiki/?codeID=codewiki">CODE WIKI</a>
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
              <a class="dropdown-item" href="./board">게시판</a>
              <a class="dropdown-item" href="./lately">편집된 지 오래된 문서</a>
              <a class="dropdown-item" href="./contentlist">내용이 짧은 문서</a>
              <a class="dropdown-item" href="./contentlist/?shortText=0">내용이 긴 문서</a>
             <a class="dropdown-item" href="./search/suffle.jsp">무작위 문서</a>
            </div>
          </li>
          <li class="nav-item">
            <%
              // 로그아웃 상태
              if (ID == null) {
            %>
                <a class="nav-link" href="./login">My Page</a>
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
        <a class="imgshuffle btnsearch btn btn-outline-secondary" href="./search/suffle.jsp" role="button"></a>
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
    <div class="wiki-article-menu">
      <div class="btn-group" role="group">
        <a class="btn btn-outline-secondary" href="#" role="button">역링크</a>
        <a class="btn btn-outline-secondary" href="#" role="button">토론</a>
        <a class="btn btn-outline-secondary" rel="nofollow" href="#" role="button">편집</a>
        <a class="btn btn-outline-secondary" href="#" role="button">역사</a>
        <a class="btn btn-outline-secondary" href="#" role="button">ACL</a>
      </div>
    </div>
  </article>
  <footer></footer>

  <!--JavaScript-->
  <script src="js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
  <script src="js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
  </body>
</html>