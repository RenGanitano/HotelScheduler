<%-- 
    Document   : orderchange
    Created on : 12-Apr-2014, 3:33:19 PM
    Author     : Renniel
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objects.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%!    
    ArrayList al = new ArrayList();
    DatabaseHandler dbh = new DatabaseHandler();
    Customer customer;
%>

<%
    dbh.connect();
    al = dbh.select("SELECT * FROM HOTELROOMSBOOKED WHERE BOOKINGNAME = '" + ((Customer) session.getAttribute("Session")).getUsername() + "'", "ROOM#");
    dbh.close();
%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Change Order</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/modern-business.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
  </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
          <a class="navbar-brand" href="index.jsp">Home</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav navbar-right">            
            <li><a href="signup.jsp">Register</a></li>
            <li><a href="service.jsp">Services</a></li>
            <li class="active"><a href="orderchange.jsp">Change Booking</a></li>
            <li><a href="contact.jsp">Contact</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>
        
        
        <h1>Please fill out the fields below to change your reservation.</h1>
        <form name="bookingform" action="orderchange.jsp">
            Start: DD/MM/YY
            <input type="text" name="startDate">
            End: DD/MM/YY
            <input type="text" name="finishDate">
            <br>
            <select name="selectedRoom">
                <%                    
                    for (int i = 0; i < al.size(); i++) {
                        out.println("<option value=\"" + ((Object)al.get(i)) + "\">" + al.get(i) + "</option>");
                    }
                    dbh.close();
                %>
            </select>
            <br>
            If you have any special requests please list them and we will do out best to meet your needs:
            <br>
            <textarea rows="4" cols="50" name="specialRequest"></textarea>
            <input type="submit" name='submitChange' value="Submit">        
            <input type="submit" name='cancelBooking' value="Cancel Booking">
            <input type="hidden" name='previousurl' value="orderchange.jsp">            
        </form>
    </body>
</html>

<%
    if (request.getParameter("submitChange") != null) {
        dbh.connect();
        if (request.getParameter("specialRequest") != null) {
            String special = request.getParameter("specialRequest");
            dbh.insert("UPDATE HOTELROOMSBOOKED SET SPECIALNEEDS = '".concat(special).concat("' WHERE BOOKINGNAME = '").concat(((Customer) session.getAttribute("Session")).getUsername().concat("' AND ROOM# = ").concat(request.getParameter("selectedRoom"))));
        } if(request.getParameter("startDate") != null) {
            String checkin = request.getParameter("startDate");
            dbh.insert("UPDATE HOTELROOMSBOOKED SET CHECKIN = '".concat(checkin).concat("' WHERE BOOKINGNAME = '").concat(((Customer) session.getAttribute("Session")).getUsername().concat("' AND ROOM# = ").concat(request.getParameter("selectedRoom"))));
        } if (request.getParameter("finishDate") != null) {
            String checkout = request.getParameter("finishDate");
            dbh.insert("UPDATE HOTELROOMSBOOKED SET CHECKOUT = '".concat(checkout).concat("' WHERE BOOKINGNAME = '").concat(((Customer) session.getAttribute("Session")).getUsername().concat("' AND ROOM# = ").concat(request.getParameter("selectedRoom"))));
        }
        RequestDispatcher rd = request.getRequestDispatcher("thankyou.jsp");
        request.setAttribute("submitChange", "submitChange");
        request.setAttribute("selectedRoom", request.getParameter("selectedRoom").toString());
        rd.forward(request, response);
        response.sendRedirect("thankyou.jsp");
    } else if (request.getParameter("cancelBooking") != null) {
        dbh.connect();
        dbh.deleteBooking(request.getParameter("selectedRoom").toString());        
        response.sendRedirect("service.jsp");
    }
    dbh.close();
%>
