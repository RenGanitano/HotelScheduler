<%-- 
    Document   : room_test
    Created on : 1-Apr-2014, 11:17:58 PM
    Author     : Renniel
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Objects.*"%>
<!DOCTYPE html>

<%!
    DatabaseHandler dbh = new DatabaseHandler();
    ArrayList roomNums = new ArrayList();
    ArrayList roomTypes = new ArrayList();
    ArrayList roomIsFree = new ArrayList();
    
    ArrayList roomList = new ArrayList();
    Room room;
%>

<%
    dbh.connect();
    roomNums = dbh.select("SELECT * FROM HOTELROOMS", "ROOM#");
    roomTypes = dbh.select("SELECT * FROM HOTELROOMS", "ROOMTYPE");
    roomIsFree = dbh.select("SELECT * FROM HOTELROOMS", "BOOKED");
    dbh.close();
    //out.println(roomNums);
    //out.println(roomTypes);
    //out.println(roomIsFree);
    for(int i = 0; i < roomNums.size(); i++) {
        room = new Room(roomNums.get(i).toString(), roomTypes.get(i).toString());
        roomList.add(room);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Room Page</title>
    </head>
    <body>
        <%
            for (int i = 0; i < roomList.size(); i++) {
                out.println("<p>" + ((Room)roomList.get(i)).roomNum + ((Room)roomList.get(i)).type + "</p>");
            }            
        %>
    </body>
</html>
