<%-- 
    Document   : book_suite
    Created on : 2-Apr-2014, 11:58:28 PM
    Author     : Renniel
--%>

<%@page import="Objects.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    DatabaseHandler dbh = new DatabaseHandler();
    Room room;
    Customer customer;
    int i;
%>

<%
    if (session.getAttribute("Session") == "Guest") {
        response.sendRedirect("service.jsp");
    } else {
        dbh.connect();
        if (dbh.select("SELECT * FROM HOTELROOMS WHERE BOOKED = 'N' AND ROOMTYPE = 'Suite'", "ROOM#").size() == 0) {
        response.sendRedirect("service.jsp");
    } else {

    }
    dbh.close();
    }    
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Suite Room</title>

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
                <a class="navbar-brand" href="index.jsp">Enjoy Your Stay!</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="index.jsp">Home</a>
                    </li>
                    <li><a href="service.jsp">Services</a>
                    </li>
                    <li><a href="contact.jsp">Contact</a>
                    </li>                                     
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <div class="container">

        <div class="row">

            <div class="col-lg-12">
                <h1 class="page-header">Suite
                    <small>Room</small>
                </h1>
                <ol class="breadcrumb">
                    <li><a href="index.jsp">Home</a>
                    </li>
                    <li class="active">Suite</li>
                </ol>
            </div>

        </div>

        <div class="row">

            <div class="col-lg-12">
               
                <p class="lead">Please fill out all information regarding with your room.</p>
                
              
         <form name="bookingform" action="">
            Start: DD/MM/YY
            <input type="text" name="startDate" required>
            End: DD/MM/YY
            <input type="text" name="finishDate" required>
            <br /> <br />
            If you have any special requests please list them and we will do out best to meet your needs:
            <br /> <br />
            <textarea rows="4" cols="50" name="specialRequest"></textarea>
            <br /> <br />
            <input type="submit" name='submitSuite' value="Submit">
            <input type="hidden" name='previousurl' value="book_suite.jsp">
            <input type="hidden" name='room'>
        </form>
            </div>

        </div>

    </div>
    <!-- /.container -->

    <div class="container">

        <hr>

        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Hotel 2014</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/modern-business.js"></script>

</body>

</html>


<%
    if (request.getParameter("submitSuite") != null) {
        dbh.connect();
        customer = new Customer(((Customer) session.getAttribute("Session")), "Suite");
        try {
            i = Integer.parseInt(dbh.select("SELECT * FROM HOTELROOMS WHERE ROOMTYPE = 'Suite' AND BOOKED = 'N'", "ROOM#").get(0).toString());
            customer.getRoom().roomNum = String.valueOf(i);
            dbh.insertBookRoom(i, customer.getUsername(), request.getParameter("specialRequest"), request.getParameter("startDate"), request.getParameter("finishDate"));
            dbh.insert("UPDATE HOTELROOMS SET BOOKED = 'Y' WHERE ROOM# = " + customer.getRoom().roomNum);
        } catch(NullPointerException e) {
            response.sendRedirect("bookingfull.jsp");
        }
        dbh.close();
        session.setAttribute("Session", customer);
        RequestDispatcher rd = request.getRequestDispatcher("thankyou.jsp");
        request.setAttribute("previousurl", "book_suite.jsp");
        request.setAttribute("startDate", request.getParameter("startDate"));
        request.setAttribute("finishDate", request.getParameter("finishDate"));
        request.setAttribute("room", i);
        rd.forward(request, response);
        response.sendRedirect("thankyou.jsp");
    }
%>