<%-- 
    Document   : HomePage
    Created on : 22-Mar-2014, 12:21:56 PM
    Author     : Estevan
--%>

<%@page import="Objects.*"%>
<%@page import="javax.jms.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%!
        DatabaseHandler dbh = new DatabaseHandler();
        Customer customer;
    %>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Hotel</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Add custom CSS here -->
        <link href="css/modern-business.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
    </head>

    <%

        if (request.getParameter("logout") != null) {
            response.sendRedirect("/HotelScheduler2/logout.jsp");
        }

        dbh.connect();
        if (dbh.select("SELECT USERNAME FROM HOTELUSERS", "USERNAME").contains(request.getParameter("username"))) {
            if (dbh.select("SELECT PASSWORD FROM HOTELUSERS WHERE USERNAME = '".concat(request.getParameter("username").concat("'")), "PASSWORD").contains(request.getParameter("password"))) {
                //out.println(request.getParameter("password"));
                //out.println(dbh.select("SELECT PASSWORD FROM HOTELUSERS WHERE USERNAME = '".concat(request.getParameter("username").trim().concat("'")), "PASSWORD"));
                customer = new Customer(request.getParameter("username"), request.getParameter("password"));
                session.setAttribute("Session", customer);
                if (((Customer) session.getAttribute("Session")).getUsername().equals("admin")) {
                    response.sendRedirect("/HotelScheduler2/service_admin.jsp");
                } else {
                    response.sendRedirect("/HotelScheduler2/service.jsp");
                }
            }
        } else {

        }
        dbh.close();


    %>
    <%        if (session.getAttribute("Session") == null) {
            session.setAttribute("Session", "Guest");
        } else {
            //out.println(session.getAttribute("Session"));
        }
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
                    <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
                    <a class="navbar-brand" href="index.jsp">Enjoy your stay!</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="signup.jsp">Register</a>
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

        <div id="myCarousel" class="carousel slide">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="item active">
                    <div class="fill" style="background-image:url('HotelImages/hotelImage4.jpg');"></div>
                    <div class="carousel-caption">
                        <!--<h1>Come and Take A Gander You Will not be Disappointed</h1>-->
                    </div>
                </div>
                <div class="item">
                    <div class="fill" style="background-image:url('HotelImages/hotelImage5.jpg');"></div>
                    <div class="carousel-caption">
                        <!--<h1>You Can't Miss Our Sign</h1>-->
                    </div>
                </div>
                <div class="item">
                    <div class="fill" style="background-image:url('HotelImages/hotelImage1.jpg');"></div>
                    <div class="carousel-caption">
                        <!--<h1>Our Hallways Will Leave You BreathLess</a>-->                        
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="icon-next"></span>
            </a>
        </div>

        <div class="section text-center">

            <div class="container">

                <div class="row">
                    <div class="col-lg-12">
                        <h2>
                            <%
                                try {
                                    out.println("Welcome back, " + ((Customer) session.getAttribute("Session")).getUsername());
                                } catch (ClassCastException e) {
                                    out.println("Welcome back, " + session.getAttribute("Session"));
                                }

                            %></h2>
                        <h2>Hotel Motto Here</h2>
                        <p>Hotel History Here, What happens if there's a lot of text does it keep going down or does the page mess up something something something something something something</p>
                        <%--<hr>--%>
                        <%                            if (session.getAttribute("Session") != null && session.getAttribute("Session").equals("Guest")) {
                        %>
                        <form name ="login" role="form" method="POST">
                            <%--<div class="row">--%>
                            <%--PADDING START --%>
                            <div class="form-group col-lg-2">	                
                                <input type="hidden" name="none" class="form-control" id="1">
                            </div>
                            <%--PADDING END --%>
                            <div class="form-group col-lg-4">
                                <label for="input1">User Name</label>
                                <input type="text" name="username" class="form-control" id="input1">
                            </div>
                            <div class="form-group col-lg-4">
                                <label for="input2">Password</label>
                                <input type="password" name="password" class="form-control" id="input2">
                            </div>
                            <div class="form-group col-lg-12">
                                <input type="hidden" name="save" value="contact">                        
                                <input type="submit" name="login" value="Login" /> 
                            </div>
                            <%--</div>--%>
                        </form >
                        <%
                        } else {
                        %>
                        <form name ="Logout" method="POST" action="logout.jsp">

                            <input type="submit" name="logout" value="Logout" />  
                        </form>
                        <%
                            }

                        %>
                    </div>
                </div>
                <!-- /.row -->





            </div>
            <!-- /.container -->


        </div>
        <!-- /.section-colored -->


        <div class="section-colored">

            <div class="container">

                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <h2>Take A Swim and Relax By The Pool</h2>
                        <ul>

                        </ul>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <img class="img-responsive" src="HotelImages/hotelImage2.jpg">
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->

        </div>
        <!-- /.section-colored -->

        <div class="section">

            <div class="container">

                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <img class="img-responsive" src="HotelImages/hotelImage3.jpg">
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">

                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container -->

        </div>
        <!-- /.section -->

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

