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

    // 페이징 처리 변수 (http://blog.naver.com/PostView.nhn?blogId=nscorpio16&logNo=60103052346)
    int pageSize = 10;
    int pageBlock = 5;
    int cpage = request.getParameter("pageNum") != null ? Integer.parseInt(request.getParameter("pageNum")) : 1;
    int total = 0;
    int endNo = pageSize * cpage;
    int startNo = endNo - pageSize;
    int totalPage = 0;

    int prevBlock = (int)Math.floor((cpage - 1) / pageBlock) * pageBlock;
    int nextBlock = prevBlock + pageBlock + 1;
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
    <link rel="stylesheet" href="../css/board.css" type="text/css">

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
                        <a class="dropdown-item" href="./board">게시판</a>
                        <a class="dropdown-item" href="#">편집된 지 오래된 문서</a>
                        <a class="dropdown-item" href="#">내용이 짧은 문서</a>
                        <a class="dropdown-item" href="#">내용이 긴 문서</a>
                        <a class="dropdown-item" href="#">무작위 문서</a>
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
        <a class="imgshuffle btnsearch btn btn-outline-secondary" href="#" role="button"></a>
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

<section>
    <table class="boardList table table-hover table-striped text-center">
        <thead class="thead-dark">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>날짜</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn=DriverManager.getConnection("jdbc:mariadb://113.198.237.228:1521/code_wiki", "pi","!#deu1641");

                sql="select count(*) from board";
                pstmt=conn.prepareStatement(sql);
                rs=pstmt.executeQuery();
                pstmt.close();

                if(rs.next()) {
                    total=rs.getInt(1);
                }
                rs.close();

                sql="SET @rownum:=0";
                pstmt=conn.prepareStatement(sql);
                pstmt.execute();
                pstmt.close();

                sql="select * from " +
                        "(select @rownum:=@rownum-1 as rownumber, number, username, title, datetime, hit " +
                        "from board where (@rownum:=?)=?) A where rownumber>? and rownumber<=? " +
                        "order by rownumber asc";
                pstmt=conn.prepareStatement(sql);
                pstmt.setInt(1, total+1);
                pstmt.setInt(2, total+1);
                pstmt.setInt(3, startNo);
                pstmt.setInt(4, endNo);
                rs=pstmt.executeQuery();
                pstmt.close();
        %>
        <%
                if(total==0) {
        %>
        <tr align="center">
            <td colspan="5">등록된 글이 없습니다.</td>
        </tr>
        <%
                } else {
                    while(rs.next()) {
                        int number=rs.getInt(2);
                        String username=rs.getString(3);
                        String title=rs.getString(4);
                        String datetime=rs.getString(5);
                        int hit=rs.getInt(6);
                        %>
        <tr onclick="location.href='./view/?contentNumber=<%=number%>'">
            <td><%=number%></td>
            <td><%=title%></td>
            <td><%=username%></td>
            <td><%=datetime%></td>
            <td><%=hit%></td>
        </tr>
        <%
                    }
                }

            } catch(SQLException e) {
                rst="DB 연동 오류";
                msg=e.getMessage();
            } finally {
                if(pstmt!=null)
                    pstmt.close();
                if(conn!=null)
                    conn.close();
            }
        %>

        </tbody>
    </table>
    <!-- 페이징 처리 -->
    <nav class="NavPage">
        <ul class="pagination pagination-sm justify-content-center">
            <%
                totalPage = ((total - 1) / pageSize) + 1;
                int prevPage = (int)Math.floor((cpage - 1) / pageBlock) * pageBlock;
                int nextPage = prevPage + pageBlock + 1;
            %>
            <%
                if(prevBlock > 0) { %>
                <li class="page-item disabled ">
                    <a class="page-link" href="./?pageNum=<%=prevBlock%>" tabindex="-1" aria-disabled="true">이전</a>
                </li>
            <%
                }
            %>
            <%
                for(int i=1+prevBlock; i< nextBlock && i<=totalPage; i++) {
                    if(i==cpage) {
            %>
                <li class="page-item active" aria-current="page">
                    <a class="page-link" href="#"><%=i%> <span class="sr-only">(current)</span></a>
                </li>
            <%
                    } else {
            %>
                    <li class="page-item"><a class="page-link" href="./?pageNum=<%=i%>"><%=i%></a></li>
            <%
                    }
                }
            %>
            <%
                if (totalPage >= nextPage) {
            %>
                <li class="page-item">
                    <a class="page-link" href="./?pageNum=<%=nextPage%>">다음</a>
                </li>
            <%
                }
            %>
        </ul>
    </nav>
    <div class="writeAction">
        <button class="btnWrite btn btn-secondary">글쓰기</button>
    </div>
</section>
<footer></footer>

<!--JavaScript-->
<script src="../js/jQuery/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
<script src="../js/board.js" type="text/javascript"></script>
</body>
</html>