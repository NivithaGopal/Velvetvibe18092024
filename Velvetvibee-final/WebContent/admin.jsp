<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="dao.GalleryDAO"%>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - VELVETVIBE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet"> <!-- Added Font Awesome -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .navbar {
            margin-bottom: 20px;
            background-color: #f1f1f1; /* Light gray color */
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: #333; /* Darker text color for contrast */
        }
        .navbar-nav .nav-link {
            font-size: 1.1rem;
            font-weight: 500;
            color: #333; /* Darker text color for contrast */
        }
        .navbar-nav .nav-link:hover {
            color: #495057; /* Slightly darker on hover */
        }
        .dropdown-menu {
            min-width: 180px;
        }
        h1 {
            text-align: center;
            margin-top: 50px;
            font-size: 2.5rem;
            font-weight: bold;
            color: #212529;
        }
        .card {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
        .card-services {
            background-color: gray; /* Match card color with navbar */
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card-body {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 20px;
        }
        .card-body img {
            border-radius: 50%; /* Makes the image circular */
            max-width: 100px;
            height: auto;
            margin-right: 20px; /* Increased margin for spacing */
        }
        .card-body .text-content {
            flex: 1;
        }
        .card-body .card-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #f8f9fa;
            margin-bottom: 10px; /* Adds spacing between title and content */
        }
        .card-body p {
            font-size: 1.25rem;
            margin: 0;
        }
    </style>
</head>

<body>

	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><strong>VELVETVIBE</strong></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="servicesDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Services </a>
						<ul class="dropdown-menu" aria-labelledby="servicesDropdown">
							<li><a class="dropdown-item" href="addService.jsp">Add
									New Service</a></li>
							<li><a class="dropdown-item" href="viewService.jsp">View
									Services</a></li>
							<li><a class="dropdown-item" href="addServiceCategory.jsp">Add
									Service Category</a></li>
							<li><a class="dropdown-item" href="viewServiceCategory.jsp">View
									Service Category</a></li>
									<li><a class="dropdown-item" href="addServiceVelvetvibe.jsp">Add
									Service Category Details</a></li>
							<li><a class="dropdown-item" href="viewServiceVelvetvibe.jsp">View
									Service Category Details</a></li>
						</ul></li>
				</ul>

				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#">Appointments</a>
					</li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#">Customers</a>
					</li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="viewGallery.jsp">Gallery</a></li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="viewFeedback.jsp">CustomerFeedback</a></li>
				</ul>
				<ul class="navbar-nav ms-auto">
					<a class="nav-link" href="logout.jsp"> <i
						class="fas fa-sign-out-alt"></i>
					</a>
				</ul>
			</div>
		</div>
	</nav>
	<div class="welcome-message">
		<%
			HttpSession httpsession = request.getSession(false); // Retrieve existing session or null if none exists
			String role = null;

			if (httpsession != null) {
				role = (String) httpsession.getAttribute("role");
			}

			if (role == null || !"admin".equals(role)) {
				response.sendRedirect("login.jsp"); // Redirect to login page if not logged in or not an admin
				return;
			}
		%>
	</div>
	<div class="container">
		<h1>Dashboard</h1>
		<div class="row">
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<img src="./images/service-img.jpg" alt="Services Image">
						<div class="text-content">
							<h5 class="card-title">Services</h5>
							<p class="card-text">
								<%
									ServiceDAO dao = new ServiceDAO();
									int servicesCount = 0;
									try {
										servicesCount = dao.getServicesCount();
									} catch (SQLException e) {
										e.printStackTrace();
									}
								%>
								<%=servicesCount%>
							</p>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<img src="./images/service-img2.jpg" alt="Appointments Image">
						<div class="text-content">
							<h5 class="card-title">Appointments</h5>
							<p class="card-text">15</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<img src="./images/service-img3.jpg" alt="Customers Image">
						<div class="text-content">
							<h5 class="card-title">Customers</h5>
							<p class="card-text">20</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="card text-center card-services">
					<div class="card-body">
						<img src="./images/service-img4.jpg" alt="Gallery Image">
						<div class="text-content">
							<h5 class="card-title">Gallery</h5>
							<p class="card-text">
								<%
									GalleryDAO dao1 = new GalleryDAO();
									int galleryCount = 0;
									try {
										galleryCount = dao1.galleryCount(); // Call galleryCount method
									} catch (SQLException e) {
										e.printStackTrace();
									}
								%>
								<%=galleryCount%>
								<!-- Display the count here -->
							</p>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
