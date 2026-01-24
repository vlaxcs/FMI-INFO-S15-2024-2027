function printtt(board){
    message = '';
    for(i=0; i<3; i++){
        message += '| ';
        for(j=0; j<3; j++){
            index = i*3 + j + 1;
            if(board[index-1] == '?')
                message += String(index);
            else message += board[index-1];
            message += ' | ';
        }
        message += '\n';
    }
    return message;
}

function valid(board, play){
    if(!Number.isInteger(play) || play < 0 || play > 8)
        return false;
    if(board[play] !== '?')
        return false;
    return true;
}

function computer_move(board){
    var choice = Math.floor(Math.random() * 9);
    while(board[choice] != "?"){
        choice = Math.floor(Math.random() * 9);
    }
    return choice;
}

function win(board){
    const winConditions = [
        [0,1,2],[3,4,5],[6,7,8], // rows
        [0,3,6],[1,4,7],[2,5,8], // cols
        [0,4,8],[2,4,6]          // diags
    ];
    for(const [a,b,c] of winConditions){
        if(board[a] !== '?' && board[a] === board[b] && board[b] === board[c])
            return board[a];
    }
    return false;
}

const name = prompt('Hai să jucăm X și 0. Cum te cheamă?');
var playerChoice = "";
while (!(playerChoice === "X" || playerChoice === "0"))
    var playerChoice = prompt(`Bună, ${name}! Cu ce vrei să joci? X sau 0? X începe primul.`).toUpperCase();
var board = ["?", "?", "?", "?", "?", "?", "?", "?", "?"];
var turn = 1;
while(turn < 10){
    const message = printtt(board);
    let currSymbol = (turn % 2 !== 0) ? 'X' : '0';
    if(currSymbol == playerChoice){
        var currPlay = Number(prompt(`${message}\nUnde vrei sa pui urmatorul semn? ${currSymbol}`))-1;
        while(!valid(board, currPlay)){
            alert("Mutare invalida!");
            currPlay = Number(prompt(`${message}\nUnde vrei sa pui urmatorul semn? ${currSymbol}`))-1;
        }
    }
    else{
        var currPlay = computer_move(board);
    }
    board[currPlay] = currSymbol;
    turn++;
    if(win(board)){
        prompt(`Castigator: ${win(board)}`);
        break;
    }
}
if(turn == 10)
    prompt("Remiza!");