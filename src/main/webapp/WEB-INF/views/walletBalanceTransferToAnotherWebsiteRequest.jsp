<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="zxx">
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

	<link rel="stylesheet" href="css/style.css"/>
	<link rel="stylesheet" href="css/error-container.css"/>

	<link rel="stylesheet" href="./css/home.css">
    <link rel="stylesheet" href="./css/registration.css">
	<link rel="stylesheet" href="css/responsive.css"/>
	<link rel="stylesheet" href="css/contestForm.css"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
</head>
<body>
	<!-- Page Preloder -->
	<!-- <div id="preloder">
		<div class="loader"></div>
	</div> -->
	
	<c:if test="${empty userId}">
		<%
			response.sendRedirect("login");
		%>
	</c:if>
	<!-- Header section -->
		<header class="header-section">
				<div class="container">
					<!-- logo -->
					<a class="site-logo" href="/">
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
									<li><a href="/">Home</a></li>
									<li><a href="review">Games</a></li>
									<li><a href="fetchIdDetails">Create Id and My Ids</a></li>
									<li><a href="contact">Contact</a></li>
									<div class="hideItem">
										<li>
											<a href="fetchUpiDetails">
												<i class="fa-solid fa-file-arrow-down" style="color:green"></i>
												Deposit
											</a>
										</li>
										<li>
											<a href="withdraw">
												<i class="fa-solid fa-file-arrow-up" style="color:red"></i>
												Withdraw
											</a>
							
										</li>
										<c:choose>
											<c:when test="${not empty userId}">
												<li>
													<a href="fetchProfile">
														<i class="fa-solid fa-user"></i>
														Profile & Refer
													</a>
												</li>
												<li>
													<a href="fetchMyId"><i class="fa-solid fa-money-bill-transfer" style="color: black"></i> Transfer Balance to Another Game Wallet</a>
												</li>
												<li>
													<a href="#"><i class="fa-solid fa-wallet" style="color: black"> : </i>${balance}</a>
												</li>
												<li>
													<a href="fetchWalletTransaction">
														<i class="fa-solid fa-book"></i>
														Transaction History
													</a>
												</li>
												<li>
													<a href="fetchPendingRequest">
													<i class="fa-regular fa-hourglass-half"></i>
													Pending Request
													</a>
												</li>
												
												<li>
													<a href="logout">
														<i class="fa-solid fa-arrow-right-from-bracket"></i>
														Logout
													</a>
												</li>
											</c:when>
											<c:otherwise>
												<li>
													<a href="login">Login</a>
												</li>
												<li>	
													<a href="registration">Register</a>
												</li>
											</c:otherwise>
										</c:choose>
									</div>
								</ul>
							</div>

							<div class="personaldetails">
								<ul>
									<c:choose>
										<c:when test="${not empty userId}">
											<li>
												<a href="fetchProfile">
													<i class="fa-solid fa-user"></i>
													Profile & Refer
												</a>
											</li>
											<li>
												<i class="fa-solid fa-money-bill-transfer"></i>
												<a href="fetchMyId">Transfer Balance to Another Game Wallet</a>
											</li>
											<li>
													<i class="fa-solid fa-wallet"> : ${balance}</i> 
												
											</li>
											
											<li>
												<a href="logout">
													<i class="fa-solid fa-arrow-right-from-bracket"></i>
													Logout
												</a>
											</li>
											<div class="user-panel" id="deposit" style="background-color: green; font-weight: bold;">
												<a href="fetchUpiDetails" style="color: white;">
													<i class="fa-solid fa-file-arrow-down" ></i>
													Deposit
												</a>
											</div>
											<div class="user-panel" id="withdraw" style="background-color: red; font-weight: bold;">
												<a href="withdraw" style="color: white;">
													<i class="fa-solid fa-file-arrow-up"></i>
													Withdraw
												</a>
											</div>
										</c:when>
										<c:otherwise>
											<div class="user-panel" style="color: black;">
												<a href="login" style="color: black;">Login</a> / <a href="registration" style="color: black;">Register</a>
											</div>
											<div class="user-panel" id="deposit" style="background-color: green; font-weight: bold;">
												<a href="fetchUpiDetails" style="color: white;">
													<i class="fa-solid fa-file-arrow-down" ></i>
													Deposit
												</a>
											</div>
											<div class="user-panel" id="withdraw" style="background-color: red; font-weight: bold;">
												<a href="withdraw" style="color: white;">
													<i class="fa-solid fa-file-arrow-up"></i>
													Withdraw
												</a>
											</div>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</header>
	
	<!-- Header section end -->
	
	<div class="pageData">
        <!-- <img src="https://media.istockphoto.com/id/1334436084/photo/top-down-view-of-colorful-illuminated-gaming-accessories-laying-on-table.jpg?s=612x612&w=0&k=20&c=E9xnbAZoBS5LlUX0q-zxT_3m6gEZpyB2k51_U4LLMNs="
            alt="game image"> -->
        <div class="text-overlay1">
        	<c:if test="${not empty errorMessage}">
				<div class="errorContainerSeconnd">${errorMessage}</div>
				<%
					session.removeAttribute("errorMessage");
					session.invalidate();
				%>
			</c:if>
			<c:if test="${not empty message}">
				<div class="errorContainerSeconnd">${message}</div>
				<%
					session.removeAttribute("message");
					session.invalidate();
				%>
			</c:if>
            <div class="register-box">
                <p class="register-head">Transfer Wallet Balance to </p>
                <form id="chooseWebsiteForm">
                	<select name="teamName" class="form-select" aria-label="Default select example" required>
                		<option value="" disabled selected>Select Game Website</option>
                		<c:forEach items="${myIds}" var="myId">
							<option value="${myId.id}" style="background-image: url('${myId.logo}');">
								 ${myId.websiteName}
							</option>
                		</c:forEach>
                		
                	</select>
                    <button id="nextButton" type="submit">Book the team</button>
                </form>
            </div>
        </div>
        
        </div>
    </div>
    <div class="amountDiv">
    	<form id="amountForm">
			<div class="form-group">
			    <label for="amount">Enter the amount</label>
			    <input type="number" class="form-control" id="amount" placeholder="Enter the amount" required>
			</div>
			<button class="btn btn-success">Continue to pay</button>
    	</form>
    </div>
    <div class="loadingImage">
    	<img src="img/loading/loading in circle.gif" alt="loading"/>
    </div>
				<footer class="footer-section">
				<div class="container">
					<ul class="footer-menu">
						<li><a href="/">Home</a></li>
						<li><a href="review">Games</a></li>
						<li><a href="contact">Contact</a></li>
						<li>
							<a href="termsandcondition">
								<i class="fa-solid fa-file-invoice"></i>
								Terms and condition
							</a>
						</li>
						<li>
							<a href="notification">
								<i class="fa-solid fa-bell"></i>
								Notification
							</a>
						</li>
					</ul>
					<div class="payment-symbol">
						<div>
							<img src="img/payment/1.png" alt="" />
						</div>
						<div>
							<img src="img/payment/2.png" alt="" />
						</div>
						<div>
							<img src="img/payment/3.png" alt="" />
						</div>
						<div>
							<img src="img/payment/4.png" alt="" />
						</div>
						<div>
							<img src="img/payment/5.png" alt="" />
						</div>
						<div>
							<img src="img/payment/6.png" alt="" />
						</div>
						<div>
							<img src="img/payment/7.png" alt="" />
						</div>
						<div>
							<img src="img/payment/8.png" alt="" />
						</div>
						<div>
							<img src="img/payment/9.png" alt="" />
						</div>
					</div>
					
					<div class="social-links">
						<a href="https://www.facebook.com/profile.php?id=61557228365799" target="_blank" style="color: white;"><i class="fa fa-facebook"></i></a>
						<a href="https://www.instagram.com/khelo365dayofficial/" target="_blank" style="color: white;"><i class="fa fa-instagram"></i></a>
					</div>
				</div>
			</footer>
	

	<div id="warning">This game may be habit-forming or financially risky Play responsibly. T&C apply. 18+ only.</div>
	<!--====== Javascripts & Jquery ======-->
	<script src="js/walletBalanceTransferToAnotherWebsiteRequest.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<!-- <script src="js/registration.js"></script> -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>
</html>