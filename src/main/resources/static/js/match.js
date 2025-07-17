async function fetchMatch() {
    try {
        const response = await fetch("/match/live");
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('There was a problem with the fetch operation:', error);
    }
}

let closeMatch = () => {
	document.getElementById("match").style.display= "none";
}

let showMatch = () => {
	document.getElementById("match").style.display="block";
}

let showData = (data) =>{
	let match = document.getElementsByClassName("matchData")[0];
	
	match.innerHTML = "";
	
	data.forEach(element =>{
		let table = document.createElement("table");
		let caption = document.createElement("caption");
		
		caption.setAttribute("class", "table-caption");
		
		table.setAttribute("class", "table table-responsive table-striped border-dark table-hover text-center");
		
		caption.innerText=element.teamHeading;
		
		let thead = document.createElement("thead");
		let headRow = document.createElement("tr");
		let th1 = document.createElement("th");
		
		thead.setAttribute("class", "table-dark text-uppercase text-whites");
		
		th1.innerText="Batting Team";
		
		let th2 = document.createElement("th");
		
		th2.innerText = "Batting Team Score";
		
		let th3 = document.createElement("th");
		
		th3.innerText = "Bowling Team";
		
		let th4 = document.createElement("th");
		
		th4.innerText = "Bowling Team Score";
		
		let th5 = document.createElement("th");
		
		th5.innerText = "Live Text";
		
		let th6 = document.createElement("th");
		
		th6.innerText = "Venue";
		
		let th7 = document.createElement("td");
		
		th7.innerText = "Match Current Status";
		
		let th8 = document.createElement("td");
		
		th8.innerText = "Winner";
		
		let tBody = document.createElement("tbody");
		let bodyRow = document.createElement("tr");
		let td1 = document.createElement("td");
		
		td1.innerText = element.battingTeam;
		
		let td2 = document.createElement("td");
		
		td2.innerText = element.battingTeamScore;
		
		let td3 = document.createElement("td");
		
		td3.innerText = element.bowlingTeam;
		
		let td4 = document.createElement("td");
		
		td4.innerText = element.bowlingTeamScore;
		
		let td5 = document.createElement("td");
		
		td5.innerText = element.liveText;
		
		let td6 = document.createElement("td");
		
		td6.innerText = element.matchNumberVenue;
		
		let td7 = document.createElement("td");
		
		td7.innerText = element.status;
		
		let td8 = document.createElement("td");
		
		td8.innerText = element.textComplete;
		
		bodyRow.append(td1, td2, td3, td4, td5, td6, td7, td8);
		headRow.append(th1, th2, th3, th4, th5, th6, th7, th8);
		tBody.append(bodyRow);
		thead.append(headRow);
		table.append(caption, thead, tBody);
		match.append(table);
	});
	showMatch();
}

async function fetchData() {
    try {
        let data = await fetchMatch();
        console.log(data);
        if(data != null && data != undefined && data.length != 0)
			showData(data);
    } catch (error) {
        console.error('There was a problem with fetching data:', error);
    }
}

fetchData();
