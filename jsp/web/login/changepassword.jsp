<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    try {
        String ID = request.getParameter("ID");
        String name = request.getParameter("name");

        request.setAttribute("ID", ID);
        request.setAttribute("name", name);

        if(ID==null || name==null)
            throw new Exception();
%>
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
    <link rel="stylesheet" href="../css/findpassword.css" type="text/css">
    <link rel="stylesheet" href="../css/fontstyle.css" type="text/css">

</head>
<body class="text-center">
<div class="card">
    <form class="form-inputPW" method="POST" action="changePW.jsp">
        <h3 class="form-title h5 mb-3 font-weight-light"><p class="font-comfortaa">CODE WIKI </p><p class="font-NG">비밀번호 찾기</p></h3>
        <div class="form-section card-body font-NG">
            <input type="text" id="ID" name="ID" hidden value="<%= ID %>">
            <input type="text" id="name" name="name" hidden value="<%= name %>">
            <%
                } catch (Exception e) {
                    response.sendRedirect("./index.jsp");
                }
            %>
            <div class="form-group">
                <p class="font-comfortaa">RESET PASSWORD</p>
                <label for="pw" class="sr-only">PASSWORD</label>
                <input type="password" id="pw" name="pw" class="form-control" placeholder="새로운 패스워드 입력" required>
            </div>
            <div class="form-group">
                <p class="font-comfortaa">CONFIRM RESET PASSWORD</p>
                <label for="confpw" class="sr-only">비밀번호 확인</label>
                <input type="password" id="confpw" name="confpw" class="form-control" placeholder="한번 더 패스워드 입력" required>
            </div>
        </div>
        <div class="card-footer">
            <button class="btn btn-secondary btn-block" type="submit">비밀번호 변경</button>
            <p class="font-NG"><a href="../login/index.jsp">뒤로가기</a></p>
        </div>
    </form>
</div>
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/jqValidate/jquery.validate.min.js" type="text/javascript"></script>
<script src="../js/findpassword.js" type="text/javascript"></script>
</body>
</html>
