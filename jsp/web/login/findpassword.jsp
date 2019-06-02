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
    <link rel="stylesheet" href="../css/findpassword.css" type="text/css">
    <link rel="stylesheet" href="../css/fontstyle.css" type="text/css">

</head>
<body class="text-center">
<div class="card">
    <form class="form-inputID" method="POST" action="findID.jsp">
        <h3 class="form-title h5 mb-3 font-weight-light"><p class="font-comfortaa">CODE WIKI </p><p class="font-NG">비밀번호 찾기</p></h3>
        <div class="form-section card-body font-NG">
            <div class="form-group">
                <p class="font-comfortaa">ID</p>
                <label for="ID" class="sr-only">ID</label>
                <input type="text" id="ID" name="ID" class="form-control" placeholder="비밀번호를 찾을 ID 입력" required autofocus>
            </div>
            <div class="form-group">
                <p class="font-NG">사용자 이름</p>
                <label for="name" class="sr-only">사용자이름</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="이름(닉네임) 입력" required>
            </div>
        </div>
        <div class="card-footer">
            <button id="btnSubmitID" class="btn btn-secondary btn-block" type="submit">비밀번호 찾기</button>
            <p class="font-NG"><a href="../login/index.jsp">뒤로가기</a></p>
        </div>
    </form>
</div>
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/jqValidate/jquery.validate.min.js" type="text/javascript"></script>
</body>
</html>
