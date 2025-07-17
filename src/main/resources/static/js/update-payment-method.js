let content1 = document.getElementById('content1');
let content2 = document.getElementById('content2');
let content3 = document.getElementById('content3');

let button1 = document.querySelector("#button1>button");
let button2 = document.querySelector("#button2>button");
let button3 = document.querySelector("#button3>button");

let showLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "flex";
}

let closeLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "none";
}

function showContent1() {
	content1.style.display = 'block';
	content2.style.display = 'none';
	content3.style.display = 'none';
	
	button1.style.backgroundColor = 'white';
	button1.style.color = 'black';
	button2.style.backgroundColor = 'black';
	button2.style.color= 'white';
	button3.style.backgroundColor = 'black';
	button3.style.color= 'white';
}

let deleteQrCode = (qrCodeId) =>{
	$.ajax({
		url: "/deleteQrCode",
		dataType: "json",
		type: "post",
		data: JSON.stringify({qrCodeId}),
		dataType: "json",
		contentType: "application/json",
		success: function(response){
			closeLoading();
			Swal.fire({
			  title: "Successfully deleted QR Code",
			  text: "",
			  icon: "success",
			  didClose: function () {
				location.reload();
			  }
			});
		},
		error: function(error){
			Swal.fire({
			  title: "Something went wrong",
			  text: "",
			  icon: "error",
			});
			closeLoading();
		}
	})
}

let displayQrCode = (data) =>{
	let qrDataContainer = document.getElementsByClassName("qrDataContainer")[0];
	
	qrDataContainer.innerHTML = "";
	
	data.forEach(element =>{
		let row = document.createElement("tr");
		let deleteButton = document.createElement("button");
		let deletecolumn = document.createElement("td");
		
		deleteButton.innerText = "Delete";
		deleteButton.setAttribute("class", "btn btn-success");
		deleteButton.addEventListener("click", ()=>{
			showLoading();
			deleteQrCode(element.qrCodeId);
		});
		
		deletecolumn.append(deleteButton);
		
		let displayName = document.createElement("td");
		
		displayName.innerText = element.displayName;
		
		let qrCode = document.createElement("td");
		let qrCodeImage = document.createElement("img");
		let a = document.createElement("a");
		let qrCodeButton = document.createElement("button");
		
		qrCodeImage.setAttribute("src", element.path)
		//image class for bootstrap
		
		a.setAttribute("href", element.path);
		a.setAttribute("target", "_blank");
		
		qrCodeButton.innerText = "View Qr Code";
		qrCodeButton.setAttribute("class", "btn btn-success");
		
		a.append(qrCodeButton);
		qrCode.append(qrCodeImage, a);
		
		let maximumLimit = document.createElement("td");
		
		maximumLimit.innerText = element.maximumLimitOneTransaction;
		
		let timestamp = document.createElement("td");
		
		timestamp.innerText = element.uploadedDateAndTime;
		
		row.append(deletecolumn, displayName, qrCode, maximumLimit, timestamp);
		qrDataContainer.append(row);
	});
}

let fetchQrCode = async () =>{
	showLoading();
	/*return new Promise((resolve, reject)=>{*/
	$.ajax({
		url: "/qrCodeForPaymentFetch",
		type: "post",
		contentType: "application/json",
		dataType: "json",
		success: function(response){
			console.log(response);
			displayQrCode(response);
			closeLoading();
		},
		error: function(error){
			console.log(error);
			closeLoading();
			
		}
	});
	/*});*/
}

function showContent2() {
	content1.style.display = 'none';
	content3.style.display = 'none';
	content2.style.display = 'flex';
	content2.style.flexDirection = 'column';
	content2.style.alignItems = 'center';
	
	button1.style.backgroundColor = 'black';
	button3.style.backgroundColor = 'black';
	button2.style.backgroundColor = 'white';
	button2.style.color= 'black';
	button1.style.color = 'white';
	button3.style.color = 'white';
	
	fetchQrCode();
}

