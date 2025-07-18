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
      <link rel="stylesheet" href="css/bootstrap.min.css" />
      <link rel="stylesheet" href="css/font-awesome.min.css" />
      <link rel="stylesheet" href="css/owl.carousel.css" />
      <link rel="stylesheet" href="css/style.css" />
      <link rel="stylesheet" href="css/animate.css" />
      <link rel="stylesheet" href="css/login.css" />
      <link rel="stylesheet" href="css/error-container.css" />
      <link rel="stylesheet" href="css/bankingService.css" />
      <link rel="stylesheet" href="css/responsive.css"/>
<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
    </head>

    <body>
      <!-- Page Preloder -->
      <!-- <div id="preloder">
        <div class="loader"></div>
      </div> -->

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
      
      <c:if test="${not empty errorMessage}">
        <div class="errorContainer">${errorMessage}</div>
        <% session.removeAttribute("errorMessage"); %>
      </c:if>
      <c:if test="${not empty message}">
        <div class="errorContainer">${message}</div>
        <% session.removeAttribute("message"); %>
      </c:if>
      <!-- Hero section -->
      <section class="hero-section">
        <div class="hero-slider owl-carousel">
          <div class="hs-item set-bg" data-setbg="img/slider-1.jpg">
            <c:if test="${not empty errorMessage}">
              <div class="errorContainer">${errorMessage}</div>
              <% session.removeAttribute("errorMessage"); %>
            </c:if>
            <div class="box">
              <h2>Money Withdraw</h2>
              <c:choose>
              	<c:when test="${not empty userId }">
	              <form action="withdrawRequest" method="post">
	                <div class="row">
	                  <div class="col-md-6">
	                    <div class="form-group row" style="margin-bottom: 5px;">
	                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Bank Name</label>
	                      <div class="col-sm-12">
	                        <input type="text" class="form-control" id="bank" name="bank" required />
	                      </div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <div class="form-group row" style="margin-bottom: 5px;">
	                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Account Number</label>
	                      <div class="col-sm-12">
	                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" required />
	                      </div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <div class="form-group row" style="margin-bottom: 5px;">
	                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">IFSC Code</label>
	                      <div class="col-sm-12">
	                        <input type="text" class="form-control" id="ifsc" name="ifsc" required />
	                      </div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <div class="form-group row" style="margin-bottom: 5px;">
	                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Account Holder Name</label>
	                      <div class="col-sm-12">
	                        <input type="text" class="form-control" name="accountHolderName" id="accountHolderName"
	                          required />
	                      </div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <div class="form-group row" style="margin-bottom: 5px;">
	                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Amount</label>
	                      <div class="col-sm-12">
	                        <input type="number" class="form-control" name="amount" id="amount" required />
	                      </div>
	                    </div>
	                  </div>
	
	                </div>
	                <button type="submit" class="btn btn-info" style="float: right;">Submit <i
	                    class="mdi mdi-arrow-right-bold"></i></button>
	              </form>
	              </c:when>
	              <c:otherwise>
	              	<form action="withdrawRequestWithEmail" method="post">
		                <div class="row">
		                <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Register Email Id</label>
		                      <div class="col-sm-12">
		                        <input type="email" class="form-control" id="email" name="email" required />
		                      </div>
		                    </div>
		                  </div>
		                  <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Bank Name</label>
		                      <div class="col-sm-12">
		                        <input type="text" class="form-control" id="bank" name="bank" required />
		                      </div>
		                    </div>
		                  </div>
		
		                  <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Account Number</label>
		                      <div class="col-sm-12">
		                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" required />
		                      </div>
		                    </div>
		                  </div>
		
		                  <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">IFSC Code</label>
		                      <div class="col-sm-12">
		                        <input type="text" class="form-control" id="ifsc" name="ifsc" required />
		                      </div>
		                    </div>
		                  </div>
		
		                  <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Account Holder Name</label>
		                      <div class="col-sm-12">
		                        <input type="text" class="form-control" name="accountHolderName" id="accountHolderName"
		                          required />
		                      </div>
		                    </div>
		                  </div>
		
		                  <div class="col-md-6">
		                    <div class="form-group row" style="margin-bottom: 5px;">
		                      <label class="col-sm-12 col-form-label" style="padding-bottom: 0px;">Amount</label>
		                      <div class="col-sm-12">
		                        <input type="number" class="form-control" name="amount" id="amount" required />
		                      </div>
		                    </div>
		                  </div>
		
		                </div>
		                <button type="submit" class="btn btn-info" style="float: right;">Submit <i
		                    class="mdi mdi-arrow-right-bold"></i></button>
		              </form>	
	              </c:otherwise>
				</c:choose>
            </div>
          </div>
        </div>

        </div>
      </section>
      <!-- Hero section end -->

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
	
      <!-- Footer section end -->

		<div id="warning">This game may be habit-forming or financially risky Play responsibly. T&C apply. 18+ only.</div>
      <!--====== Javascripts & Jquery ======-->
      <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script src="js/jquery-3.2.1.min.js"></script>
      <script src="js/bootstrap.min.js"></script>
      <script src="js/owl.carousel.min.js"></script>
      <script src="js/jquery.marquee.min.js"></script>
      <script src="js/main.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>

    </html>