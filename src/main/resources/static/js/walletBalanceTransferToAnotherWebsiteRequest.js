let showLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
 
  loading.style.display = "flex";
}

let closeLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
 
  loading.style.display = "none";
}

let showAmountForm = () =>{
	document.getElementsByClassName("amountDiv")[0].style.display="flex";
}

document.getElementById("amountForm").addEventListener("submit", function(event){
	event.preventDefault();
	
	showLoading();
	
	let id= document.getElementsByTagName("select")[0].value;
	let amount = document.getElementById("amount").value;
	
	let obj = {
		id: id,
		amount: amount
	};
	
	console.log(obj);
	
	$.ajax({
      url: "/takeRequestForWalletMoneyDeposit",
      data: JSON.stringify(obj),
      contentType: "application/json",
      type: "post",
      dataType: "json",
      success: function (response) {
        console.log(response);
        closeLoading();
        Swal.fire({
          title: "Congrat, Your response successfully registered. Your request id is "+ response.id +". Amount will be update soon.",
          text: "",
          icon: "success",
          didClose: function () {
            // Reload or refresh the page after the SweetAlert is closed
            location.reload();
          }
        });
      },
      error: function (error) {
        console.log(error);
        closeLoading();
        Swal.fire({
          title: "Oops! "+error.responseJSON.message,
          text: "",
          icon: "error",
          didClose: function () {
            // Reload or refresh the page after the SweetAlert is closed
            location.reload();
          }
        });
      }
    })
})

document.getElementById("chooseWebsiteForm").addEventListener("submit", (event)=>{
	event.preventDefault();
	showAmountForm();
})