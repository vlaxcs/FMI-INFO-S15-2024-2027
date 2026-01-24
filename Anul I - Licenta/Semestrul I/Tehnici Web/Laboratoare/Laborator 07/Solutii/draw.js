function drawTable(nrows, ncols) {
/* 
   1. Generați un tabel cu 'nrows' rânduri și 'ncols' coloane 
   și adăugați-l în div-ul cu id-ul 'container'. 
*/
   const container = document.getElementById('container');
   var table = document.createElement('table');
   container.appendChild(table);
   for(var rowIndex = 0; rowIndex < nrows; rowIndex++){
      var row = document.createElement('tr');
      for(var columnIndex = 0; columnIndex < ncols; columnIndex++){
         var cell = document.createElement('td');
         cell.classList.add(`r${rowIndex}`, `c${columnIndex}`);
         row.appendChild(cell);
      }
      table.appendChild(row);
   }

}

function colorCol(column, color) {
/*
   2. Colorați coloana 'column' din tabla de desenat cu culoarea 'color'.
*/
   var targetCells = document.querySelectorAll(`.c${column}`);
   for (cell of targetCells){
      cell.style.backgroundColor = color;
   }
}

function colorRow(row, color) {
/*
   2. Colorați rândul 'row' din tabla de desenat cu culoarea 'color'.
*/
   var targetCells = document.querySelectorAll(`.r${row}`);
   for (cell of targetCells){
      cell.style.backgroundColor = color;
   }
}

function rainbow(target, nrows, ncols) {
   let colors = ["rgb(255, 0, 0)", "rgb(255, 154, 0)", "rgb(240, 240, 0)", "rgb(79, 220, 74)", "rgb(63, 218, 216)", "rgb(47, 201, 226)", "rgb(28, 127, 238)", "rgb(95, 21, 242)", "rgb(186, 12, 248)", "rgb(251, 7, 217)"];
/*
   3. Desenați un curcubeu pe verticală sau orizontală conform argumentului 'target' folosind culorile din 'colors' și funcțiile 'colorCol' și 'colorRow'.     
*/
   if(target === 'v'){
      for(colIndex = 0; colIndex < ncols; colIndex += 3){
         selectedColor = colors[colIndex/3];
         colorCol(colIndex, selectedColor);
         colorCol(colIndex+1, selectedColor);
         colorCol(colIndex+2, selectedColor);
      }
   }
   if(target === 'h'){
      for(rowIndex = 0; rowIndex < ncols; rowIndex += 3){
         selectedColor = colors[rowIndex/3];
         colorRow(rowIndex, selectedColor);
         colorRow(rowIndex+1, selectedColor);
         colorRow(rowIndex+2, selectedColor);
      }
   }
}

function getNthChild(element, n) {
/*
   4. Întoarceți al n-lea element copil al unui element dat ca argument.
*/
   const children = element.children;
   if(children[n])
      return children[n];
   return false;
};

function drawPixel(row, col, color) {	
/*
   5. Colorați celula de la linia 'row' și coloana 'col' cu culoarea `color'.
*/
   const targetCell = document.querySelector(`.r${row}.c${col}`);
   targetCell.style.backgroundColor = color;
}

function drawLine(r1, c1, r2, c2, color) {
/*
   6. Desenați o linie (orizontală sau verticală) de la celula aflată 
   pe linia 'r1', coloana 'c1' la celula de pe linia 'r2', coloana 'c2'
   folosind culoarea 'color'. 
   Hint: verificați mai întâi că punctele (r1, c1) și (r2, c2) definesc
   într-adevăr o linie paralelă cu una dintre axe.
*/
   if(!(r1 == r2 || c1 == c2))
      return;
   if(r1==r2){
      for(col = c1; col <= c2; col++)
         drawPixel(r1, col, color);
   }
   if(c1==c2){
      for(row = r1; row <= r2; row++)
         drawPixel(row, c1, color);
   }
}

function drawRect(r1, c1, r2, c2, color) {
/*
   7. Desenați, folosind culoarea 'color', un dreptunghi cu colțul din 
   stânga sus în celula de pe linia 'r1', coloana 'c1', și cu 
   colțul din dreapta jos în celula de pe linia 'r2', coloana 'c2'.
*/
   for(row = r1; row <= r2; row++)
      drawLine(row, c1, row, c2, color);
}

