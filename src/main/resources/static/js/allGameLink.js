async function fetchGameLink() {
    try {
        const response = await fetch("/gameLink");
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
    }
}

let showGameLinkData = (data) =>{
	let gameLink = document.getElementsByClassName("game-container")[0];
	
	gameLink.innerHTML = "";
	
	data.forEach(element =>{
		let row = document.createElement("tr");
		let img = document.createElement("img");
		let a1 = document.createElement("a");
		let a2 = document.createElement("a");
		let p = document.createElement("p");
		let gameName= document.createElement("td");
		let gameWebsite = document.createElement("td");
		
		a2.setAttribute("href", element.website);
		a2.setAttribute("target", "_blank");
		
		img.setAttribute("src", element.logo);
		img.setAttribute("alt", element.websiteName);
				
		a1.setAttribute("href", element.website);
		a1.innerHTML=`<i class="fa-solid fa-arrow-up-right-from-square"></i>`;
		a1.setAttribute("target", "_blank");
		
		p.innerText = element.websiteName;
		
		a2.append(img, p);
		
		gameName.setAttribute("class", "game-name");
		
		gameWebsite.setAttribute("class", "text-center")
		
		gameName.append(a2);
		gameWebsite.append(a1);
		row.append(gameName, gameWebsite);
		gameLink.append(row);
	});
}

async function fetchData() {
    try {
        let data = await fetchGameLink();
        console.log(data);
        if(data != null && data != undefined && data.length !=0){
			showGameLinkData(data);
		}
    } catch (error) {
        console.error('There was a problem with fetching data:', error);
    }
}

fetchData();