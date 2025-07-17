let className = ["new", "strategy", "racing"];
let positions = ["First Winner", "Second Winner", "Third Winner", "Fourth Winner", "Fifth Winner"];

let displayData = (data) => {
    let latestNews = document.getElementsByClassName("news-ticker-contant")[0];

    // Clear the existing content
    latestNews.innerHTML = "";

    let classNameIndex = 0;
    let positionsIndex = 0;

    // Create a document fragment to batch updates
    let fragment = document.createDocumentFragment();

    data.forEach(function(element) {
        let div = document.createElement("div");
        div.setAttribute("class", "nt-item");

        let span = document.createElement("span");
        span.setAttribute("class", className[classNameIndex++]);
        span.innerText = positions[positionsIndex++];

        div.append(span);
        div.append(" " + element.firstName + " " + element.lastName);
        fragment.appendChild(div);

        if (classNameIndex == className.length) {
            classNameIndex = 0;
        }
        if (positionsIndex == positions.length) {
            positionsIndex = 0;
        }
    });

    // Append the fragment to the DOM
    latestNews.appendChild(fragment);
}

let getTopMaximumDepositUser = () => {
    $.ajax({
        url: "/findMaximumDepositUsers",
        type: "post",
        dataType: "json",
        contentType: "application/json",
        success: function(response) {
            console.log(response);

            if (response != null && response != undefined)
                displayData(response);
        },
        error: function(error) {
            console.log(error);
        }
    });
}

getTopMaximumDepositUser();
