<%
    session.invalidate();
    try {
        Cookie[] cookies = request.getCookies();

        if(cookies!=null) {
            for(int i=0;i<cookies.length;i++) {
                if (cookies[i].getName().equals("codewikiID") ||
                        cookies[i].getName().equals("codewikiUserName")) {
                    cookies[i].setMaxAge(0);
                    response.addCookie(cookies[i]);
                }
            }
        }
    } catch (Exception e) { }
    response.sendRedirect("../wiki/?codeID=codewiki");
%>