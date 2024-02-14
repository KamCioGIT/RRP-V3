$(document).ready(function(){
  window.addEventListener("message", function(event){
    // Show HUD when player enter a vehicle
    if(event.data.showhud == true){
      $('.huds').fadeIn();
      $('.icons').fadeIn();
      $('.text').fadeIn();
      $('.geartxt').fadeIn();
      $('.infos').fadeOut();

      if(event.data.measurementSystem === "kph"){
      setProgressSpeed(event.data.speed,'.progress-speed');
      document.getElementById("measurementsystem").innerHTML = "kph";
      }else if(event.data.measurementSystem === "mph") {
      setProgressSpeed(event.data.speed,'.progress-speed');
      document.getElementById("measurementsystem").innerHTML = "mph";
      }
    }
    if(event.data.showhud == "partial") {
      $('.huds').fadeIn();
      $('.infos').fadeIn();
      $('.text').fadeOut();
      $('.geartxt').fadeOut();
      $('.icons').fadeOut();
    }
    if(event.data.shutdown == true) {
      document.getElementById("infotxt").innerHTML = "❗️WARNING❗️<br>Vehicle shutting down.<br>Pull over safely.";
    }
    if(event.data.showhud == false){
      $('.huds').fadeOut();
    }

    // Fuel
    if(event.data.showfuel == true){
      setProgressFuel(event.data.fuel,'.progress-fuel');
      if(event.data.fuel <= 20){
        $('.progress-fuel').addClass('orangeStroke');
      }
      if(event.data.fuel <= 10){
        $('.progress-fuel').removeClass('orangeStroke');
        $('.progress-fuel').addClass('redStroke');
      }
    }

    // Lights states
    if(event.data.feuPosition == true){
      $('.feu-position').addClass('active');
    }
    if(event.data.feuPosition == false){
      $('.feu-position').removeClass('active');
    }
    if(event.data.feuRoute == true){
      $('.feu-route').addClass('active');
    }
    if(event.data.feuRoute == false){
      $('.feu-route').removeClass('active');
    }
    if(event.data.clignotantGauche == true){
      $('.clignotant-gauche').addClass('active');
    }
    if(event.data.clignotantGauche == false){
      $('.clignotant-gauche').removeClass('active');
    }
    if(event.data.clignotantDroite == true){
      $('.clignotant-droite').addClass('active');
    }
    if(event.data.clignotantDroite == false){
      $('.clignotant-droite').removeClass('active');
    }

    if(event.data.showgear == true){
      document.getElementById("gearlvl").innerHTML = event.data.gearlvl;
    }

  });

  window.addEventListener('message', function(event) {
      var item = event.data;
      if (item.date === true) {
        const d = new Date();
        let h = d.getHours();
        let min = d.getMinutes();
        var dd = String(d.getDate()).padStart(2, '0');
        var mm = String(d.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = d.getFullYear();
        if (min < 10) {
          document.getElementById("infotxt").innerHTML = mm + '.' + dd + '.' + yyyy + '.<br>' + h + " : 0" + min;;
        }else{
          document.getElementById("infotxt").innerHTML = mm + '.' + dd + '.' + yyyy + '.<br>' + h + " : " + min;;
        }
      }
    })

  // Functions
  // Fuel
  function setProgressFuel(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  // Speed
  function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('.speed');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(value);
  }
  
  // setProgress(input.value,element);
  // setProgressFuel(85,'.progress-fuel');
  // setProgressSpeed(124,'.progress-speed');

});

$(function () {
    function fuelIcon(bool) {
      fuelIconElement = document.getElementById("fuelIcon");
      if (bool) {
        fuelIconElement.style.opacity = 1.0
        fuelIconElement.style.fill = "yellow"
      } else {
        fuelIconElement.style.opacity = 0.1
        fuelIconElement.style.fill = "white"
      }
    }

    fuelIcon(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "fuelIcon") {
            if (item.status == true) {
                fuelIcon(true)
            } else {
                fuelIcon(false)
            }
        }
    })
})

$(function () {
    function tyreIcon(bool) {
      tyreIconElement = document.getElementById("tyreIcon");
      if (bool) {
        tyreIconElement.style.opacity = 1.0
        tyreIconElement.style.fill = "yellow"
      } else {
        tyreIconElement.style.opacity = 0.1
        tyreIconElement.style.fill = "white"
      }
    }

    tyreIcon(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "tyreIcon") {
            if (item.status == true) {
                tyreIcon(true)
            } else {
                tyreIcon(false)
            }
        }
    })
})

