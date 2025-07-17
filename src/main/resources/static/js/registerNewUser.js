let showLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "flex";
}

let closeLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
  loading.style.display = "none";
}

document.getElementsByTagName("form")[0].addEventListener("submit", event =>{
	event.preventDefault();
	showLoading();
	
	let firstName = document.getElementById("firstName").value;
	let lastName = document.getElementById("lastName").value;
	let email = document.getElementById("email").value;
	let password = document.getElementById("password").value;
	let mobile = document.getElementById("mobile").value;
	let obj = {
		firstName,
		lastName,
		email,
		password,
		mobile
	}
	
	$.ajax({
		url: "/newUserRegister",
		type: "post",
		data: JSON.stringify(obj),
		dataType: "json",
		contentType: "application/json",
		success: function(response){
			console.log(response);
			closeLoading();
			
			Swal.fire({
			  title: "User Successfully registered",
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