// Function for getting random number between 1 and 3 for song choose

function getRandomSongNumber() {
    return random = Math.floor(Math.random() * 11) + 1;
  }
// Function for getting random number between 1 and 3 for song choose

// Function for setting a random song
  function setNewSong() {
  if (random == 1) {
    document.getElementById("loading").src = "song/song1.mp3";
    songname.innerHTML = "Lil Baby - Crazy";
  }
  else if (random == 2) {
    document.getElementById("loading").src = "song/song2.mp3";
    songname.innerHTML = "Linkin Park - In The End";
  }
  else if (random == 3) {
    document.getElementById("loading").src = "song/song3.mp3";
    songname.innerHTML = "Chase & Status & Hedex - Liquor & Cigarettes";
  }
  else if (random == 4) {
    document.getElementById("loading").src = "song/song4.mp3";
    songname.innerHTML = "Burna Boys - City Boys";
  }
  else if (random == 5) {
    document.getElementById("loading").src = "song/song5.mp3";
    songname.innerHTML = "Country Dons - Back To Back Freestyle";
  }
  else if (random == 6) {
    document.getElementById("loading").src = "song/song6.mp3";
    songname.innerHTML = "D-Block Europe - Money Cant Buy Heart";
  }
  else if (random == 7) {
    document.getElementById("loading").src = "song/song7.mp3";
    songname.innerHTML = "Baby D - Let Me Be Your Fantasy";
  }
  else if (random == 8) {
    document.getElementById("loading").src = "song/song8.mp3";
    songname.innerHTML = "Artful Dodger - Moving To Fast";
  }
  else if (random == 9) {
    document.getElementById("loading").src = "song/song9.mp3";
    songname.innerHTML = "Daniel Bedingfield - Gotta Get Thru This";
  }
  else if (random == 10) {
    document.getElementById("loading").src = "song/song10.mp3";
    songname.innerHTML = "Boney M - Sunny";
  }
  else if (random == 11) {
    document.getElementById("loading").src = "song/song11.mp3";
    songname.innerHTML = "Gadjo - So Many Times";
  }

  }
// Function for setting a random song

// Function for random song select on page loaded
document.addEventListener("DOMContentLoaded", function () {
    // Volání funkcí pro výběr a nastavení náhodné písně
    var random = getRandomSongNumber();
    setNewSong(random);
  });
// Function for random song select page loaded

// Function for lower or higher up sound in background, its working function in script but its not noted in text//
var play = false;
var vid = document.getElementById("loading");
vid.volume = 0.2;
window.addEventListener('keyup', function(e) {
    if (e.which == 38) { // ArrowDOWN
        vid.volume = Math.min(vid.volume + 0.025, 1);
    } else if (e.which == 40) { // ArrowUP
        vid.volume = Math.max(vid.volume - 0.025, 0);
    };
});
// Function for lower or higher up sound in background, its working function in script but its not noted in text//

var mutetext = document.getElementById("text");
var songname = document.getElementById("songname");

