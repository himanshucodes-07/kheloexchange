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

let showLoading = () =>{
	let loadingDiv = document.getElementById("loadingDiv");
	
	loadingDiv.style.display="flex";
}

let closeLoading = () =>{
	document.getElementById("loadingDiv").style.display="none";
}

let showData = (requestId) =>{
	let actionDiv = document.getElementById("actionDiv");
	let div = document.createElement("div");
	
	div.setAttribute("class", "cart");
	
	let form = document.createElement("form");
	
	form.setAttribute("action", "approveWalletBalanceTransferRequest");
	form.setAttribute("method", "POST");
	
	let id = document.createElement("input");
	
	id.setAttribute("type", "hidden");
	id.setAttribute("name", "id");
	id.setAttribute("value", requestId);
	
	let br = document.createElement("br");
	
	let submit = document.createElement("button");
	
	submit.setAttribute("class", "btn btn-success");
	submit.innerText="Approve";
	
	let hr = document.createElement("hr");
	let separatorContainer = document.createElement("div");
	
	hr.setAttribute("class", "separator");
	separatorContainer.setAttribute("class", "separator-container");
	
	let or = document.createElement("span");
	
	or.setAttribute("class", "or");
	
	or.innerText="OR";
	
	let rejectionForm = document.createElement("form");
	
	rejectionForm.setAttribute("action", "rejectWalletBalanceTransferRequest");
	rejectionForm.setAttribute("method", "POST");
	
	let rejectionId = document.createElement("input");
	
	rejectionId.setAttribute("type", "hidden");
	rejectionId.setAttribute("name", "id");
	rejectionId.setAttribute("value", requestId);
	
	let input= document.createElement("input");
	
	input.setAttribute("type", "text");
	input.setAttribute("placeholder", "Rejection reason.");
	input.setAttribute("name", "remark");
	input.setAttribute("required", "");
	
	let rejectionSubmit = document.createElement("button");
	
	rejectionSubmit.setAttribute("class", "btn btn-success");
	rejectionSubmit.innerText="Reject";	
	
	separatorContainer.append(hr, or);
	rejectionForm.append(rejectionId, input, rejectionSubmit);
	form.append(id, br, submit);
	div.append(form, separatorContainer, rejectionForm);
	actionDiv.append(div);
	actionDiv.style.display="flex";
}

let showActionDiv = (id) =>{
	showLoading();
	
	showData(id);
	
	closeLoading();
}

