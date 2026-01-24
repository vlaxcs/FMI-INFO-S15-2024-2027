window.onload = function(){
    var filmList = document.getElementById('filme');
    var text = '<?xml version="1.0" encoding="UTF-8"?><root><movie><title lang="en">Good Will Hunting</title><genre>Drama</genre><director>Gus Van Sant</director><release>1997</release><screenwriter>Ben Affleck</screenwriter><producer>Lawrence Bender</producer><actors><actor>Matt Damon</actor><actor>Robin Williams</actor></actors><score>8.3</score></movie><movie><title lang="en">Requiem for a Dream</title><genre>Psychological</genre><director>Darren Aronofsky</director><release>2000</release><screenwriter>Hubert Selby Jr.</screenwriter><producer>Eric Watson</producer><actors><actor>Jared Leto</actor><actor>Ellen Burstyn</actor></actors><score>8.3</score></movie></root>'
    var parser = new DOMParser();
    var xmlDoc = parser.parseFromString(text,"text/xml");
    var movies = xmlDoc.getElementsByTagName("movie");
    filmList.innerHTML = ''; // Clear existing list
    for (let movie of movies) {
        var li = document.createElement('li');
        var details = '';
        for (let child of movie.children) {
            if (child.tagName === 'actors') {
                var actors = [];
                for (let actor of child.children) {
                    actors.push(actor.textContent);
                }
                details += `<strong>Actors:</strong> ${actors.join(', ')}<br>`;
            } else {
                details += `<strong>${child.tagName}:</strong> ${child.textContent}<br>`;
            }
        }
        li.innerHTML = details;
        filmList.appendChild(li);
    }
}