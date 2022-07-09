import {Controller} from "@hotwired/stimulus"
// import { FetchRequest } from '@rails/request.js'
import { get, post, put, patch, destroy } from '@rails/request.js'

export default class extends Controller {

    flip() {
        takeTurn(this.cardId, this.card)
    }

    get cardId() {
        return event.params.id
    }

    get card() {
        return this.cardId.replace(/\d/g, '');
    }
}

let turn = 'first', turns = 0, matchesMade = 0, matchesNeeded, one, two, oneId, twoId;

function takeTurn(id, card) {
    console.log('TakeTurn')
    turns++
    flip(id)
    displayTurns();
    startGameTimer();

    if (turn === 'first') {
        console.log('TakeTurnFIRST')
        one = card;
        oneId = id;
        toggleTurn()
        return
    }
    if (turn === 'second' && id === oneId) {
        return // Double clicked a card.
    }
    if (turn === 'second') {
        console.log('TakeTurnSECOND')
        two = card;
        twoId = id;
        checkCards()
        toggleTurn()
    }
    if (!matchesNeeded) {
        determineDifficulty()
    }
}

function displayTurns() {
    const messageDisplay = document.querySelector('#turns')
    messageDisplay.innerHTML = turns
}

var timerVar = setInterval(startGameTimer, 1000);
var totalSeconds = 0;

function startGameTimer() {
    ++totalSeconds;
    var hour = Math.floor(totalSeconds / 3600);
    var minute = Math.floor((totalSeconds - hour * 3600) / 60);
    var seconds = totalSeconds - (hour * 3600 + minute * 60);
    if (minute < 10)
        minute = "0" + minute;
    if (seconds < 10)
        seconds = "0" + seconds;
    document.getElementById("timer").innerHTML = minute + ":" + seconds;
}
function stopGameTimer(){
    clearInterval(timerVar);
}

function determineDifficulty() {
    var game = document.getElementById('game-container');
    var difficulty = game.dataset.difficulty;

    if (difficulty === 'hard') {
        matchesNeeded = 20
    }
    if (difficulty === 'normal') {
        matchesNeeded = 10
    }
    if (difficulty === 'easy') {
        matchesNeeded = 5
    }
    console.log(difficulty)
}

function toggleTurn() {
    if (turn === 'first') {
        turn = 'second'
    } else {
        turn = 'first'
    }
}

function flip(id) {
    const card = document.getElementById(id)
    card.classList.add('flip')
}

function checkCards() {
    if (one === two && oneId !== twoId) {
        match(oneId, twoId)
    }
    if (one !== two) {
        mismatch(oneId, twoId)
    }
    console.log(turns)
}

function match(idOne, idTwo) {
    matchesMade++
    const cardOne = document.getElementById(idOne)
    cardOne.classList.add('match', 'flip')
    cardOne.removeAttribute('data-action')
    const cardTwo = document.getElementById(idTwo)
    cardTwo.classList.add('match', 'flip')
    cardTwo.removeAttribute('data-action')
    gameOver()
}

function gameOver() {
    if (matchesMade === matchesNeeded) {
        showMessage("You are a winner!");
        saveScore();
        resetGame();
    }
}
async function saveScore(){
    const response = await post('/save-score', { responseKind: 'json', body: JSON.stringify({ name: 'Danielle', turns: turns, time: totalSeconds }) })

    if(response.ok){
        const json = await response.json
        console.log(json)
    }
}

function resetGame(){
    stopGameTimer();
    totalSeconds = 0
    turn = ''
    turns = 0
    matchesMade = 0
    matchesNeeded = "" // Set to empty to trigger it being set.
    one = ""
    two = ""
    oneId = ""
    twoId = ""
}

function showMessage(message) {
    const messageDisplay = document.querySelector('#message')
    messageDisplay.append(message)
    setTimeout(() => messageDisplay.removeAttribute(message), 5000)
}

function mismatch(idOne, idTwo) {
    const cardOne = document.getElementById(idOne)
    cardOne.classList.add('mismatch')
    const cardTwo = document.getElementById(idTwo)
    cardTwo.classList.add('mismatch')
    setTimeout(() => {
        reset(idOne, idTwo)
    }, 2000)
}

function reset(idOne, idTwo) {
    const cardOne = document.getElementById(idOne)
    // This prevents the card from being hidden if it was matched mid-reset.
    if (!cardOne.classList.contains('match')) {
        cardOne.classList.remove('flip')
    }
    cardOne.classList.remove('mismatch')
    const cardTwo = document.getElementById(idTwo)
    // This prevents the card from being hidden if it was matched mid-reset.
    if (!cardTwo.classList.contains('match')) {
        cardTwo.classList.remove('flip')
    }
    cardTwo.classList.remove('mismatch')
}
