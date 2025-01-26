function genDots(color, size){
    dot = document.createElement("div");
    dot.style.backgroundColor = color;
    dot.style.position = "absolute";

    const randomX = Math.random() * window.innerWidth;
    const randomY = Math.random() * window.innerHeight;
    dot.style.left = `${randomX}px`;
    dot.style.top = `${randomY}px`;

    dot.style.padding = `${size}px`;
    
    dot.style.borderRadius = "50%";

    dot.addEventListener("click", (event) => {
        genDots(color, size);
    });

    document.body.appendChild(dot);
}

window.onload = async function(){
    
    let clickCount = 0;
    localStorage.setItem("clickCount", clickCount);
    
    let counter = document.createElement("p");
    counter.innerHTML = clickCount
    document.body.appendChild(counter);

    let sizerContainer = document.createElement("div");
    sizerContainer.style.zIndex = "1001";
    sizerContainer.width = "200";
    sizerContainer.height = "100";
    sizerContainer.id = "sizerContainer";
    document.body.appendChild(sizerContainer);

    toAppend = document.getElementById("sizerContainer");

    let sizer = document.createElement("input");
    sizer.type = "range";
    sizer.id = "dotsize";
    sizer.name = "dotsize";
    sizer.min = "20";
    sizer.max = "150";
    sizer.style.zIndex = "1001";
    toAppend.appendChild(sizer);

    document.addEventListener('keydown', function (event) {
        range = document.getElementById("dotsize");
        size = range.value;

        switch (event.key.toLowerCase()){ 
            case "r":
                genDots("red", size);
                break;
            case "g":
                genDots("green", size);
                break;
            case "b":
                genDots("blue", size);
                break;
            case "y":
                genDots("yellow", size);
                break;
        }
        clickCount = localStorage.getItem("clickCount");
        clickCount++;
        counter.innerHTML = clickCount
        localStorage.setItem("clickCount", clickCount);
    });
}