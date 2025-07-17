<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
			<!-- <link rel="stylesheet" href="css/bootstrap.min.css" />
			 --><link rel="stylesheet" href="css/font-awesome.min.css" />
			<link rel="stylesheet" href="css/owl.carousel.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/animate.css" /> 
			<link rel="stylesheet" href="css/deposit.css">
			<link rel="stylesheet" href="css/error-container.css" />
			<link rel="stylesheet" href="css/empty.css">
			<link rel="stylesheet" href="css/responsive.css"/>
			<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
			<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
			<link rel="stylesheet" href="css/responsive.css"/>
			<style>
				.header-section {
					overflow: visible;
				}
			</style>
		</head>

		<body class="body">
			<c:if test="${empty fetchUpiDetails}">
			    <c:if test="${not pageContext.response.isCommitted()}">
			        <%
			            response.sendRedirect("fetchUpiDetails");
			        %>
			    </c:if>
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
			<div class="button-container">
				<div id="button1">
					<button class="btn btn-primary" onclick="showContent1()">Upi Id(s)</button>
				</div>
				<div id="button2">
					<button class="btn btn-primary" onclick="showContent2()">Qr Code(s)</button>
				</div>
				<div id="button3">
					<button class="btn btn-primary" onclick="showContent3()">Bank Account(s)</button>
				</div>
			</div>
	<div id="uploadModel">
						<div class="uploadDiv">
							<button id="uploadButton" class="btn btn-success ml-6"
	                            onclick="openImageInput()">
	                            <i class="fa-solid fa-camera">
	                            </i>
	                            | Upload Payment Screenshot
	                        </button>
						</div>
					</div>
					<div id="formModel">
						<div class="formDiv">
							<div class="col-12">
							
			                  <button class="btn btn-success ml-6" onclick="backAndShowFileInput()"><i class="fa-solid fa-arrow-left"></i> back</button>
						  </div>
						  	<c:choose>
						  		<c:when test="${not empty userId}">
									<form id="uploadForm" action="/upload" method="post" enctype="multipart/form-data" class="row g-3">
									  <div class="col-md-12">
									   <input type="file" id="fileInput" name="file" accept="image/*" style="display:none;" required>
									  </div>
									  <div class="col-md-12">
									    <div class="row justify-content-center">
									         <div class="col-auto">
									             <img id="uploadedImage" src="" alt="Uploaded Image">
									         </div>
									  	</div>
									  </div>
									  <div class="col-12">
									  	<label for="utr" class="form-label">UTR Number : </label>
										<input type="text" class="form-control" name="utr" id="utr" placeholder="Enter the utr number" required/>
									  </div>
									  <input type="hidden" id="paymentType" name="paymentType" value="" required>
									  <div class="col-12">
									    <input type="hidden" id="selectedUpiId" name="selectedUpiId" value="" required>
									  </div>
									 
									  <div class="col-12">
						                   <button id="uploadButton" class="btn btn-success ml-6" type="submit">Submit</button>
									  </div>
									</form>
								</c:when>
								<c:otherwise>
									<form id="uploadForm" action="/uploadWithEmail" method="post" enctype="multipart/form-data" class="row g-3">
									  <div class="col-md-12">
										<input type="file" id="fileInput" name="file" accept="image/*" style="display:none;" required>
									  </div>
									  
									  <div class="col-md-12">
									    <div class="row justify-content-center">
									         <div class="col-auto">
									             <img id="uploadedImage" src="" alt="Uploaded Image">
									         </div>
									  	</div>
									  </div>
									  
									  <div class="col-12">
									  	<label for="utr" class="form-label">UTR Number : </label>
										<input type="text" class="form-control" name="utr" id="utr" placeholder="Enter The UTR Number" required/>
									  </div>
									  
									  <div class="col-12">
									  	<label for="utr" class="form-label">Register Email Id : </label>
										<input type="email" class="form-control" name="email" id="email" placeholder="Enter Your Register Email Id" required/>
									  </div>
									  
									  <div class="col-12">
									    <input type="hidden" id="selectedUpiId" name="selectedUpiId" value="" required>
									  </div>
									  <input type="hidden" id="paymentType" name="paymentType" value="" required>
									  <div class="col-12">
						                   <button id="uploadButton" class="btn btn-success ml-6" type="submit">Submit</button>
									  </div>
									</form>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
			<!-- Header section end -->
			<c:if test="${not empty errorMessage}">
				<div class="errorContainer">${errorMessage}</div>
				<% session.removeAttribute("errorMessage"); %>
			</c:if>
			<c:if test="${not empty message}">
				<div class="errorContainer">${message}</div>
				<% session.removeAttribute("message"); %>
			</c:if>
			<!-- Hero section -->
			<% int index = 0; %>
			<div id="content1" class="content">
			<c:choose>
				<c:when test="${not empty upiDetails}">
					<div class="container">
						<table id="example" class="table table-responsive table-striped border-dark table-hover text-center ">
							<thead class="table-dark text-uppercase text-whites">
							<tr>
								<th>Select</th>
								<th>Display Name</th>
								<th>Upi Detail</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${upiDetails}" var="upi">
								<tr>
									<td>
										<input type="radio" class="upi" name="upi" value="${upi.id}"
											onclick="showFileInput()">
									</td>
									<td>
										<img class="upi_image" src="${upi.img}" alt="Upi Logo" />
										${upi.displayName}
									</td>
									<td>
										<span class="upiID" onclick="copyTheUpi('<%= index %>')">
											${upi.upiId}
										</span>
										<i class="fa-regular fa-copy copyButton" onclick="copyTheUpi('<%= index %>')"></i>
										<i class="fa-solid fa-circle-check copyComplete" style="display: none;"></i>
										<% index++; %>
									</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>

				</c:when>
				<c:otherwise>
				<img class="blankpage" src="https://img.freepik.com/free-vector/no-data-concept-illustration_114360-2506.jpg?w=740&t=st=1705560867~exp=1705561467~hmac=5dc60af5ded74c5bdc9f93cf0948faa6be2f2aea0070995a7a3867d8ffc515ed"
					alt="Not found or something went wrong" class="emptyBox" />
			</c:otherwise>
			</c:choose>
		</div>
		<div id="content2" class="content">
				<div class="container">
					<table id="example" class="table table-striped table-responsive border-dark table-hover text-center">
						<thead class="table-dark table-active text-uppercase text-whites">
							<tr>
								<th>Select</th>
								<th>Display Name</th>
								<th>Qr Code</th>
								<th>Maximum Limit Per Transaction</th>
							</tr>
						</thead>
						<tbody class="qrDataContainer">
						
						</tbody>
					</table>
				</div>
		</div>
		<div id="content3" class="content">
			<div class="container">
				<table id="example" class="table table-striped table-responsive border-dark table-hover text-center">
					<thead class="table-dark table-active text-uppercase text-whites">
						<tr>
							<th>Select</th>
							<th>Account Number</th>
							<th>IFSC</th>
							<th>Account Holder Name</th>
							<th>Bank Name</th>
							<th>Maximum Limit Per Transaction</th>
						</tr>
					</thead>
					<tbody class="accountDataContainer">
					
					</tbody>
				</table>
			</div>
		</div>
			<!-- Hero section end -->
			<div class="loadingImage">
              	<img src="img/loading/loading in circle.gif" alt="loading"/>
            </div>

			<!-- Footer section -->
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
			<!-- Footer section end -->
			<script src="js/deposit.js"></script>
			<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
			<script src="js/jquery-3.2.1.min.js"></script>
			<script src="js/bootstrap.min.js"></script>
			<script src="js/owl.carousel.min.js"></script>
			<script src="js/jquery.marquee.min.js"></script>
			<script src="js/main.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

		</body>

		</html>