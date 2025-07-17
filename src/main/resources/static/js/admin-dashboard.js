let count=1;
let userServiceCount = 1;

let showLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "flex";
}

let closeLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "none";
}

let showDialogueBox = () =>{
	document.getElementsByClassName("transactionDetail")[0].style.display="flex";
}

let closeDialogueBox = () =>{
	document.getElementsByClassName("transactionDetail")[0].style.display="none";
}

let showMyIdDialogue = () =>{
	document.getElementsByClassName("myIdDialogue")[0].style.display="flex";
}

let closeMyIdDialogue = () =>{
	document.getElementsByClassName("myIdDialogue")[0].style.display="none";
}

let showChangeMyIdPasswordDialogueBox = () =>{
	document.getElementsByClassName("myIdChangePasswordForm")[0].style.display="flex";
}

let closeChangeMyIdPasswordDialogueBox = () =>{
	document.getElementsByClassName("myIdChangePasswordForm")[0].style.display="none";
}

let showChangeUserPasswordDialogueBox = () =>{
	document.getElementsByClassName("userChangePasswordForm")[0].style.display="flex";
}

let closeChangeUserPasswordDialogueBox = () =>{
	document.getElementsByClassName("userChangePasswordForm")[0].style.display="none";
}

let showWalletHistory = (walletTransactions) =>{
	let transactionBody = document.getElementById("transactionDetail");
	
	transactionBody.innerText = "";
	
	if(walletTransactions.length!=0){
		walletTransactions.forEach(element =>{
			let row = document.createElement("tr");
			let transactionId = document.createElement("td");
			
			transactionId.innerText= element.id;
			
			let remark = document.createElement("td");
			
			remark.innerText = element.remark;
			
			let amount = document.createElement("td");
			
			amount.innerText = element.amount;
			
			let status = document.createElement("td");
			
			status.innerText = element.status;
			
			let totalAmount = document.createElement("td");
			
			totalAmount.innerText = element.totalAmount;
			
			let timestamp = document.createElement("td");
			
			timestamp.innerText = element.localDateTime;
			
			row.append(transactionId, remark, amount, status, totalAmount, timestamp);
			transactionBody.append(row);
		})
		showDialogueBox();
		closeLoading();
	}
	else{
		closeLoading();
		Swal.fire({
		  title: "No transaction found",
		  text: "",
		  icon: "error"
		});
	}
}

let showData = (data) =>{
	let tableBody = document.getElementById("userDetail");
	
	tableBody.innerHTML = "";
	
	data.forEach(element =>{
		let row = document.createElement("tr");
		let serial = document.createElement("td");
		
		serial.innerText = count++;
		
		let userId = document.createElement("td");
		
		userId.innerText = element.id;
		
		let name = document.createElement("td");
		
		name.innerText = element.firstName + " "+ element.lastName;
		
		let email = document.createElement("td");
		
		email.innerText= element.email;
		
		let mobile = document.createElement("td");
		
		mobile.innerText = element.mobile;
		
		let joiningDateAndTime = document.createElement("td");
		
		joiningDateAndTime.innerText = element.joiningDateTime;
		
		let deposit = document.createElement("td");
		
		deposit.innerText = element.wallet.totalDeposit;
		
		let withdraw = document.createElement("td");
		
		withdraw.innerText = element.wallet.totalWithdraw;
		
		let balance = document.createElement("td");
		
		balance.innerText = element.wallet.generalWallet + element.wallet.withdrawableWallet;
		
		let btn = document.createElement("button");
		
		btn.setAttribute("class", "btn btn-success");
		btn.innerText = "Wallet History";
		btn.addEventListener("click", ()=>{
			showLoading();
			showWalletHistory(element.wallet.walletTransactions);
		})
		
		let td = document.createElement("td");
		
		td.append(btn);
		
		row.append(serial, userId, name, email, mobile, joiningDateAndTime, deposit, withdraw, balance, td);
		tableBody.append(row);
	})
}

document.getElementById("gameForm").addEventListener("submit", event=>{
	event.preventDefault();
	showLoading();
	
	let id = document.getElementById("gameId").value;
	let gamePassword = document.getElementById("gamePassword").value;
	let obj = {
		id: id,
		password: gamePassword
	}
	
	$.ajax({
		url: "/changePasswordMyId",
		type: "post",
		data: JSON.stringify(obj),
		dataType: "json",
		contentType: "application/json",
		success: function(response){
			console.log(response);
			closeLoading();
			
			Swal.fire({
			  title: "Password successfully changed",
			  text: "",
			  icon: "success",
			  didClose: function () {
				// Reload or refresh the page after the SweetAlert is closed
				location.reload();
			  }
			});
		},
		error: function(error){
			console.log(error);
			closeLoading();
			
			Swal.fire({
			  title: "Something went wrong",
			  text: error.responseJSON.message,
			  icon: "error",
			  didClose: function () {
				// Reload or refresh the page after the SweetAlert is closed
				location.reload();
			  }
			});
		}
	})
})

