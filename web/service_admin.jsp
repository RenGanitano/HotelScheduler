<%--
    Document   : Service
    Created on : 22-Mar-2014, 2:29:48 PM
    Author     : Anthony
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Objects.DatabaseHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
    
    <%!
        DatabaseHandler dbh = new DatabaseHandler();
        ArrayList results;
        char view;
        int status;
    %>
    
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

<body>
    <%
        dbh.connect();
        results = dbh.select("SELECT * FROM hotelrooms WHERE booked = 'N'", "ROOM#");
        dbh.close();        

            if (request.getParameter("add") != null) {
                if (request.getParameter("view") != null) {
                    view = 'Y';
                } else {
                    view = 'N';
                }                                         
                dbh.connect();
                status = dbh.insert("INSERT INTO hotelrooms VALUES(" + request.getParameter("roomNum") + ", 'N', '" +
                        request.getParameter("roomType") + "', '" + view + "', " + request.getParameter("numBeds")
                        + ", " + request.getParameter("roomPrice") + ")");
                if (status == 0) {
                    out.print("Room added successfully");
                    results = dbh.select("SELECT * FROM hotelrooms WHERE booked = 'N'", "ROOM#");
                    dbh.close();
                }else { dbh.close(); }
            }else if (request.getParameter("edit") != null) {
                String roomNum = request.getParameter("editList");
                if (request.getParameter("view2") != null) {
                    view = 'Y';
                } else {
                    view = 'N';
                }
                dbh.connect();
                status = dbh.insert("UPDATE hotelrooms SET roomtype = '" + request.getParameter("roomType")
                        + "', withview = '" + view + "', beds = " + request.getParameter("numBeds")
                        + ", price = " + request.getParameter("roomPrice") + " WHERE room# = " + roomNum);
                if (status == 0) {
                    out.print("Room updated successfully");
                    results = dbh.select("SELECT * FROM hotelrooms WHERE booked = 'N'", "ROOM#");
                    dbh.close();
                }else { dbh.close(); }
            }else if (request.getParameter("remove") != null) {
                String roomNum = request.getParameter("removeList");
                dbh.connect();
                status = dbh.delete(roomNum);
                if (status == 0) {
                    out.print("Room deleted successfully");
                    results = dbh.select("SELECT * FROM hotelrooms WHERE booked = 'N'", "ROOM#");
                    dbh.close();
                }else { dbh.close(); }
                
            }else {}                                                                            
       

    %>
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
                    <li class="active"><a href="service_admin.jsp">Services</a>
                    </li>
                    <li><a href="adminReport.jsp">View Reports</a>
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
                <h1 class="page-header">Services</h1>
                <ol class="breadcrumb">
                    <li><a href="index.jsp">Home</a>
                    </li>
                    <li class="active">Services</li>
                </ol>
            </div>

        </div>

        <div class="row">

            <div class="col-md-7">
                <h3>Add Room</h3>
                
                <form method="post">
                    <table>
                        <tr>
                            <td><label>Room Number:</label></td>
                            <td><input type="text" name="roomNum" required /></td>
                        </tr>
                        <tr>
                            <td><label>Room Type:</label></td>
                            <td><input type="text" name="roomType" required /></td>
                        </tr>
                        <tr>
                            <td><label>View?</label></td>
                            <td><input type="checkbox" name="view" /></td>
                        </tr>
                        <tr>
                            <td><label>Number of Beds:</label></td>
                            <td><input type="number" name="numBeds" required /></td>
                        </tr>
                        <tr>
                            <td><label>Cost:</label></td>
                            <td><input type="number" name="roomPrice" required /></td>
                        </tr>
                    </table><br/>
                    <button type="submit" name="add">Add Room</button>
                    <input type="hidden" name="postback" value="true"/>
                </form>
            </div>

        </div>

        <hr>

        <div class="row">

            <div class="col-md-7">
                <h3>Edit Room</h3>
                    
                <form method="post">
                    <table>
                        <tr>
                            <td><label>Room Number:</label></td>
                            <td><select name="editList">
                                <% for (Object obj : results) { %>
                                <option><%= obj %></option>
                                <%} %>                                 
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label>Room Type:</label></td>
                            <td><input type="text" name="roomType" required /></td>
                        </tr>
                        <tr>
                            <td><label>View?</label></td>
                            <td><input type="checkbox" name="view2" /></td>
                        </tr>
                        <tr>
                            <td><label>Number of Beds:</label></td>
                            <td><input type="number" name="numBeds" required /></td>
                        </tr>
                        <tr>
                            <td><label>Cost:</label></td>
                            <td><input type="number" name="roomPrice" required /></td>
                        </tr>
                    
                    </table><br/>
                    <button type="submit" name="edit">Edit Room</button>
                </form>
            </div>

        </div>

        <hr>

        <div class="row">

            <div class="col-md-7">
                <h3>Remove Room</h3>
                
                <form method="post">
                    <table>
                        <tr>
                            <td><label>Room Number:</label></td>
                            <td><select name="removeList">
                                <% for (Object obj : results) { %>
                                <option><%= obj %></option>
                                <%} %>                                 
                                </select>
                            </td>
                        </tr>
                    </table><br/>
                    <button type="submit" name="remove">Remove Room</button>
                </form>
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