let deleteBankAccountDetail = (bankAccountId) =>{
	$.ajax({
		url: "/deleteBankAccountDetail",
		data: JSON.stringify({bankAccountId}),
		dataType: "json",
		type: "post",
		contentType: "application/json",
		success: function(response){
			closeLoading();
			
			Swal.fire({
			  title: "Account Detail Successfully Deleted",
			  text: "",
			  icon: "success",
			  didClose: function () {
				fetchBankAccountDetail();
			  }
			});
		},
		error: function(error){
			console.log(error);
			closeLoading();
			
			Swal.fire({
			  title: "Something went wrong!!",
			  text: "",
			  icon: "error",
			});
		}
	});
}

let displayBankAccountDetails = (data) =>{
	console.log(data);
	
	let accountDataContainer = document.getElementsByClassName("accountDataContainer")[0];
	
	accountDataContainer.innerHTML = "";
	
	data.forEach((element)=>{
		let row = document.createElement("tr");
		let actionTag = document.createElement("td");
		let deleteButton = document.createElement("button");
		
		deleteButton.setAttribute("class", "btn btn-success");
		deleteButton.innerText = "Delete";
		deleteButton.addEventListener("click", ()=>{
			showLoading();
			
			deleteBankAccountDetail(element.bankAccountId);
		});
		
		actionTag.append(deleteButton);
		
		let bankAccount = document.createElement("td");
		
		bankAccount.innerText = element.accountNumber;
		
		let ifsc = document.createElement("td");
		
		ifsc.innerText = element.ifsc;
		
		let accountHolderName = document.createElement("td");
		
		accountHolderName.innerText = element.accountHolderName;
		
		let bankName = document.createElement("td");
		
		bankName.innerText = element.bankName;
		
		let maximumLimitPerTransaction = document.createElement("td");
		
		maximumLimitPerTransaction.innerText = element.maximumLimitPerTransaction;
		
		let dateTime = document.createElement("td");
		
		dateTime.innerText = element.addedDateAndTime;
		
		row.append(actionTag, bankAccount, ifsc, accountHolderName, bankName, maximumLimitPerTransaction, dateTime);
		accountDataContainer.append(row);
	})
	closeLoading();
}

let fetchBankAccountDetail = () =>{
	showLoading();
	
	$.ajax({
		url: "/fetchBankAccountDetail",
		dataType: "json",
		type: "post",
		contentType: "application/json",
		success: function(response){
			displayBankAccountDetails(response);
		},
		error: function(error){
			console.log(error);
			Swal.fire({
			  title: "Error to Display Account Detail(s)",
			  text: "",
			  icon: "error",
			});
			closeLoading();
		}
	});
}

document.getElementById("bankAccountForm").addEventListener("submit", (event) =>{
	event.preventDefault();
	showLoading();
	
	let accountNumber = document.getElementById("accountNumber").value;
	let ifsc = document.getElementById("ifsc").value;
	let accountHolderName = document.getElementById("accountHolderName").value;
	let bankName = document.getElementById("bankName").value;
	let maximumLimitPerTransaction = +(document.getElementById("accountMaximumLimit").value);
	
	$.ajax({
		url: "/saveAccountDetail",
		data: JSON.stringify({accountNumber, ifsc, accountHolderName, bankName, maximumLimitPerTransaction}),
		dataType: "json",
		type: "post",
		contentType: "application/json",
		success: function(response){
			console.log(response);
			closeLoading();
			Swal.fire({
			  title: "Bank Account Detail Successfully added",
			  text: "",
			  icon: "success",
			  didClose: function () {
				fetchBankAccountDetail();
			  }
			});
		},
		error: function(error){
			console.log(error);
			Swal.fire({
			  title: "Something went wrong",
			  text: "",
			  icon: "error",
			});
			closeLoading();
		}
	});
})

let showContent3 =() =>{
	content1.style.display = 'none';
	content2.style.display = 'none';
	content3.style.display = 'flex';
	content3.style.flexDirection = 'column';
	content3.style.alignItems = 'center';
	
	button1.style.backgroundColor = 'black';
	button2.style.backgroundColor = 'black';
	button3.style.backgroundColor = 'white';
	button3.style.color= 'black';
	button1.style.color = 'white';
	button2.style.color = 'white';
	
	fetchBankAccountDetail();
}