function drawPixelExt(row, col, color) {
/*
   8. Colorați celula de la linia 'row' și coloana 'col' cu culoarea 'color'.
   Dacă celula nu există, extindeți tabla de desenat în mod corespunzător.
*/
   const table = document.querySelector('table');
   var nrows = table.childElementCount;
   var ncols = getNthChild(table, 0).childElementCount;
   targetRow = getNthChild(table, row);
   while(row >= nrows){
      var newRow = document.createElement('tr');
      for(var columnIndex = 0; columnIndex < ncols; columnIndex++){
         var cell = document.createElement('td');
         cell.classList.add(`r${nrows+1}`, `c${columnIndex}`);
         newRow.appendChild(cell);
      }
      table.appendChild(newRow);
      nrows++;
   }
   if(col > ncols){
      allRows = document.querySelectorAll('tr');
      allRows.forEach((currentRow, currRowIndex) => {
         for(cellIndex = ncols; cellIndex <= col; cellIndex++){
            var cell = document.createElement('td');
            cell.classList.add(`r${currRowIndex}`, `c${cellIndex}`);
            currentRow.appendChild(cell);
         }
      });
      ncols = col;
   }
   targetCell = document.querySelector(`.r${row}.c${col}`);
   targetCell.style.backgroundColor = color; 
}

function colorMixer(colorA, colorB, amount){
   let cA = colorA * (1 - amount);
   let cB = colorB * (amount);
   return parseInt(cA + cB);
}

function drawPixelAmount(row, col, color, amount) {
   /* 
   9. Colorați celula la linia 'row' și coloana 'col' cu culoarea 'color'
   în funcție de ponderea 'amount' primită ca argument (valoare între 0 și 1). 
   Dacă 'amount' are valoarea:
   1, atunci celula va fi colorată cu 'color'
   0, atunci celula își va păstra culoarea inițială
   pentru orice altă valoare, culoarea inițială și cea dată de argumentul 
   'color' vor fi amestecate. De exemplu, dacă ponderea este 0.5, atunci 
   culoarea inițială și cea nouă vor fi amestecate în proporții egale (50%). 
   */
   const targetCell = document.querySelector(`.r${row}.c${col}`);
   var currColor = getComputedStyle(targetCell)['backgroundColor'];
   currColorArray = currColor.match(/\d+/g);
   colorArray = color.match(/\d+/g);
   for(var i=0; i<3; i++)
      currColorArray[i] = colorMixer(currColorArray[i], colorArray[i], amount);
   targetCell.style.backgroundColor = `rgb(${currColorArray[0]}, ${currColorArray[1]}, ${currColorArray[2]})`
   /*   
   Hint 1: folosiți funcția colorMixer de mai sus.

   Hint 2: pentru un argument 'color' de forma 'rgb(x,y,z)' puteți folosi
   let newColorArray = color.match(/\d+/g); 
   pentru a obține un Array cu trei elemente, corespunzătoare valorilor
   asociate celor trei culori - newColorArray = [x, y, z]
   
   Hint 3: pentru a afla culoarea de fundal a unui element puteți folosi
   metoda getComputedStyle(element). Accesând proprietatea backgroundColor 
   a obiectului întors, veți obține un string de forma 'rgb(x,y,z)'.
   */

}

function delRow(row) {
/*
   10. Ștergeți linia cu numărul 'row' din tabla de desenat.
*/
   table = document.querySelector('table');
   var nrows = table.childElementCount;
   table.deleteRow(row);
   for(rowIndex = row; rowIndex < nrows-1; rowIndex++){
      targetCells = document.querySelectorAll(`.r${rowIndex+1}`);
      targetCells.forEach(cell =>{
         col = cell.classList[1];
         cell.classList.remove(col); //stergem si readaugam clasa coloanei pt a pastra ordinea claselor
         cell.classList.add(`r${rowIndex}`);
         cell.classList.remove(`r${rowIndex+1}`);
         cell.classList.add(col);
      })
   }
}

function delCol(col) {
/*
   10. Ștergeți coloana cu numărul 'col' din tabla de desenat.
*/
}

function shiftRow(row, pos) {
/*
   11. Aplicați o permutare circulară la dreapta cu 'pos' poziții a
   elementelor de pe linia cu numărul 'row' din tabla de desenat. 
*/
}

function jumble() {
/*
   12. Folosiți funcția 'shiftRow' pentru a aplica o permutare circulară
   cu un număr aleator de poziții fiecărei linii din tabla de desenat.
*/
}

function transpose() {
/*
   13. Transformați tabla de desenat în transpusa ei.
*/
}

function flip(element) {
/*
   14. Inversați ordinea copiilor obiectului DOM 'element' primit ca argument.
*/
}

function mirror() {
/*
   15. Oglindiți pe orizontală tabla de desenat: luați jumătatea stângă a tablei, 
   aplicați-i o transformare flip și copiați-o în partea dreaptă a tablei.
*/
}

function smear(row, col, amount) {
/*
   16. Întindeți culoarea unei celule de pe linia 'row' și coloana 'col' în celulele
   învecinate la dreapta, conform ponderii date de 'amount' (valoare între 0 și 1).
   Cu colorarea fiecărei celule la dreapta, valoarea ponderii se înjumătățește. 
   Hint: folosiți funcția 'drawPixelAmount'.
*/
}


window.onload = function(){
   const rows = 15;
   const cols = 30;	
   drawTable(rows, cols);
   drawRect(2,3,9,8,'blue')
   drawPixelAmount(5, 15, 'rgb(200, 62, 50)', 0.95);
   delRow(7);
}