window.addEventListener("keyup", function(event) {
    if (event.which == 37) { // ArrowLEFT
        if (document.getElementById("loading").src.endsWith("song11.mp3")) {
            document.getElementById("loading").src = "song/song1.mp3";
            songname.innerHTML = "Lil Baby - Crazy";

        } else if (document.getElementById("loading").src.endsWith("song1.mp3")) {
            document.getElementById("loading").src = "song/song2.mp3";
            songname.innerHTML = "Linkin Park - In The End";

        } else if (document.getElementById("loading").src.endsWith("song2.mp3")) {
            document.getElementById("loading").src = "song/song3.mp3";
            songname.innerHTML = "Chase & Status & Hedex - Liquor & Cigarettes";

        } else if (document.getElementById("loading").src.endsWith("song3.mp3")) {
            document.getElementById("loading").src = "song/song4.mp3";
            songname.innerHTML = "Burna Boys - City Boys";

        } else if (document.getElementById("loading").src.endsWith("song4.mp3")) {
            document.getElementById("loading").src = "song/song5.mp3";
            songname.innerHTML = "Country Dons - Back To Back Freestyle";

        } else if (document.getElementById("loading").src.endsWith("song5.mp3")) {
            document.getElementById("loading").src = "song/song6.mp3";
            songname.innerHTML = "D-Block Europe - Money Cant Buy Heart";

        } else if (document.getElementById("loading").src.endsWith("song6.mp3")) {
            document.getElementById("loading").src = "song/song7.mp3";
            songname.innerHTML = "Baby D - Let Me Be Your Fantasy";

        } else if (document.getElementById("loading").src.endsWith("song7.mp3")) {
            document.getElementById("loading").src = "song/song8.mp3";
            songname.innerHTML = "Artful Dodger - Moving To Fast";

        } else if (document.getElementById("loading").src.endsWith("song8.mp3")) {
            document.getElementById("loading").src = "song/song9.mp3";
            songname.innerHTML = "Daniel Bedingfield - Gotta Get Thru This";

        } else if (document.getElementById("loading").src.endsWith("song9.mp3")) {
            document.getElementById("loading").src = "song/song10.mp3";
            songname.innerHTML = "Boney M - Sunny";

        } else if (document.getElementById("loading").src.endsWith("song10.mp3")) {
            document.getElementById("loading").src = "song/song11.mp3";
            songname.innerHTML = "Gadjo - So Many Times";
        }
        document.getElementById("loading").play();
        mutetext.innerHTML = "MUTE";
    }

    if (event.which == 39) { // ArrowRIGHT
       if (document.getElementById("loading").src.endsWith("song2.mp3")) {
            document.getElementById("loading").src = "song/song1.mp3";
            songname.innerHTML = "Lil Baby - Crazy";

        } else if (document.getElementById("loading").src.endsWith("song3.mp3")) {
            document.getElementById("loading").src = "song/song2.mp3";
            songname.innerHTML = "Linkin Park - In The End";

        } else if (document.getElementById("loading").src.endsWith("song4.mp3")) {
            document.getElementById("loading").src = "song/song3.mp3";
            songname.innerHTML = "Chase & Status & Hedex - Liquor & Cigarettes";

        } else if (document.getElementById("loading").src.endsWith("song5.mp3")) {
            document.getElementById("loading").src = "song/song4.mp3";
            songname.innerHTML = "Burna Boys - City Boys";

        } else if (document.getElementById("loading").src.endsWith("song6.mp3")) {
            document.getElementById("loading").src = "song/song5.mp3";
            songname.innerHTML = "Country Dons - Back To Back Freestyle";

        } else if (document.getElementById("loading").src.endsWith("song7.mp3")) {
            document.getElementById("loading").src = "song/song6.mp3";
            songname.innerHTML = "D-Block Europe - Money Cant Buy Heart";

        } else if (document.getElementById("loading").src.endsWith("song8.mp3")) {
            document.getElementById("loading").src = "song/song7.mp3";
            songname.innerHTML = "Baby D - Let Me Be Your Fantasy";

        } else if (document.getElementById("loading").src.endsWith("song9.mp3")) {
            document.getElementById("loading").src = "song/song8.mp3";
            songname.innerHTML = "Artful Dodger - Moving To Fast";

        } else if (document.getElementById("loading").src.endsWith("song10.mp3")) {
            document.getElementById("loading").src = "song/song9.mp3";
            songname.innerHTML = "Daniel Bedingfield - Gotta Get Thru This";

        } else if (document.getElementById("loading").src.endsWith("song11.mp3")) {
            document.getElementById("loading").src = "song/song10.mp3";
            songname.innerHTML = "Boney M - Sunny";

        } else if (document.getElementById("loading").src.endsWith("song1.mp3")) {
            document.getElementById("loading").src = "song/song11.mp3";
            songname.innerHTML = "Gadjo - So Many Times";
        }
        document.getElementById("loading").play();
        mutetext.innerHTML = "MUTE";
    }
    
});


// Function for pause and play music in background//
var audio = document.querySelector('audio');

if (audio) {

    window.addEventListener('keydown', function(event) {

        var key = event.which || event.keyCode;
        var x = document.getElementById("text").innerText;
        var y = document.getElementById("text");

        if (key === 32 && x == "MUTE") { // spacebar

            event.preventDefault();

            audio.paused ? audio.play() : audio.pause();
            y.innerHTML = "UNMUTE";

        } else if (key === 32 && x == "UNMUTE") {

            event.preventDefault();

            audio.paused ? audio.play() : audio.pause();
            y.innerHTML = "MUTE";
        }
    });
}
// Function for pause and play music in background//

//SHADED-TEXT - Function for switching words in loading animation

var shadedText = document.querySelector('.shaded-text');
var texts = ["JOINING SERVER", "PREPARING ASSETS", "ESTABLISHING CONNECTION"];
var currentText = 0;

setInterval(function() {
currentText = (currentText + 1) % texts.length;
shadedText.classList.remove('fade-out');
void shadedText.offsetWidth;
shadedText.classList.add('fade-out');
setTimeout(function() {
shadedText.textContent = texts[currentText];
}, 1000);
}, 4000);
//SHADED-TEXT - Function for switching words in loading animation

//PLACEHOLDER - Function for getting handoverdata from lua script
window.addEventListener('DOMContentLoaded', () => {
  console.log(`You are connecting to ${window.nuiHandoverData.serverAddress}`);

  // a thing to note is the use of innerText, not innerHTML: names are user input and could contain bad HTML!
  document.querySelector('#namePlaceholder > span').innerText = window.nuiHandoverData.name;
});
//PLACEHOLDER - Function for getting handoverdata from lua scrip

//RANDOMPHRASES - Phrases generated after your steamname
(function welcometext() {
    var welcomes = ['Begin your exciting new adventure.', 'Discover the wonders of your new city.', 'Open the door to a brand-new chapter.', 'Step into a world of new possibilities.', 'Embrace your fresh beginning.', ];
    var randomWelcome = Math.floor(Math.random() * welcomes.length);
    document.getElementById('welcomeDisplay').innerHTML = welcomes[randomWelcome];
  })();
//RANDOMPHRASES - Phrases generated after your steamname
  