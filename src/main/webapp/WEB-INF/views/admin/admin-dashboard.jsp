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
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/owl.carousel.css"/>
	<link rel="stylesheet" href="css/style.css"/>
	<link rel="stylesheet" href="css/animate.css"/>
	<link rel="stylesheet" href="css/login.css"/>
	<!-- livechat style -->
	<link rel="stylesheet" href="css/loading-style.css" />
	<link rel="stylesheet" href="css/responsive.css"/>
	<!-- Font Awesome kit -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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

		<div class="transactionDetail">
			<div>
			<button type="button" class="close" onclick="closeDialogueBox()" data-dismiss="contestDiv" aria-label="Close">
		      <span aria-hidden="true">&times;</span>
		    </button>
			<h2 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">Wallet Transaction History</h2>
			<div class="container">
				<table id="example" class="table table-striped table-responsive border-dark table-hover">
					<thead class="table-dark table-active text-uppercase text-whites">
						<tr>
							<th scope="col">Transaction Id</th>
							<th scope="col">Remark</th>
							<th scope="col">Amount</th>
							<th scope="col">Cr/Dr</th>
							<th scope="col">Total Remaining Amount</th>
							<th scope="col">Timestamp</th>
						</tr>
					</thead>
					<tbody id="transactionDetail">
			
					</tbody>
				</table>
				</div>
				</div>
			</div>
			<div class="myIdDialogue">
				<div>
					<button type="button" class="close" onclick="closeMyIdDialogue()" data-dismiss="contestDiv" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				    </button>
					<h2 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">My Id</h2>
					<div class="container">
						<table id="example" class="table table-striped table-responsive border-dark table-hover">
							<thead class="table-dark table-active text-uppercase text-whites">
								<tr>
									<th>Order Id </th>
									<th>Website Name</th>
									<th>Username</th>
									<th>Password</th>
									<th>Status</th>
									<th>Links</th>
									<th>Change Website Password</th>
								</tr>
							</thead>
							<tbody id="myIdBody">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="loadingImage">
	           	<img src="img/loading/loading in circle.gif" alt="loading"/>
           </div>
			<div class="myIdChangePasswordForm">
				<div>
					<button type="button" class="close closeBlack" onclick="closeChangeMyIdPasswordDialogueBox()" data-dismiss="contestDiv" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				    </button>
					<form id="gameForm">
						<h2>Change Password</h2>
						<input type="hidden" id="gameId" />
						<div class="form-group">
					    	<label for="gamePassword">Password</label>
					    	<input type="password" id="gamePassword" class="form-control" required />
						</div>
						<button type="submit" class="btn btn-success">Change Password</button>
					</form>
				</div>
			</div>
			
			<div class="userChangePasswordForm">
				<div>
					<button type="button" class="close closeBlack" onclick="closeChangeUserPasswordDialogueBox()" data-dismiss="contestDiv" aria-label="Close">
				      <span aria-hidden="true">&times;</span>
				    </button>
					<form id="userForm">
						<h2>Change Password</h2>
						<input type="hidden" id="userId" />
						<div class="form-group">
					    	<label for="userPassword">Password</label>
					    	<input type="password" id="userPassword" class="form-control" required />
						</div>
						<button type="submit" class="btn btn-success">Change Password</button>
					</form>
				</div>
			</div>
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
			
		<section>
			<div class="card">
				<h2 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">user List</h2>
				<div class="container">
					<table id="example" class="table table-striped table-responsive border-dark table-hover">
						<thead class="table-dark table-active text-uppercase text-whites">
							<tr>
								<th scope="col">S.No.</th>
								<th scope="col">User id</th>
								<th scope="col">Name</th>
								<th scope="col">Email id</th>
								<th scope="col">Mobile No.</th>
								<th scope="col">Joining Date & Time</th>
								<th scope="col">Total Deposit</th>
								<th scope="col">Total Withdraw</th>
								<th scope="col">Total Wallet Balance</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody id="userDetail">
							
						</tbody>
					</table>
				</div>
			</div>
		</section>
		
				<section>
			<div class="card">
				<h2 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">User Services</h2>
				<div class="container">
					<table id="example" class="table table-striped table-responsive border-dark table-hover">
						<thead class="table-dark table-active text-uppercase text-whites">
							<tr>
								<th scope="col">S.No.</th>
								<th scope="col">User id</th>
								<th scope="col">Email id</th>
								<th scope="col">Mobile No.</th>
								<th scope="col">Show External Id</th>
								<th scope="col">Change Sign In Password</th>
							</tr>
						</thead>
						<tbody id="userService">
							
						</tbody>
					</table>
				</div>
			</div>
		</section>
		
				<!--====== Javascripts & Jquery ======-->
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/loading.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/admin-dashboard.js"></script>
	<script src="js/main.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

		</body>

		</html>