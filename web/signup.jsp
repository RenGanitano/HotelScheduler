<%-- 
    Document   : signup
    Created on : 22-Mar-2014, 2:54:31 PM
    Author     : Estevan
--%>

<%@page import="Objects.DatabaseHandler"%>

<%@page import="javax.jms.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Register</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/modern-business.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
  </head>

  <body>
      
      <!--        <%   
    if (request.getParameter("register") != null) {
        if (request.getParameter("firstName").equals("") || request.getParameter("lastName").equals("") ||
                request.getParameter("email").equals("") || request.getParameter("phoneNumber").equals("") ||
                request.getParameter("username").equals("") || request.getParameter("password1").equals("") ||
                request.getParameter("password2").equals("")) { 
                out.print("Please complete the form in its entirety.");
        }
    } 
%> -->

<%! DatabaseHandler dbh = new DatabaseHandler(); %>

<% 
if (request.getParameter("register") != null) {
    
    if (request.getParameter("password1").equals(request.getParameter("password2")) && !request.getParameter("password1").equals("")) {
        dbh.connect();
    
        if (dbh.select("SELECT USERNAME FROM HOTELUSERS", "USERNAME").contains(request.getParameter("username"))) { %>
    
        <h2>Username already exists, please try a different username.</h2>
        
<%      } else {
            int result = dbh.insert("INSERT INTO HOTELUSERS VALUES('" + request.getParameter("username") + "', '" + request.getParameter("password1")
                + "', 'N', '" + request.getParameter("firstName") + "', '" + request.getParameter("lastName")
                + "', '" + request.getParameter("phoneNumber") + "', '" + request.getParameter("email") + "')");
            dbh.close(); 
            if (result == 0) {%>
            
            <h2>Account created successfully, you can now log in <a href='index.jsp'>here</a>.</h2>
            
<%        }else { %>
            <h2>Unexpected error. Your account has not been created, please try again.</h2>
<%        }
        }
    
        }else if (!request.getParameter("password1").equals(request.getParameter("password2"))) { %>
            <h2>Passwords entered do not match!</h2>
<!--            out.print("Passwords entered do not match!"); -->
<%        }else if (request.getParameter("password1").equals(request.getParameter("password2")) && request.getParameter("password1").equals("")) { %>
            <h2>Password field can not be empty!</h2>
             <!--   out.print("Password field can not be empty!"); -->
<%        }
    
}    
        
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
          <!-- You'll want to use a responsive image option so this logo looks good on devices - I recommend using something like retina.js (do a quick Google search for it and you'll find it) -->
          <a class="navbar-brand" href="index.jsp">Home</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav navbar-right">                       
            <li class="active"><a href="signup.jsp">Register</a></li>
            <li><a href="service.jsp">Services</a></li>
            <li><a href="contact.jsp">Contact</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>

    <!-- Page Content -->

    <div class="container">
      
      <div class="row">
      
        <div class="col-lg-12">
          <h1 class="page-header">Registration <small>Join The Community</small></h1>
        </div>

      </div><!-- /.row -->
      
      <div class="row">

        <div class="col-sm-8">
             <% 
                if(session.getAttribute("Session") != null && session.getAttribute("Session").equals("Guest"))  
                {
                        %>
         <form name="login" method="post">
	            <div class="row">
                        
                        
                        
	              <div class="form-group col-lg-4">
	                 <label id="fname">First Name:</label>
                         <input type="text" name="firstName" value="${param.firstName}" required />                                                
	              </div>
                      
                                                     
                        
	              <div class="form-group col-lg-4">
	                <label id="lname">Last Name:</label>
                        <input type="text" name="lastName" value="${param.lastName}" required />
                      </div>
                      
                      
                      
                      
                      <div class="form-group col-lg-4">
                          <label id="mail">Email Address:</label> 
                        <input type="text" name="email" value="${param.email}" required />
	              </div>
                      
                      
                      
                      
                      <div class="form-group col-lg-4">
	               <label id="phone">Phone Number:</label>
                        <input type="text" name="phoneNumber" value="${param.phoneNumber}" required />
	              </div>
                      
                      
                      
                      
                      <div class="form-group col-lg-4">
	                <label id="uname">Username:</label>
                        <input type="text" name="username" value="${param.username}" required />
	              </div>
                      
                      
                      
                      
                      <div class="form-group col-lg-4">
                          <label id="pword1">Enter Password:</label>
                        <input type="password" name="password1" required />
                      </div>
                      
                      
                      
                      
                      <div class="form-group col-lg-4">
                          <label id="pword2">Retype Password:</label>
                          <input type="password" name="password2" required />
                      </div>
                      
                      
                      
	                <div class="form-group col-lg-12">
	                   <input type="submit" name="register" value="Register" />
                        <input type="reset" name="clear" value="Clear" />
	              </div>
              </div>
            </form>
                      <%}
                else {
                    out.println("Please Logout to Register.");%>
<form method="post" action="logout.jsp">
    
	     <input type="submit" name="register" value="Logout" />
</form>
                
                <%}%>
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

