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
    <link rel="stylesheet" href="css/owl.carousel.css"/>
    <link rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" href="css/animate.css"/>
    <link rel="stylesheet" href="css/login.css"/>
    <link rel="stylesheet" href="css/profile.css">
	<link rel="stylesheet" href="css/responsive.css"/>
	<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

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
<c:if test="${empty requestScope.name || empty requestScope.email}">
	<%
		response.sendRedirect("fetchProfile");
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


<!-- Hero section -->
<section class="hero-section">
    <div class="hero-slider owl-carousel">
        <div class="hs-item set-bg" data-setbg="img/slider-1.jpg">
            <div class="box">
                <h2>Profile</h2>
                <div class="profile-info">
                    <p>Full Name :</p><p> ${requestScope.name }</p>
                    <p>Email :</p> <p> ${requestScope.email}</p>
                    <p>Referral Code :</p> <p> <input type="text" id="referralCode" class="form-control mb-2" style="width: auto; display: flex; flex-wrap: wrap;" value="${requestScope.referralCode}" readonly></p>
                    <p>Referral Point :</p> <p> <input type="text" id="referralPoint" class="form-control mb-2" style="width: auto; display: flex; flex-wrap: wrap;" value="${requestScope.referralPoint}" readonly> </p>
                </div>
                <div>
                	 <button id="openDialogBtn" class="btn btn-success" onclick="openShareModal()">Refer & Earn</button>
                	<button class="btn btn-success" onclick="showRedeemDiv()">Redeem Point</button>
                </div>
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
		</ul>
		<a href="termsandcondition">
			<i class="fa-solid fa-file-invoice"></i>
			Terms and condition
		</a>
		<a href="notification">
			<i class="fa-solid fa-bell"></i>
			Notification
		</a>
		<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
		</p>
	</div>
</footer>
<!-- Footer section end -->

<div id="redeemPointDiv">
	<div class="modalRedeem">
		<button type="button" class="close" onclick="closeRedeemDiv()" data-dismiss="redeemPointDiv" aria-label="Close">
	      <span aria-hidden="true">&times;</span>
	    </button>
	    <br>
		<form action="redeemThePoints" method="POST" >
			<input type="number" name="referralPoint" placeholder="Enter the referral point" id="quantity" min="0" value="${requestScope.referralPoint }" />
			<button class="btn btn-success">Convert into cash</button>
		</form>
	</div>
</div>

<!-- Modal dialog -->
<div class="modal fade" id="shareModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="shareModalLabel">Share Referral Link</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Share options and copy button -->
        <button id="whatsappShareBtn" class="btn btn-info mr-2">Share on WhatsApp</button>
        <button id="emailShareBtn" class="btn btn-danger mr-2">Share via Email</button>
        <button id="copyLinkBtn" class="btn btn-primary">Copy Link</button>
      </div>
    </div>
  </div>
</div>
<div id="warning">This game may be habit-forming or financially risky Play responsibly. T&C apply. 18+ only.</div>
<script>
let domainName = () =>{
	return window.location.origin;
}

function openShareModal() {
	  $('#shareModal').modal('show');
	}

let referralCode = ()=>{
	return document.getElementById("referralCode").value;
}
	document.addEventListener('DOMContentLoaded', function() {
	  // Function to share referral link on WhatsApp
	  document.getElementById('whatsappShareBtn').addEventListener('click', function() {
	    const referralLink = domainName() +'/registration?referral=' + referralCode();
	    const encodedLink = encodeURIComponent(referralLink);
	    const whatsappUrl = `https://api.whatsapp.com/send?text=`+encodedLink;
	    window.open(whatsappUrl, '_blank');
	  });

	  // Function to share referral link via email
	  document.getElementById('emailShareBtn').addEventListener('click', function() {
	    const referralLink = domainName() +'/registration?referral=' + referralCode();;
	    const subject = 'Check out this referral link!';
	    const body = `Hey! Check out this referral link: `+referralLink;
	    var encodedSubject = encodeURIComponent(subject);
	    var encodedBody = encodeURIComponent(body);
	    const emailUrl = `mailto:?subject=` + encodedSubject + `body=` + encodedBody;
	    window.open(emailUrl, '_blank');
	  });

	  document.getElementById('copyLinkBtn').addEventListener('click', function() {
		    const referralLink = domainName() + '/registration?referral=' + referralCode();
		    const textField = document.createElement('textarea');
		    textField.innerText = referralLink;
		    document.body.appendChild(textField);
		    textField.select();
		    document.execCommand('copy');
		    document.body.removeChild(textField);
		    alert('Link copied to clipboard!');
		});

	  // Function to copy referral link to clipboard

	});
	</script>

	<!-- jQuery and Bootstrap JS (make sure to include these libraries) -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!--====== Javascripts & Jquery ======-->
<script src="js/profile.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.marquee.min.js"></script>
<script src="js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>