let changeMyIdPassword = (id) =>{	
	let gameId = document.getElementById("gameId");
	
	gameId.value= id;
	showChangeMyIdPasswordDialogueBox();
}

let displayExternalId = (myId) =>{
	if(myId!= null && myId.length!=0){
		let myIdBody = document.getElementById("myIdBody");
		
		myIdBody.innerHTML = "";
		
		myId.forEach(element =>{
			let row = document.createElement("tr");
			let id = document.createElement("td");
			
			id.innerText = element.id;
			
			let websiteName = document.createElement("td");
			
			websiteName.innerText = element.websiteName;

			let username = document.createElement("td");
			
			username.innerText = element.username;
			
			let password = document.createElement("td");
			
			password.innerText = element.password;
			
			let status = document.createElement("td");
			
			status.innerText = element.status;
			
			let td = document.createElement("td");
			
			let website = document.createElement("a");
			
			website.setAttribute("href", element.website);
			website.innerHTML= `<i class="fa-solid fa-arrow-up-right-from-square"></i>`;
			td.append(website);
			
			let btn = document.createElement("td")
			let button = document.createElement("td");
			
			button.setAttribute("class", "btn btn-success");
			button.innerText = "Change Password";
			button.addEventListener("click", function(){
				changeMyIdPassword(element.id);
			})
			btn.append(button);
			
			row.append(id, websiteName, username, password, status, td, btn);
			myIdBody.append(row);
		});
		showMyIdDialogue();
	}
	else{
		Swal.fire({
		  title: "No Id(s) found",
		  text: "",
		  icon: "error"
		});
	}
}

let showExternalId = (id) =>{
	$.ajax({
		url: "/fetchGameLink",
		data: JSON.stringify({id: id}),
		type: "post",
		contentType: "application/json",
		dataType: "json",
		success: function(response){
			console.log(response);
			displayExternalId(response);
		},
		error: function(error){
			console.log(error);
		}
	})
}

document.getElementById("userForm").addEventListener("submit", event =>{
	event.preventDefault();
	showLoading();
	
	let id = document.getElementById("userId").value;
	let userPassword = document.getElementById("userPassword").value;
	let obj = {
		id: id,
		password: userPassword
	}
	
	$.ajax({
		url: "/changePasswordUser",
		type: "post",
		data: JSON.stringify(obj),
		dataType: "json",
		contentType: "application/json",
		success: function(response){
			console.log(response);
			closeLoading();
			
			Swal.fire({
			  title: "Password successfully changed",
			  text: "",
			  icon: "success",
			  didClose: function () {
				// Reload or refresh the page after the SweetAlert is closed
				location.reload();
			  }
			});
		},
		error: function(error){
			console.log(error);
			closeLoading();
			
			Swal.fire({
			  title: "Something went wrong",
			  text: error.responseJSON.message,
			  icon: "error",
			  didClose: function () {
				// Reload or refresh the page after the SweetAlert is closed
				location.reload();
			  }
			});
		}
	})
})

let changePassword = (id) =>{
	let userId = document.getElementById("userId");
	
	userId.value = id;
	showChangeUserPasswordDialogueBox();
}

let showUserService = (data) =>{
	let tableBody = document.getElementById("userService");
	
	tableBody.innerHTML = "";
	
	data.forEach(element =>{
		let row = document.createElement("tr");
		let serial = document.createElement("td");
		
		serial.innerText = userServiceCount++;
		
		let userId = document.createElement("td");
		
		userId.innerText = element.id;
				
		let email = document.createElement("td");
		
		email.innerText= element.email;
		
		let mobile = document.createElement("td");
		
		mobile.innerText = element.mobile;
		
		let td = document.createElement("td");
		
		let externalBtn = document.createElement("button");
		
		externalBtn.setAttribute("class", "btn btn-success");
		externalBtn.innerText = "External Id(s)";
		externalBtn.addEventListener("click", () =>{
			showLoading();
			showExternalId(element.id);
			closeLoading();
		})
		
		td.append(externalBtn);
		
		let td2 = document.createElement("td");
		let changeSignInPassword = document.createElement("button");
		
		changeSignInPassword.setAttribute("class", "btn btn-success");
		changeSignInPassword.innerText = "Change Sign-In Password";
		changeSignInPassword.addEventListener("click", function(){
			
			changePassword(element.id);
		})
		
		td2.append(changeSignInPassword);
		
		row.append(serial, userId, email, mobile, td, td2);
		tableBody.append(row);
	})
}

let fetchAllUser = () =>{
	$.ajax({
		url:"/allUser",
		dataType: "json",
		contentType: "application/json",
		type: "post",
		success: function(response){
			console.log(response);
			showData(response);
			showUserService(response);
			closeLoading();
		},
		error: function(error){
			closeLoading();
			console.log(error);
			Swal.fire({
			  title: "No data(s) found",
			  text: "",
			  icon: "error"
			});
		}
	})
}

fetchAllUser();