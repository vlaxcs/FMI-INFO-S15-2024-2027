window.onload = function(){
    // populate gallery from localStorage (only keys that start with 'photo')
    const gallery = document.getElementById('gallery');
    if (gallery) {
        Object.keys(localStorage)
            .filter(key => key.indexOf('photo') === 0)
            .forEach(key => {
                const html = localStorage.getItem(key);
                if (html)
                    gallery.insertAdjacentHTML('beforeend', html);
            });
    }

    function moveVisor(event){
        pressedKey = event.keyCode;
        if ([37, 38, 39, 40].indexOf(pressedKey) == -1)
            return;
        if(pressedKey == 37)
            direction = 'left';
        if(pressedKey == 38)
            direction = 'up';
        if(pressedKey == 39)
            direction = 'right';
        if(pressedKey == 40)
            direction = 'down';


        const photo = document.querySelector('img');
        const visor = document.getElementById('vizor');
        photoHeight = parseInt(window.getComputedStyle(photo).height) - parseInt(window.getComputedStyle(visor).height);
        photoWidth = parseInt(window.getComputedStyle(photo).width) - parseInt(window.getComputedStyle(visor).width);
        switch(direction){
            case 'left':
                var currMargin = window.getComputedStyle(photo).marginLeft;
                currMargin = parseInt(currMargin);
                if(currMargin < 0)
                    photo.style.marginLeft = `${currMargin+5}px`;
                break;
            case 'up':
                var currMargin = window.getComputedStyle(photo).marginTop;
                currMargin = parseInt(currMargin);
                if(currMargin < 0)
                    photo.style.marginTop = `${currMargin+5}px`;
                break;
            case 'right':
                var currMargin = window.getComputedStyle(photo).marginLeft;
                currMargin = parseInt(currMargin);
                if(currMargin > -photoWidth)
                    photo.style.marginLeft = `${currMargin-5}px`;
                break;
            case 'down':
                var currMargin = window.getComputedStyle(photo).marginTop;
                currMargin = parseInt(currMargin);
                if(currMargin > -photoHeight)
                    photo.style.marginTop = `${currMargin-5}px`;
                break;
        }
    }
    this.addEventListener("keydown", moveVisor);
    this.addEventListener("keydown", zoomIn);

    function zoomIn(event){
        const pressedKey = event.keyCode;
        var zoomMode;
        if(pressedKey != 187 && pressedKey != 189)
            return
        if(pressedKey == 189)
            zoomMode = 'out';
        else zoomMode = 'in';
        const photo = document.querySelector('img');
        photo.style.transformOrigin = "0 0";
        currZoom = window.getComputedStyle(photo).transform;
        var currentScale = new DOMMatrix(currZoom).a; //scale factor
        switch(zoomMode){
            case 'out':
                if(currentScale > 0.1)
                    photo.style.transform = `matrix(${currentScale-0.05}, 0, 0, ${currentScale-0.05}, 0, 0)`;
                break;
            case 'in':
                if(currentScale < 3)
                    photo.style.transform = `matrix(${currentScale+0.05}, 0, 0, ${currentScale+0.05}, 0, 0)`;
                break;
        }
    }

    function takePhoto(event){
        const pressedKey = event.keyCode;
        if(pressedKey != 83)
            return;
        const visor = document.getElementById('vizor');
        // clone the vizor (deep) and prepare it for appending/saving
        const container = visor.cloneNode(true);
        // remove id to avoid duplicates when inserting multiple copies
        container.id = '';
        visor.classList.remove('flashing');
        setTimeout(() => {
            visor.classList.add('flashing');
        }, 10);
        setTimeout(() => {
            visor.classList.remove('flashing');
        }, 1010);
        // append clone to gallery in the document
        if (gallery)
            gallery.appendChild(container);

        // save the clone's HTML to localStorage as a string
        try {
            const currKey = `photo${Object.keys(localStorage).filter(k=>k.indexOf('photo')===0).length}`;
            localStorage.setItem(currKey, container.outerHTML);
        } catch (e) {
            console.warn('Could not save photo to localStorage:', e);
        }

        console.log('saved', Object.keys(localStorage).filter(k=>k.indexOf('photo')===0));
        return container;
    }
    this.addEventListener('keydown', takePhoto)
}
