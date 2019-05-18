<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%
    String ID = (String)session.getAttribute("ID");
    String name = (String)session.getAttribute("name");

    Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql="";
    String rst="success";
    String msg="";

%>
<%
    if (ID==null) {
        session.setAttribute("toWrite",new Boolean(true));
        response.sendRedirect("../../login");
    }
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
                        <a class="dropdown-item" href="../">게시판</a>
                        <a class="dropdown-item" href="../../lately">편집된 지 오래된 문서</a>
                        <a class="dropdown-item" href="../../contentlist">내용이 짧은 문서</a>
                        <a class="dropdown-item" href="../../contentlist/?shortText=0">내용이 긴 문서</a>
                        <a class="dropdown-item" href="../../search/suffle.jsp">무작위 문서</a>
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
        <a class="imgshuffle btnsearch btn btn-outline-secondary" href="../../search/suffle.jsp" role="button"></a>
      </span>
        <input type="text" id="searchInput" class="form-control" placeholder="위키 검색" tabindex="1">
        <span>
        <button id="searchBtn2" class="imgsearch btnsearch btn btn-outline-secondary" type="button"></button>
      </span>
        <span>
        <button id="goBtn2" class="imggo btnsearch btn btn-outline-secondary" type="button"></button>
      </span>
    </div>
</header>

<section>
    <form id="writeForm" method="post" action="write.jsp">
        <!--제목-->
        <div class="control-group">
            <div class="form-group">
                <label class="f1" for="subject">제목</label>
                <input type="text" class="form-control" name="subject" id="subject" placeholder="제목 입력" required data-validation-required-message="Please enter title.">
                <p class="help-block text-danger"></p>
            </div>
        </div>

        <!--내용-->
        <div class="control-group">
            <div class="form-group">
                <label class="f1" for="content">내용</label>
                <textarea class="form-control" rows="10" name="content" id="content" required data-validation-required-message="Please enter a content."></textarea>
                <p class="help-block text-danger"></p>
            </div>
        </div>

        <!--저장하기, 다시쓰기 버튼-->
        <div class="center">
            <input id="submitButton" type="submit" class="btn btn-secondary btn-xl" value="저장하기">
            <button type="reset" class="btn btn-warning btn-xl">다시쓰기</button>
            <br/><br/>
        </div>
    </form>
</section>
<footer></footer>

<!--JavaScript-->
<script src="../../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
<script src="../../js/search.js" type="text/javascript"></script>
</body>
</html>