$(function () {
    function engineIcon(bool) {
      engineIconElement = document.getElementById("engineIcon");
      if (bool) {
        engineIconElement.style.opacity = 1.0
        engineIconElement.style.fill = "red"
      } else {
        engineIconElement.style.opacity = 0.1
        engineIconElement.style.fill = "white"
      }
    }

    engineIcon(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "engineIcon") {
            if (item.status == true) {
                engineIcon(true)
            } else {
                engineIcon(false)
            }
        }
    })
})

$(function () {
    function handbrakeIcon(bool) {
        handbrakeIconElement = document.getElementById("handbrakeIcon");
        if (bool) {
			    handbrakeIconElement.style.opacity = 1.0
          handbrakeIconElement.style.fill = "red"
        } else {
			    handbrakeIconElement.style.opacity = 0.1
          handbrakeIconElement.style.fill = "white"
        }
    }

    handbrakeIcon(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "handbrakeIcon") {
            if (item.status == true) {
                handbrakeIcon(true)
            } else {
                handbrakeIcon(false)
            }
        }
    })
})

$(function () {
  function seatbeltIcon(bool) {
    seatbeltIconElement = document.getElementById("seatbeltIcon");
    if (bool) {
      seatbeltIconElement.style.opacity = 1.0
      seatbeltIconElement.style.fill = "red"
    } else {
      seatbeltIconElement.style.opacity = 0.1
      seatbeltIconElement.style.fill = "white"
    }
  }

  seatbeltIcon(false)

  window.addEventListener('message', function(event) {
      var item = event.data;
      if (item.seatbeltIcon === true) {
            seatbeltIcon(true)
          } else {
            seatbeltIcon(false)
        }
  })
})

$(function () {
  function doorIcon(bool) {
    doorIconElement = document.getElementById("doorIcon");
    if (bool) {
      doorIconElement.style.opacity = 1.0
      doorIconElement.style.stroke = "red"
    } else {
      doorIconElement.style.opacity = 0.1
      doorIconElement.style.stroke = "white"
    }
  }

  doorIcon(false)

  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "doorIcon") {
        if (item.status == true) {
          doorIcon(true)
        } else {
          doorIcon(false)
        }
    }
  })
})

$(function () {
  function lockIcon(bool) {
    lockIconElement = document.getElementById("lockIcon");
    if (bool) {
      lockIconElement.style.opacity = 1.0
      lockIconElement.style.stroke = "#2ecc71"
    } else {
      lockIconElement.style.opacity = 0.1
      lockIconElement.style.stroke = "white"
    }
  }

  lockIcon(false)

  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "lockIcon") {
        if (item.status == true) {
          lockIcon(true)
        } else {
          lockIcon(false)
        }
    }
  })
})

$(function () {
  function hazardWarningIcon(status) {
    hazardWarningIconElement = document.getElementById("hazardWarningIcon");
    hazardWarningIconElement.classList.add("hazardWarningIcon");
    hazardWarningIconElement.classList.remove("hazardWarningIconInactive")
    hazardWarningIconElement.classList.add("hazardWarningIconActive");
    hazardWarningIconElement.style.webkitAnimationPlayState = status;
    if (status === "paused") {
      hazardWarningIconElement.classList.add("hazardWarningIconInactive");
      hazardWarningIconElement.classList.remove("hazardWarningIconActive")
    }
  }
 
  hazardWarningIcon("paused")

  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "hazardWarningIcon") {
      if (item.status == true) {
        hazardWarningIcon("running")
      } else {
        document.getElementById("hazardWarningIcon").style.animation = 'none';
	      document.getElementById("hazardWarningIcon").offsetWidth;
	      document.getElementById("hazardWarningIcon").style.animation = 'fadeLoopHazardWarning infinite step-start 1s';
        hazardWarningIcon("paused")
      }
    }
  })
})

$(function () {
function blinkingAnimation(status){
  var speed = document.getElementById("speed");
  speed.style.webkitAnimationPlayState = status;
  if (status === "paused") {
    speed.style.opacity = "1.00"
  }
}

blinkingAnimation("paused")

window.addEventListener('message', function(event) {
  var item = event.data;
  if (item.type === "blinkingAnimation") {
      if (item.status == true) {
        blinkingAnimation("running")
      } else {
        document.querySelector("#speed").style.animation = 'none';
	      document.querySelector("#speed").offsetWidth;
	      document.querySelector("#speed").style.animation = 'blinker infinite cubic-bezier(.5, 0, 1, 1) 1.7s';
        blinkingAnimation("paused")
      }
  }
})
})