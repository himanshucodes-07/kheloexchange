document.addEventListener("DOMContentLoaded", function(){
	let maxLimit = document.getElementById("quantity").value || 0;
	document.getElementById('quantity').addEventListener('input', function() {
	  if (this.value > maxLimit) {
	    this.value = maxLimit;
	  }
	});	
});

let closeRedeemDiv = () => {
	document.getElementById("redeemPointDiv").style.display="none";
}

let showRedeemDiv = () =>{
	document.getElementById("redeemPointDiv").style.display="flex";
}