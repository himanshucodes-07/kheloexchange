<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

		<!DOCTYPE html>
		<html>
		<head>
			<title>Khelo Exchanges</title>
			<meta charset="UTF-8">
			<meta name="description" content="Game Warrior Template">
			<meta name="keywords" content="warrior, game, creative, html">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<!-- Favicon -->
			<link href="img/favicon.png" rel="shortcut icon" />
			<!-- Google Fonts -->
			<link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i" rel="stylesheet">

			<!-- Stylesheets -->
			<link rel="stylesheet" href="css/bootstrap.min.css" />
			<link rel="stylesheet" href="css/font-awesome.min.css" />
			<link rel="stylesheet" href="css/owl.carousel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/animate.css" />
			<link rel="stylesheet" href="css/login.css" />
			<link rel="stylesheet" href="css/admin-login.css">
			<link rel="stylesheet" href="css/walletBalanceTransferRequest.css">
			<!-- livechat style -->
			<link rel="stylesheet" href="css/responsive.css"/>
			<link rel="stylesheet" href="css/error-container.css"/>
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
			<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
			<!-- Font Awesome kit -->
			<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
			
		</head>

		<body>
			<!-- Page Preloder -->
			<!-- <div id="preloder">
				<div class="loader"></div>
			</div> -->
			<c:if test="${empty adminId}">
		        <%
		        	session.setAttribute("errorMessage", "Unauthorized!");
		            response.sendRedirect("admin-login");
		        %>
			</c:if>

			<!-- Header section -->
			<header class="header-section">
				<div class="container">
					<!-- logo -->
					<a class="site-logo" href="adminDashboard">
						<img src="img/logo.png" alt="">
					</a>

					<!-- responsive -->
					<div class="nav-switch">
						<i class="fa fa-bars"></i>
					</div>
					<!-- site menu -->
					<nav class="main-menu">
						<div class="details" style="display: flex; justify-content: space-between;">
							<div class="homedetails" style="float:none;">
								<ul>
									<li><a href="adminDashboard">Dashboard</a></li>
									<li><a href="fetchDepositRequest">Deposit Request</a></li>
									<li><a href="fetchCreateId">Create Id Request</a></li>
									<li><a href="fetchGames">Update Game website</a></li>
									<li><a href="fetchAllUpi">Payment method updation</a></li>
									<li><a href="fetchAllWithdrawRequest">Withdraw Request</a></li>
									<li><a href="fetchGameImages">Game Image Upload</a></li>
									<li><a href="fetchAllIplContestParticipantUser">IPL Contest Participant</a></li>
									<li><a href="fetchAllWalletBalanceTransferRequest">Wallet Balance Transfer Request</a></li>
									<li><a href="registerNewUser">Register New User</a></li>
									<li><a href="adminLogout">Logout</a></li>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</header>
			<!-- Header section end -->

			<div>
				<c:if test="${not empty errorMessage}">
					<div class="errorContainer">${errorMessage}</div>
					<% session.removeAttribute("errorMessage"); %>
				</c:if>
				<c:if test="${not empty message}">
					<div class="errorContainer">${message}</div>
					<% session.removeAttribute("message"); %>
				</c:if>
			</div>
			<div class="drequest">
				<c:if test="${not empty walletBalanceTransferRequests}">
						<h1 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">Pending Wallet Balance Transfer Request</h1>
						<div class="container">
						<table id="example" class="table table-striped table-responsive border-dark table-hover text-center">
							<thead class="table-dark table-active text-uppercase text-whites">
								<tr>
									<th>Transaction Id</th>
									<th>Mobile</th>
									<th>Name</th>
									<th>Username</th>
									<th>Website Name</th>
									<th>Website</th>
									<th>Amount</th>
									<th>Timestamp</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${walletBalanceTransferRequests}" var="pendingRequest">	
									<c:if test="${not pendingRequest.status }">
										<tr>
											<td>${pendingRequest.id }</td>
											<td>${pendingRequest.mobile}</td>
											<td>${pendingRequest.name }</td>
											<td>${pendingRequest.websiteUsername}</td>
											<td>${pendingRequest.websiteName}</td>
											<td>${pendingRequest.website}</td>
											<td>${pendingRequest.amount}</td>
											<td>${pendingRequest.timestamp}</td>
											<td>
												<button onclick="showActionDiv(${pendingRequest.id})">Action</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						</div>
						
						<h1 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">Complete Wallet Balance Transfer Request</h1>
						<div class="container">
						<table id="example" class="table table-striped table-responsive border-dark table-hover text-center">
							<thead class="table-dark table-active text-uppercase text-whites">
								<tr>
									<th>Transaction Id</th>
									<th>Mobile</th>
									<th>Name</th>
									<th>Username</th>
									<th>Website Name</th>
									<th>Website</th>
									<th>Amount</th>
									<th>Timestamp</th>
									<th>Remark</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${walletBalanceTransferRequests}" var="pendingRequest">	
									<c:if test="${pendingRequest.status }">
										<tr>
											<td>${pendingRequest.id }</td>
											<td>${pendingRequest.mobile}</td>
											<td>${pendingRequest.name }</td>
											<td>${pendingRequest.websiteUsername}</td>
											<td>${pendingRequest.websiteName}</td>
											<td>${pendingRequest.website}</td>
											<td>${pendingRequest.amount}</td>
											<td>${pendingRequest.timestamp}</td>
											<td>
												${pendingRequest.remark}
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						</div>						
				</c:if>
			</div>
			
			<div id="actionDiv">
			</div>
			<div id="loadingDiv">
				<img alt="loading" src="img/loading/loading in circle.gif">
			</div>
			<!-- Footer section -->
			<footer class="footer-section">
				<div class="container">
					<ul class="footer-menu">
						<li><a href="adminDashboard">Dashboard</a></li>
						<li><a href="fetchDepositRequest">Deposit Request</a></li>
						<li><a href="fetchCreateId">Create Id Request</a></li>
						<li><a href="fetchGames">Update Game website</a></li>
						<li><a href="fetchAllUpi">Payment method updation</a></li>
						<li><a href="adminLogout">Logout</a></li>
					</ul>
				</div>
			</footer>
			<!-- Footer section end -->


			<!--====== Javascripts & Jquery ======-->
			<script src="js/depositRequest.js"></script>
			<script src="js/jquery-3.2.1.min.js"></script>
			<script src="js/bootstrap.min.js"></script>
			<script src="js/owl.carousel.min.js"></script>
			<script src="js/jquery.marquee.min.js"></script>
			<script src="js/main.js"></script>
			<script src="js/login.js"></script>
			<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		</body>

		</html>