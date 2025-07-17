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

let closeGameLink = () => {
	document.getElementById("gameLink").style.display= "none";
}

let showGameLink = () => {
	document.getElementById("gameLink").style.display="block";
}

let showGameLinkData = (data) =>{
	let gameLink = document.getElementsByClassName("news-container")[0];
	
	gameLink.innerHTML = "";
	
	let ul = document.createElement("ul");
	data.forEach(element =>{
		let li = document.createElement("li");
		let img = document.createElement("img");
		let a = document.createElement("a");
		let h4 = document.createElement("h4");
		let hr = document.createElement("hr");
		
		img.setAttribute("src", element.logo);
		img.setAttribute("alt", element.websiteName);
		
		a.setAttribute("href", "/game-link");
		a.setAttribute("target", "_blank");
		
		h4.innerText = element.websiteName;
		
		a.append(img, h4);
		li.append(a, hr);
		ul.append(li);
	});
	gameLink.append(ul);
	
	showGameLink();
}

function addStyle(){
	const newsContainer = document.querySelector('.news-container ul');

	let totalHeight = 0;
	for (const item of newsContainer.children) {
	  totalHeight += item.offsetHeight;
	}
	
	// Dynamically adjust animation duration based on total height (seconds)
	const animationDuration = totalHeight / 20; // Adjust divisor for desired speed
	
	// Set initial position above the container (negative value)
	newsContainer.style.top = `-${totalHeight}px`; // Hide initially
	
	// Create and inject animation keyframe (CSS approach)
	const styleElement = document.createElement('style');
	styleElement.textContent = `
	@keyframes scroll-down {
	  from { top: 0px; }
	  to { top:  -${totalHeight}px; }
	}`;
	document.head.appendChild(styleElement);
	
	// Apply animation with adjusted duration
	newsContainer.style.animation = `scroll-down ${animationDuration}s linear infinite`;
	
	// Pause animation on hover
	newsContainer.parentElement.addEventListener('mouseover', () => {
	  newsContainer.style.animationPlayState = 'paused';
	});
	
	newsContainer.parentElement.addEventListener('mouseout', () => {
	  newsContainer.style.animationPlayState = 'running';
	});
}

async function fetchData() {
    try {
        let data = await fetchGameLink();
        console.log(data);
        if(data != null && data != undefined && data.length !=0){
			showGameLinkData(data);
			addStyle();
		}
    } catch (error) {
        console.error('There was a problem with fetching data:', error);
    }
}

fetchData();
