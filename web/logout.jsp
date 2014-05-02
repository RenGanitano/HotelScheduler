<%-- 
    Document   : logout
    Created on : 1-Apr-2014, 3:09:05 PM
    Author     : Renniel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             session.invalidate();
             response.sendRedirect("/HotelScheduler2/index.jsp");
                     
            %>
    </body>
</html>
