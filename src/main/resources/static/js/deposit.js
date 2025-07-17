let content1 = document.getElementById('content1');
let content2 = document.getElementById('content2');
let content3 = document.getElementById('content3');

let button1 = document.querySelector("#button1>button");
let button2 = document.querySelector("#button2>button");
let button3 = document.querySelector("#button3>button");

let showLoading = () =>{
	document.getElementsByClassName("loadingImage")[0].style.display="flex";
}

let closeLoading = () =>{
	document.getElementsByClassName("loadingImage")[0].style.display="none";
}

let displayBankAccountDetails = (data) =>{
	console.log(data);
	
	let accountDataContainer = document.getElementsByClassName("accountDataContainer")[0];
	
	accountDataContainer.innerHTML = "";
	
	data.forEach((element)=>{
		let row = document.createElement("tr");
		let actionTag = document.createElement("td");
		let radio = document.createElement("input");
	
		radio.setAttribute("type", "radio");
		radio.setAttribute("name", "bankAccount");
		radio.addEventListener("click", ()=>{
			showPaymentFileInput(element.bankAccountId, "BANK");
		});
	
		actionTag.append(radio);
		
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
		
		row.append(actionTag, bankAccount, ifsc, accountHolderName, bankName, maximumLimitPerTransaction);
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

let displayQrCode = (data) =>{
	let qrDataContainer = document.getElementsByClassName("qrDataContainer")[0];
	
	qrDataContainer.innerHTML = "";
	
	data.forEach(element =>{
		let row = document.createElement("tr");
		let selectTag = document.createElement("td");
		let radio = document.createElement("input");
	
		radio.setAttribute("type", "radio");
		radio.setAttribute("name", "qrCode");
		radio.addEventListener("click", ()=>{
			showPaymentFileInput(element.qrCodeId, "QR");
		});
		
		selectTag.append(radio);
		
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
		
		row.append(selectTag, displayName, qrCode, maximumLimit);
		qrDataContainer.append(row);
	});
}

let fetchQrCode = async () =>{
	showLoading();
	
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
}

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

let openImageInput = () =>{
	document.getElementById("fileInput").click();
}

let closeFileInput = () =>{
	document.getElementById("uploadModel").style.display="none";
}

let closeForm = () =>{
	document.getElementById("formModel").style.display="none";
}

document.getElementById('fileInput').addEventListener('input', function () {
	closeFileInput();
	showLoading();
	
    var imageFile = this.files[0];
    if (!imageFile) return;

    var img = document.getElementById('uploadedImage');
    
    img.style.display = 'block';
    img.src = URL.createObjectURL(imageFile);
    img.style.maxWidth= "97%";
    
    document.getElementById("formModel").style.display="flex";
    
    closeLoading();
});

function showFileInput() {
	showLoading();
	
	var selectedUpiId = document.querySelector('input[name="upi"]:checked').value;
	
	document.getElementById('selectedUpiId').value = selectedUpiId;
	
	document.getElementById('paymentType').value = "UPI";
	
	document.getElementById("uploadModel").style.display="flex";
	
	closeLoading();
}

function showPaymentFileInput(id, paymentType) {
	showLoading();
	
	document.getElementById('selectedUpiId').value = id;
	document.getElementById("paymentType").value = paymentType;
	
	document.getElementById("uploadModel").style.display="flex";
	
	closeLoading();
}

let backAndShowFileInput = ()=>{
	closeForm();
	document.getElementById('fileInput').value="";
	showFileInput();
}

let copyTheUpi= (index) =>{
	let upiID = document.getElementsByClassName('upiID')[index].textContent;
	let copyCompleteSymbol = document.getElementsByClassName("copyComplete")[index];
	let copyButton = document.getElementsByClassName("copyButton")[index];
	
	navigator.clipboard.writeText(upiID)
	    .then(() => {
	    // Success message (optional)
	    	console.log("UPI ID copied to clipboard!");
	    })
	    .catch(err => {
	    // Error handling (optional)
	    	console.error("Failed to copy UPI ID:", err);
	 });
	 
	 copyButton.style.display="none";
	 copyCompleteSymbol.style.display= "inline";
	 
	 setTimeout(()=>{
	 	copyCompleteSymbol.style.display= "none";
		 copyButton.style.display="inline";
	 }, 1000)
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