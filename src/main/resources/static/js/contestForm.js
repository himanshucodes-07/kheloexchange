let showLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
 
  loading.style.display = "flex";
}

let closeLoading = () => {
  let loading = document.getElementsByClassName("loadingImage")[0];
 
  loading.style.display = "none";
}

document.getElementsByTagName("form")[0].addEventListener("submit", (event)=>{
	event.preventDefault();
	
	showLoading();
	
	let teamName= document.getElementsByTagName("select")[0].value;
	let obj = {
		teamName: teamName
	};
	
	$.ajax({
      url: "/registerInContest",
      data: JSON.stringify(obj),
      contentType: "application/json",
      type: "post",
      dataType: "json",
      success: function (response) {
        console.log(response);
        closeLoading();
        Swal.fire({
          title: "Congrat, Your response successfully registered. Your request id is "+ response.id,
          text: "",
          icon: "success",
          didClose: function () {
            // Reload or refresh the page after the SweetAlert is closed
            window.location.href="/";
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