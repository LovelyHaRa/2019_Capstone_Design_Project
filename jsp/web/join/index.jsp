<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입 : CODE WIKI</title>
    <!-- viewport -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="../css/bootstrap/bootstrap.css" type="text/css">

    <!-- CSS-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Comfortaa|Noto+Sans+KR|Nanum+Gothic" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../css/join.css" type="text/css">
    <link rel="stylesheet" href="../css/fontstyle.css" type="text/css">
</head>
<body class="text-center">
<div class="card">
    <form class="form-signin" action="join.jsp" method="POST">
        <h3 class="form-title h5 mb-3 font-weight-light"><p class="font-comfortaa">CODE WIKI </p><p class="font-NG">회원가입</p></h3>
        <div class="form-section card-body font-NG">
            <div class="form-group">
                <p class="font-comfortaa">ID</p>
                <label for="ID" class="sr-only">ID</label>
                <input type="text" id="ID" name="ID" class="form-control" placeholder="사용할 ID 입력" required autofocus>
            </div>
            <div class="form-group">
                <p class="font-comfortaa">PASSWORD</p>
                <label for="pw" class="sr-only">PASSWORD</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="사용할 패스워드 입력" required>
            </div>
            <div class="form-group">
                <p class="font-comfortaa">CONFIRM PASSWORD</p>
                <label for="confpw" class="sr-only">비밀번호 확인</label>
                <input type="password" id="confpw" name="confpw" class="form-control" placeholder="사용할 패스워드 입력" required>
            </div>
            <div class="form-group">
                <p class="font-NG">사용자 이름</p>
                <label for="name" class="sr-only">사용자이름</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="이름(닉네임) 입력" required>
            </div>
        </div>
        <div class="card-footer">
            <button class="btn btn-secondary btn-block" type="submit">회원가입</button>
            <p class="font-NG"><a href="../login/index.jsp">뒤로가기</a></p>
        </div>
    </form>
</div>
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/jqValidate/jquery.validate.min.js" type="text/javascript"></script>
<script src="../js/join.js" type="text/javascript"></script>
</body>
</html>
