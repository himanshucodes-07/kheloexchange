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
			
			<link rel="stylesheet" href="css/style.css"/>
			<link rel="stylesheet" href="css/animate.css"/>
			<link rel="stylesheet" href="css/login.css"/>
			<!-- livechat style -->
			<link rel="stylesheet" href="css/livechat.css"/>
			<link rel="stylesheet" href="css/responsive.css"/>
			<!-- Font Awesome kit -->
			<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
			<link rel="stylesheet" href="css/deposit.css">
			<link rel="stylesheet" href="css/error-container.css">
			<!-- livechat style -->
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
			<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
			<link rel="stylesheet" href="css/responsive.css"/>
			<!-- Font Awesome kit -->
			<script src="https://kit.fontawesome.com/e99a9eb445.js" crossorigin="anonymous"></script>
			<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
			<style>
    .custom-file-input::-webkit-file-upload-button {
      visibility: hidden;
    }
    .custom-file-input::before {
      content: 'Select File';
      display: inline-block;
      background: linear-gradient(top, #f9f9f9, #e3e3e3);
      border: 1px solid #999;
      border-radius: 3px;
      padding: 5px 8px;
      outline: none;
      white-space: nowrap;
      cursor: pointer;
      text-shadow: 1px 1px #fff;
      font-weight: 700;
      font-size: 10pt;
    }
    .custom-file-input:hover::before {
      border-color: black;
    }
    .custom-file-input:active::before {
      background: -webkit-linear-gradient(top, #e3e3e3, #f9f9f9);
    }
    .highlight-upload {
      background-color: #007bff;
      border-color: #007bff;
    }
  </style>
		</head>

		<body>
			<c:if test="${empty adminId}">
				<% session.setAttribute("errorMessage", "Unauthorized!" ); response.sendRedirect("admin-login"); %>
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
			<c:if test="${not empty errorMessage}">
				<div class="errorContainer">${errorMessage}</div>
				<% session.removeAttribute("errorMessage"); %>
			</c:if>
			<c:if test="${not empty message}">
				<div class="errorContainer">${message}</div>
				<% session.removeAttribute("message"); %>
			</c:if>
		<form action="gameImageUpload" method="POST" enctype="multipart/form-data">
			<div class="container mt-5">
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <h2 class="text-center mb-4">Upload Your Files</h2>
      <div class="input-group">
        <div class="custom-file">
          <input type="file" class="custom-file-input" id="file" aria-describedby="fileAddon" name="file" accept="image/*">
          <label class="custom-file-label" for="file">Choose file</label>
        </div>
        
      </div>
      <small class="text-muted" id="fileName"></small>
      <div class="form-group">
      	<label for="textInput">Input Text (max 65,535 characters):</label>
          <input type="text" class="form-control-file" id="subject" name="subject" placeholder="Enter the Image heading" required>
        	<span id="errorSubject" class="error"></span>
        </div>
        <div class="form-group">
        	<label for="textInput">Input Text (max 65,535 characters):</label>
          <input type="text" class="form-control-file" id="message" name="message" placeholder="Enter the description" required>
        	<span id="errorMessage" class="error"></span>
        </div>
        <div class="input-group-append">
          <button class="btn btn-primary" type="submit" id="uploadButton" disabled>Upload</button>
        </div>
    </div>
  </div>
</div>
</form>
						<h1 class="text-center text-white p2 bg-dark bg-gradient text-uppercase">New Game Images</h1>
			<c:choose>
				<c:when test="${not empty gameImages}">
						<div class="table-responsive">
						<table id="example" class="table table-striped border-dark table-hover text-center">
							<thead class="table-dark table-active text-uppercase text-whites">
								<tr>
									<th>Image</th>
									<th>Heading</th>
									<th>Image Description</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${gameImages}" var="image">
										<tr>
											<td><div style="display: flex; flex-direction:column;">
													<a href="${image.imageLink}" target="_blank" style="margin-bottom:7px">
														<img class="image-container" src="${image.imageLink}"
															alt="${image.subject }">
													</a>
													<a href="${image.imageLink}" target="_blank">
														<button class="btn btn-success">Click to view</button>
													</a>
												</div></td>
											<td>${image.subject}</td>
											<td>${image.message}</td>
											<td>
												<form action="deleteImage" method="post">
													<input type="hidden" name="id" value="${image.id }" />
													<button class="btn btn-success">Delete</button>
												</form>
											</td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						</c:when>
						<c:otherwise>
							<img class="blankpage" src="https://img.freepik.com/free-vector/no-data-concept-illustration_114360-2506.jpg?w=740&t=st=1705560867~exp=1705561467~hmac=5dc60af5ded74c5bdc9f93cf0948faa6be2f2aea0070995a7a3867d8ffc515ed"
								alt="Not found or something went wrong" class="empty" />
							<p style="text-align: center;">New Game Image(s) not found!.</p>
						</c:otherwise>
					</c:choose>
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
			<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
			<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
			
			<script>
			  document.getElementById('file').addEventListener('change', function() {
			    const fileInput = this;
			    const uploadButton = document.getElementById('uploadButton');
			    const fileNameLabel = document.getElementById('fileName');
			    if (fileInput.value) {
			      uploadButton.removeAttribute('disabled');
			      uploadButton.classList.add('highlight-upload');
			      fileNameLabel.textContent = fileInput.files[0].name;
			    } else {
			      uploadButton.setAttribute('disabled', true);
			      uploadButton.classList.remove('highlight-upload');
			      fileNameLabel.textContent = '';
			    }
			  });
			  
			</script>
			
			<!--====== Javascripts & Jquery ======-->
			<script src="../js/jquery-3.2.1.min.js"></script>
			<script src="../js/bootstrap.min.js"></script>
			<script src="../js/owl.carousel.min.js"></script>
			<script src="../js/jquery.marquee.min.js"></script>
			<script src="../js/main.js"></script>
			<script src="../js/gameImageTextlengthValidate.js"></script>
			<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
			<script type="text/javascript">	
				(function () { var script = document.createElement("script"); script.type = "text/javascript"; script.async = true; script.src = "//telegram.im/widget-button/index.php?id=@digitaladdworld"; document.getElementsByTagName("head")[0].appendChild(script); })();
			</script>
		</body>

		</html>