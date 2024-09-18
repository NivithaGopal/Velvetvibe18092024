
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="dao.UserProfileDAO"%>

<%
    HttpSession httpsession = request.getSession(false);
    String email = null;

    // Retrieve the email from the session
    if (httpsession != null) {
        email = (String) httpsession.getAttribute("email");
    }

    // Redirect to login if session does not exist or email is not found
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch user details from the database
    UserProfileDAO userDAO = new UserProfileDAO();
    UserProfileBean user = userDAO.getUserByEmail(email);

    if (user == null) {
        response.sendRedirect("login.jsp?message=User not found");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    
    <script type="text/javascript">
    function validateForm() {
    	
    	var fullName = document.getElementById("fullName").value;
    	var dob = document.getElementById("dob").value;

    	var address = document.getElementById("address").value;
    	var mobileNumber = document.getElementById("mobileNumber").value;

    	// Regex patterns
        var fullNamePattern = /^[a-zA-Z\s]+$/; // Only letters and spaces
        var addressPattern = /^[a-zA-Z0-9\s,.-]+$/; // Alphanumeric characters, spaces, commas, periods, and dashes
        var mobileNumberPattern = /^[6-9]\d{9}$/; // Starts with 6-9 and followed by 9 digits

    	
    	if (fullName == "") {
            alert("Full Name required");
            document.getElementById("fullName").focus();
            return false;
        }
    	if (!fullNamePattern.test(fullName)) {
            alert("Full Name should contain only letters and spaces");
            document.getElementById("fullName").focus();
            return false;
        }
    	
    	if (dob == "") {
            alert("DOB required");
            document.getElementById("dob").focus();
            return false;
        }
    	 
    	if (address == "") {
            alert("Address required");
            document.getElementById("address").focus();
            return false;
        }
    	if (!addressPattern.test(address)) {
	        alert("Address should contain only alphanumeric characters and ,.-");
	        document.getElementById("address").focus();
	        return false;
	    }
    	if (mobileNumber == "") {
            alert("Mobile Number required");
            document.getElementById("mobileNumber").focus();
            return false;
        }
    	if (!mobileNumberPattern.test(mobileNumber)) {
            alert("Mobile Number should be a valid Indian number starting with 6-9 and exactly 10 digits");
            document.getElementById("mobileNumber").focus();
            return false;
        }
    	
    	return true;
    	
		
	}
    
    </script>
</head>
<body>
    <div class="container mt-4">
        <h2>User Profile</h2>
        <form action="userProfileAction.jsp" method="post" onsubmit="return validateForm()">
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" id="fullName" name="fullName" class="form-control" value="<%= user.getFullName() %>" >
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Date of Birth</label>
                <input type="date" id="dob" name="dob" class="form-control" value="<%= user.getDob() %>" >
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" id="address" name="address" class="form-control" value="<%= user.getAddress() %>" >
            </div>
            <div class="mb-3">
                <label for="mobileNumber" class="form-label">Mobile Number</label>
                <input type="text" id="mobileNumber" name="mobileNumber" class="form-control" value="<%= user.getMobileNumber() %>" >
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 