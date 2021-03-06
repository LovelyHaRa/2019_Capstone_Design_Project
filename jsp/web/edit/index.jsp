<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String ID = (String)session.getAttribute("ID");
    String name = (String)session.getAttribute("name");
    String codeID=request.getParameter("codeID");
    String contentText=request.getParameter("contentText");
    String nameText=request.getParameter("nameText");
    String contentInSession=(String)session.getAttribute("contentInSession");
    String nameInSession=(String)session.getAttribute("nameInSession");

    session.setAttribute("contentInSession", null);
    session.setAttribute("nameInSession", null);
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
    <link rel="stylesheet" href="../css/editor.css" type="text/css">
    <link rel="stylesheet" href="../css/fontstyle.css" type="text/css">
    <script src="../ckeditor/ckeditor.js" type="text/javascript"></script>
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
        if(ID==null && codeID!=null) {
            session.setAttribute("toEdit",new Boolean(true));
            if(contentText!=null) {
                session.setAttribute("contentInSession", contentText);
                session.setAttribute("nameInSession", nameText);
            }
            response.sendRedirect("../login/?codeID="+codeID);
        }
    %>
    <div class="wiki-editor">
        <div class="editor-header">
            <h5 class="h5 font-NG"><%= codeID %> 문서 작성/편집</h5>
        </div>
        <div class="editor-section input-group">
            <form id="formEdit" method="post" action="edit.jsp" accept-charset="UTF-8">
                <div class="inputCodeName">
                    <p class="font-NG">코드 제목</p>
                    <%
                        if(nameText!=null) {
                    %>
                    <input type="text" id="codeName" name="codeName" class="form-control" placeholder="해당 물품 바코드 제목입력" value="<%=nameText%>" required>
                    <%
                        } else if(nameInSession!=null) {
                    %>
                    <input type="text" id="codeName" name="codeName" class="form-control" placeholder="해당 물품 바코드 제목입력" value="<%=nameInSession%>" required>
                    <%
                        } else {
                    %>
                    <input type="text" id="codeName" name="codeName" class="form-control" placeholder="해당 물품 바코드 제목입력" required>
                    <%
                        }
                    %>
                </div>
                <input type="text" name="codeID" id="codeID" hidden value="<%= codeID %>">
                <p class="font-NG">코드 내용</p>
                <textarea name="editor1" id="editor1"></textarea>
                <script type="text/javascript">
                    CKEDITOR.replace('editor1', {
                        height: 400
                    });
                    <%
                    if(contentText!=null) {
                        String submitText = contentText.replaceAll("&quot;","\"");
                    %>
                        CKEDITOR.instances.editor1.setData('<%=submitText%>');
                    <%
                    } else if(contentInSession!=null) {
                        String submitText = contentInSession.replaceAll("&quot;","\"");
                    %>
                        CKEDITOR.instances.editor1.setData('<%=submitText%>');
                    <%
                    }
                    %>
                </script>
                <input type="submit" class="btn btn-secondary btn-block" id="btnSubmit" value="저장하기">
            </form>
        </div>
    </div>
</article>
<footer></footer>

<!--JavaScript-->
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
<script src="../js/jqValidate/jquery.validate.min.js" type="text/javascript"></script>
<script src="../js/edit.js" type="text/javascript"></script>
<script src="../js/editFormCkeck.js" type="text/javascript"></script>
</body>
</html>