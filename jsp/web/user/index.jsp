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
    <link rel="stylesheet" href="../css/bootstrap/bootstrap.css" type="text/css">

    <!-- CSS-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../css/main.css" type="text/css">
    <link rel="stylesheet" href="../css/mypage.css" type="text/css">

</head>
<body>
<header>
    <nav class="customnavbar navbar navbar-expand-sm navbar-dark bg-dark" id="mainNav">
        <a class="navbar-brand" href="../wiki/?codeID=codewiki">CODE WIKI</a>
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
                <li class="nav-item active">
                    <%
                        // 로그아웃 상태
                        if (ID == null) {
                    %>
                    <a class="nav-link" href="#">My Page <span class="sr-only">(current)</span></a>
                    <%
                        // 로그인 상태
                    } else {
                    %>
                    <a class="nav-link" href="#"><%= name %> My Page <span class="sr-only">(current)</span></a>
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
    <div class="mypage-context">
        <div class="row">
            <h3 class="form-title h5 col-9 font-weight-light"><p class="font-comfortaa">My Page</h3>
            <a class="btn btn-secondary col-3" href="../login/logout.jsp">로그아웃</a>
        </div>
        <div class="card">
            <form class="form-mypage" method="POST">
                <div class="card-body font-NG">
                    <div class="form-group row">
                        <label for="ID" class="col-4 col-form-label">ID</label>
                        <div class="col">
                            <input type="text" id="ID" name="ID" readonly class="form-control-plaintext" value="<%= ID %>">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="pw" class="col-4 col-form-label">비밀번호</label>
                        <div class="col">
                            <input type="password" id="pw" name="pw" class="form-control" placeholder="변경할 패스워드 입력" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="confpw" class="col-4 col-form-label">비밀번호 확인</label>
                        <div class="col">
                            <input type="password" id="confpw" name="confpw" class="form-control" placeholder="변경할 패스워드 재입력" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="name" class="col-4 col-form-label">사용자이름</label>
                        <div class="col">
                            <input type="text" id="name" name="name" class="form-control" placeholder="변경할 이름(닉네임) 입력" required value="<%= name %>">
                        </div>
                    </div>
                </div>
                <div class="card-footer row">
                    <input type=submit class="btn-leave btn btn-warning col-3" value="회원탈퇴">
                    <span class="col-5"></span>
                    <input type=submit class="btn-update btn btn-secondary col-4" value="회원정보수정" onclick="javascript: form.action='update.jsp'">
                </div>
            </form>
        </div>
        <!--
        <p>ID : <%= ID %></p>
        <p>사용자 이름 : <%= name %></p>
        <p style="text-align: center">
            <a class="btn btn-secondary btn-block" href="../login/logout.jsp">로그아웃</a>
        </p> -->
    </div>
</article>
<footer></footer>

<!--JavaScript-->
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
<script src="../js/jqValidate/jquery.validate.min.js" type="text/javascript"></script>
<script src="../js/search.js" type="text/javascript"></script>
<script src="../js/mypage.js" type="text/javascript"></script>
</body>
</html>