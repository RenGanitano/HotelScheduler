<%-- 
    Document   : service
    Created on : 22-Mar-2014, 2:29:48 PM
    Author     : Estevan
--%>

<%@page import="Objects.*"%>
<%@page import="javax.jms.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Services</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Add custom CSS here -->
        <link href="css/modern-business.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">

        <!-- JavaScript -->
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/bootstrap.js"></script>
        <script src="js/modern-business.js"></script>
    </head>


    <%!
        DatabaseHandler dbh = new DatabaseHandler();
    %>

    <%
        try {
            out.println("Logged in as: " + ((Customer) session.getAttribute("Session")).getUsername());
            if (((Customer) session.getAttribute("Session")).getUsername().equals("admin")) {
                response.sendRedirect("service_admin.jsp");
            }
        } catch (ClassCastException e) {
            out.println("Logged in as: " + session.getAttribute("Session"));
        }
        out.println("<br>Remember to login to book a room, if you do not have an account please join the community by clicking Register");

    %>
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
                    <a class="navbar-brand" href="index.jsp">Home</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="signup.jsp">Register</a>
                        </li>
                        <li class="active"><a href="service.jsp">Services</a>
                        </li>
                        <%                            try {
                                ((Customer) session.getAttribute("Session")).getUsername();
                                out.println("<li><a href=\"orderchange.jsp\">Change Booking</a></li>");
                            } catch (ClassCastException e) {

                            }

                        %>
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
                    <h1 class="page-header">Services
                        <small>Select A Room Of Your Choice</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="index.jsp">Home</a>
                        </li>
                        <li class="active">Services</li>
                    </ol>
                </div>

            </div>

            <div class="row">

                <div class="col-md-7">
                    <a href="">
                        <img class="img-responsive" src="rooms/regular.jpg">
                    </a>
                </div>

                <div class="col-md-5">
                    <h3>Regular Room</h3>

                    <a class="btn btn-primary" href="book_regular.jsp">Book Room</a>
                </div>

            </div>

            <hr>

            <div class="row">

                <div class="col-md-7">
                    <a href="">
                        <img class="img-responsive" src="rooms/suite.jpg">
                    </a>
                </div>

                <div class="col-md-5">
                    <h3>Deluxe Room</h3>

                    <a class="btn btn-primary" href="book_deluxe.jsp">Book Room</a>
                </div>

            </div>

            <hr>

            <div class="row">

                <div class="col-md-7">
                    <a href="">
                        <img class="img-responsive" src="rooms/family.JPEG">
                    </a>
                </div>

                <div class="col-md-5">
                    <h3>Suite</h3>

                    <a class="btn btn-primary" href="book_suite.jsp">Book Room</a>
                </div>

            </div>       

            <hr>
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

    </body>

</html>
