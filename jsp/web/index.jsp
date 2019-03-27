<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
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
  <link rel="stylesheet" href="css/main.css" type="text/css">

</head>
<body>
  <header>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
      <a class="navbar-brand" href="#">CODE WIKI</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
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
            <a class="nav-link" href="#">My Page</a>
          </li>
        </ul>
      </div>

    </nav>
  </header>
  <form class="form-inline navbar-form search-box-parent">
    <div class="input-group search-box">
      <span class="input-group-btn left-search-btns">
        <a class="btn btn-secondary" href="/random" role="button">
          <img class="imgIcon" src="/images/icon/shuffle.png" alt="shuffle">
        </a>
      </span>
      <input type="text" id="searchInput" class="form-control" placeholder="Search" tabindex="1">
      <span class="input-group-btn right-search-btns">
        <button id="searchBtn" class="btn btn-secondary" type="button">
          <span class="icon ion-search"></span>
        </button>
        <button id="goBtn" class="btn btn-secondary" type="button">
          <span class="icon ion-arrow-right-c"></span>
        </button>
      </span>
    </div>
  </form>
  <section>
    <h2>코드위키에 오신것을 환영합니다</h2>
  </section>
  <footer></footer>

  <!--JavaScript-->
  <script src="/js/jquery/jquery-3.3.1.min.js" type="text/javascript"></script>
  <script src="js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
  </body>
</html>