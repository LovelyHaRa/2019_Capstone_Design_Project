<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인 : CODE WIKI</title>
    <!-- viewport -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="../css/bootstrap/bootstrap.css" type="text/css">

    <!-- CSS-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../css/login.css" type="text/css">
    <link rel="stylesheet" href="../css/fontstyle.css" type="text/css">

</head>
<body class="text-center">
<div class="card">
    <form class="form-signin" action="login.jsp" method="POST">
        <h3 class="form-title h5 mb-3 font-weight-light"><p class="font-comfortaa">CODE WIKI </p><p class="font-NG">로그인</p></h3>
        <div class="form-section card-body font-NG">
            <div class="form-group">
                <label for="inputID" class="sr-only">ID</label>
                <input type="text" id="inputID" name="ID" class="form-control" placeholder="ID" required autofocus>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="sr-only">PASSWORD</label>
                <input type="password" id="inputPassword" name="pw" class="form-control" placeholder="PASSWORD" required>
            </div>
            <%
                String codeID=request.getParameter("codeID");
            %>
            <input type="text" name="codeID" id="codeID" hidden value="<%= codeID %>">
            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="remember-me" class="check"> <span style="font-size: 0.9em;"> ID/PW 저장</span>
                </label>
            </div>
            <button class="btn btn-secondary btn-block" type="submit" id="btnLogin">로그인</button>
        </div>
        <div class="card-footer">
            <p class="font-NG">아직 회원이 아니라면? <a href="../join/index.jsp">회원가입</a></p>
            <p class="font-NG"><a href="#">ID/PW 찾기</a></p>
        </div>
    </form>
</div>
</body>
</html>
