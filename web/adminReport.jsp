<%-- 
    Document   : adminReport
    Created on : 12-Apr-2014, 6:14:01 PM
    Author     : Milan
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="Objects.DatabaseHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">    
    <%!
        DatabaseHandler dbh = new DatabaseHandler();
        ArrayList result = new ArrayList();
        ArrayList result1 = new ArrayList();        
        ArrayList result2 = new ArrayList();        
        ArrayList result3 = new ArrayList();
        ArrayList result4 = new ArrayList();
    %>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Reports</title>

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
            <li class="active"><a href="adminReport.jsp">View Reports</a></li>
            <li><a href="contact.jsp">Contact</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>

    <!-- Page Content -->

    <div class="container">
      
      <div class="row">
      
        <div class="col-lg-12">
          <h1 class="page-header">ADMIN <small>Room Report</small></h1>
        </div>

      </div><!-- /.row -->
      
      <div class="row">

        <div class="col-sm-8">
            <h3>All the rooms.</h3>       
                    
            <table style="width: 1000px">
                        <tr><td><strong>Room#</strong></td><td><strong>Type</strong>
                            </td><td><strong>Beds</strong></td><td><strong>Price</strong></td></tr>
                     
         <%
        dbh.connect();
        result = dbh.select("SELECT * FROM hotelrooms", "ROOM#");
        result1 = dbh.select("SELECT * FROM hotelrooms", "ROOMTYPE");
        result2 = dbh.select("SELECT * FROM hotelrooms", "BEDS");
        result3 = dbh.select("SELECT * FROM hotelrooms", "PRICE");        
        dbh.close();
            for(int i=0; i<result.size(); i++){
                out.println("<tr><td>");
        out.println(result.get(i));      
                
        out.println("</td><td>");        
        out.println(result1.get(i));                    

        out.println("</td><td>");        
        out.println(result2.get(i));          
        
        out.println("</td><td>");        
        out.println("$" + String.format("%.2f", Double.parseDouble(result3.get(i).toString())));                    
        
        out.println("</td></tr>");                
            }
        %>
            </table>
        
        </div>

        
        <div class="col-sm-8">
            <h3>All the booked rooms.</h3>       
                    <br/>
                    <br/>
                    
                    <table style="width: 1000px">
                        <tr><td><strong>Room#</strong></td><td><strong>User</strong>
                            </td><td><strong>Needs</strong></td><td><strong>Date</strong></td></tr>
                        
         <%
        dbh.connect();
        result = dbh.select("SELECT * FROM hotelroomsbooked", "ROOM#");
        result1 = dbh.select("SELECT * FROM hotelroomsbooked", "BOOKINGNAME");
        result2 = dbh.select("SELECT * FROM hotelroomsbooked", "SPECIALNEEDS");
        result3 = dbh.select("SELECT * FROM hotelroomsbooked", "CHECKIN");
        result4 = dbh.select("SELECT * FROM hotelroomsbooked", "CHECKOUT");
        dbh.close();
            for(int i=0; i<result.size(); i++){
                
        out.println("<tr><td>");
        out.println(result.get(i));      
                
        out.println("</td><td>");        
        out.println(result1.get(i));                    

        out.println("</td><td>");        
        out.println(result2.get(i));          
        
        out.println("</td><td>");        
        out.println(result3.get(i));                    
        
        out.println("</td><td>");        
        out.println(result4.get(i));
        
        out.println("</td></tr>");

            }
            
        %>
                    </table>
        </div>
      </div><!-- /.row -->

    </div><!-- /.container -->

    <div class="container">

      <hr>

      <footer>
        <div class="row">
          <div class="col-lg-12">
            <p>Copyright &copy; Hotel 2014</p>
          </div>
        </div>
      </footer>

    </div><!-- /.container -->

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/modern-business.js"></script>

  </body>
</html>

