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
	
	<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
</head>
<body>
	
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
	<div class="container mt-5">
        <h1 class="text-center mb-4">Terms and Conditions</h1>
        <div class="card">
            <div class="card-body">
                <h2> What is gambling and how is it different from Skill Games under Indian laws?</h2>
				<p> Gambling or gaming has been defined by the Supreme Court in 1996 as betting and wagering on games of chance only. The Supreme Court in this judgment specifically excludes games of skill, irrespective of whether they are played for money or not, from the definition of gambling. The exact quote from the 1996 judgment is as follows:</p>
				<p> "The expression 'gaming' in the two Acts has to be interpreted in the light of the law laid-down by this Court in the two1957 cases, wherein it has been authoritatively held that a competition which substantially depends on skill is not gambling. Gaming is the act or practice of gambling on a game of chance. It is staking on chance where chance is the controlling factor. 'Gaming' in the two Acts would, therefore, mean wagering or betting on games of chance. It would not include games of skill like horse racing"</p>
				<p> Further, the Public Gambling Act, which is the central law on gambling and most subsequent state laws on the subject substantially state that "nothing in this Act shall apply to games of mere skill wherever played". This is also mentioned in the 1996 Supreme Court judgment with regards Tamil Nadu and Madras laws. "In any case...Section 11 of the Gaming Act specifically saves the games of mere skill from the penal provisions of the two Acts."</p>
				<h2> What is a game of skill under Indian laws?</h2>
				<p> Supreme Court of India in 1996 defined a game of mere skill as follows:</p>
				<p> The competitions where success depends on substantial degree of skill are not "gambling" and Despite there being an element of chance if a game is preponderantly a game of skill it would nevertheless be a game of "mere skill". </p>
				<p> We, therefore, hold that the expression "mere skill" would mean substantial degree or preponderance of skill. </p>
				<p> Is rummy a game of skill? The 1968 Supreme Court ruling that declared rummy to be a game of skill: </p>
				<p> "Rummy, on the other hand, requires certain amount of skill because the fall of the cards has to be memorised and the building up of Rummy requires considerable skill in holding and discarding cards. We cannot, therefore, say that the game of Rummy is a game of entire chance. It is mainly and preponderantly a game of skill. The chance in Rummy is of the same character as the chance in a deal at a game of bridge." </p>
				<p> Further, the Supreme Court in 1996 also stated "A game of skill, on the other hand - although the element of chance necessarily cannot be entirely eliminated --is one in which success depends principally upon the superior knowledge, training, attention, experience and adroitness of the player. Golf, chess and even Rummy are considered to be games of skill. The Courts have reasoned that there are few games, if any, which consist purely of chance or skill, and as such a game of chance is one in which the element of chance predominates over the element of skill, and a game of skill is one in which the element of skill predominates over the element of chance. It is the dominant element --"skill" or "chance" -- which determines the character of the game." </p>
				<h2> Do games of skill enjoy any other protection legally? </h2>
				<p> Yes, in 1957 the Supreme Court stated that prize competitions which involve substantial skill are business activities that are protected under Article 19(1)(g) of the Constitution of India. </p>
				<h2> Is it legal to play rummy for cash? </h2>
				<p> The various Supreme Court rulings and the Gaming Acts of India imply the following: </p>
				<p> Gaming or gambling means betting and wagering on games of chance. Playing games of skill for cash does not constitute gambling. Games of skill are exempt from the penal provisions of most gambling acts. Rummy is a game of skill. </p>
				<p> So yes, it is perfectly legal to play rummy for cash on Rummy as long as you are not playing from the states of Assam, Odisha, Telangana, Andhra Pradesh, Tamil Nadu, Nagaland and Sikkim. As we get more clarity on the laws in these states, we might consider offering our services to residents of these States as well.</p>
            </div>
        </div>
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
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<!-- <script src="js/registration.js"></script> -->
	<script src="js/bootstrap.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.marquee.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </body>
</html>