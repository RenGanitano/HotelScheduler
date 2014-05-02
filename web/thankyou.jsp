<%-- 
    Document   : thankyou
    Created on : 7-Apr-2014, 12:48:23 AM
    Author     : Renniel
--%>

<%@page import="Objects.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%!
    DatabaseHandler dbh = new DatabaseHandler();
    Room room;
    Customer customer;
    String s;
%>

<%
    if (request.getParameter("submitChange") == null) {
        if (request.getParameter("startDate") == null || request.getParameter("finishDate") == null) {
            response.sendRedirect(request.getParameter("previousurl"));
        } else {

        }
    }
%>

<%
    //room = new Room("");
    customer = ((Customer) session.getAttribute("Session"));
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thank you</title>
    </head>
    <body>
        <h1>Thanks for staying with us!</h1>
        <%
            dbh.connect();
            out.println("Thank you: " + customer.getUsername());
            try {
                out.println("<br>Room#: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "ROOM#").get(0));
                out.println("<br>Room type: " + dbh.select("SELECT * FROM HOTELROOMS WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "ROOMTYPE").get(0));
                out.println("<br>Special needs: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "SPECIALNEEDS").get(0));
                out.println("<br>Check in date: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "CHECKIN").get(0));
                out.println("<br>Check out date: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "CHECKOUT").get(0));
                out.println("<br>Balance Due(per night): $" + dbh.select("SELECT * FROM HOTELROOMS WHERE ROOM# = ".concat(request.getParameter("selectedRoom")), "PRICE").get(0));
            } catch(NullPointerException e) {
                s = request.getAttribute("room").toString();
                out.println("<br>Room#: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(s), "ROOM#").get(0));
                out.println("<br>Room type: " + dbh.select("SELECT * FROM HOTELROOMS WHERE ROOM# = ".concat(s), "ROOMTYPE").get(0));
                out.println("<br>Special needs: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(s), "SPECIALNEEDS").get(0));
                out.println("<br>Check in date: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(s), "CHECKIN").get(0));
                out.println("<br>Check out date: " + dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE ROOM# = ".concat(s), "CHECKOUT").get(0));
                out.println("<br>Balance Due(per night): $" + dbh.select("SELECT * FROM HOTELROOMS WHERE ROOM# = ".concat(s), "PRICE").get(0));
            }
            dbh.close();            
        %>
        <br>
        <a href="index.jsp">Click here to go back our homepage</a>
    </body>
</html>
