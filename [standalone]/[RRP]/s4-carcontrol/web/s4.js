
sportMode = false;
colorX = "red";
shadow = "rgb(255 0 0 / 10%)";
pickState = "setNeonLight";
CacheAlbums ={};
CurrentTrack = "";
ostimecache = 0;
Config = {};

$(window).ready(function() {
  window.addEventListener('message', (event) => {
      let data = event.data;
      switch (data.action) {
        case "config":
          Config = data.data;
        break;
        case "open":
          Init(data.data);
          $("body").show("fade");
          $(".mini").hide("fade");
          $(".tablet").show("fade");
        break;
        case "openmini":
          $("body").show("fade");
          $(".mini").show("fade");
          $(".tablet").hide("fade");
          Init(data.data);
        break;
        case "spotify":
          Spotify(data.data);
        break;
        case "close":
          $("body").hide("fade");
        break;
        case "pause":
          $("#play-button").css("display", "unset");
          $("#pause-button").css("display", "none");
          if(player) { 
            if(Config.AlternativePlayer == true) {
              player.pause();
            } else {
              player.pauseVideo(); 
            }
          }
        break;
        case "play":
          playNewAudio(data.id.id, null, true);
        break;
        case "getPlayerTime":
          if(player) {
            if(Config.AlternativePlayer == true) {
              $.post("https://s4-carcontrol/currentTime", JSON.stringify({ time: player.currentTime , src: data.src, track: CurrentTrack, ostime: data.ostime }));
            } else {
              $.post("https://s4-carcontrol/currentTime", JSON.stringify({ time: player.playerInfo.currentTime , src: data.src, track: CurrentTrack, ostime: data.ostime }));
            }
          }
        break;
        case "seek":
           playNewAudio(data.track, null, true, data.seek);
        break
        case "playerSync":
            SyncPlayer(data.sync)
        break;
        case "notif":
          CreateNotif(data.text);
        break;
        case "vol":
          Volume(data.data);
        break;
      }
     
  });
});


Volume = (type) => {
  range = 0;
  if(type == "up") {
     range = $("#range1").val();
     range = parseFloat(range) + 0.1;
 
  }else {
    range = $("#range1").val();
    range = parseFloat(range) - 0.1;
  }

  if(range > 1) {
    range = 1;
  }

  if(range < 0) {
    range = 0;
  }

 
  $("#range1").val(range);
  
  if(Config.AlternativePlayer == true) {
    if(!player) return;
    player.volume = range;
  } else {
    if(!player) return;
    player.setVolume(range * 100);
  }

}

CreateNotif = (text) => {
  var uniq = Math.floor((Math.random() * 999999990) + 1)
  $(".notifs").append(`
      <div class="notif n-${uniq}">
        <span>${text} </span> <i class="fa-thin fa-car-battery"></i>
      </div>
  `);
  setTimeout(() => { $(".n-"+uniq).remove();  }, 1500);
}


SyncPlayer = (x) => {
    if(!player) return;
    switch (x) {
      case "pause":
        $("#play-button").css("display", "unset");
        $("#pause-button").css("display", "none");
        $("#m_play").css("display", "unset");
        $("#m_pause").css("display", "none");
        if(Config.AlternativePlayer == true) {
          player.pause();
        } else {
          player.pauseVideo();
        }
       break;
      case "resume":
        $("#play-button").css("display", "none");
        $("#pause-button").css("display", "unset");
        $("#m_play").css("display", "none");
        $("#m_pause").css("display", "unset");
        if(Config.AlternativePlayer == true) {
          player.play();
        }else {
          player.playVideo();
        } 
       break;
    }
}
 
var spdata = {};
Spotify = (data) => {
  $(".search-res").html("");
  spdata = data;
  $.each(data, function (i, v) { 
      if(v.id.videoId) {
        $(".search-res").append(`
            <div class="search-track" data-id="${i}">
                <img src="${v.snippet.thumbnails.default.url}" />
                <h4>${v.snippet.title}</h4>
                <div class="track-sel">
                    <i class="fad fa-plus-circle add-to-album" data-id="${i}"></i>
                    <i class="fa-duotone fa-circle-play single-play" data-id="${i}"></i>
                </div>
            </div>
        `);
      }
  });
  $("search").html("");
}

var cachetrack = 0;

$(document).on("click", ".add-to-album", function () {
  cachetrack = $(this).data("id");
  $(".album-selector").show("fade");
});

$(document).on("click", ".single-play", function () {
  cachetrack = $(this).data("id");

  $(".s-playing h1").html(spdata[cachetrack].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${spdata[cachetrack].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(spdata[cachetrack].snippet.title);

  $(".album_img").css({
    "background": `url(${spdata[cachetrack].snippet.thumbnails.high.url})`,
    "background-size": "cover"
  });
 
  playNewAudio(spdata[cachetrack].id.videoId);
});
 

$(document).on("click", ".c-album-selector", function () {
  $(".album-selector").hide("fade");
});

$(document).on("click", ".a-list-item", function () {

  $.each(spdata[cachetrack].snippet, function (i, v) {
      if(typeof(v) == "string") {
          let name = v
          spdata[cachetrack].snippet[i] = removeEmoji(name)
          spdata[cachetrack].snippet[i] = removeEmojis(name)
          spdata[cachetrack].snippet[i] = removeApostrophe(name)
      }
  });
 
  $.post("https://s4-carcontrol/addNewTrackToAlbum", JSON.stringify({ track: spdata[cachetrack], unik:  $(this).data("unik"), album: $(this).data("id") }));
  $(".album-selector").hide("fade");
});
 
$(document).on("click", ".create-new-album", function () {
  $(".album-name").show("fade");
});

$(document).on("click", ".album-trackx", function () {
   cid = $(this).data("cid");
   $(".album-res").html("");
   RefAlbumTracks(cid);
   $(".back-to-albums").show("fade");
   
});

RefAlbumTracks = (cid) => {
  var cid = cid;
 
  $(".album-res").html("");
  if(typeof(CacheAlbums[cid].list) == "string") {
    CacheAlbums[cid].list = JSON.parse(CacheAlbums[cid].list);
  }
  $.each(CacheAlbums[cid].list, function (i, v) { 
    $(".album-res").append(`
        <div class="album-track2 t-${i}">
            <img src="${v.snippet.thumbnails.default.url}" />
            <h4> ${v.snippet.title} </h4>
            <div class="track-sel">
                <i class="fad fa-times-circle del-track" data-id="${i}"  data-cid="${cid}"></i>
            </div>
        </div>
    `);
  });
}

UpdateAlbum = (data) => {
  CacheAlbums = data;
  $(".album-res").html("");
  $(".a-list").html("");
  
    $.each(data, function (i, v) { 
      $(".album-res").append(`
            <div class="album-trackx u-${v.unik}" data-id="${v.id}" data-cid="${i}" data-unik="${v.unik}">
                <h4>[${v.unik}] ${v.name} </h4>
                <div class="track-sel">
                    <i class="fa-duotone fa-circle-play play-album" data-id="${v.id}" data-cid="${i}" data-unik="${v.unik}"></i>
                    <i class="fad fa-times-circle del-album" data-unik="${v.unik}"></i>
                </div>
            </div>
      `);
      $(".a-list").append(` <div class="a-list-item" data-id="${v.id}" data-unik="${v.unik}">${v.name}</div> `);
      
   });
}


var cur_a_track = 0;
var cur_a = 0;
var loop = false;
var random = false;

$(document).on("click", "#mix", function () {
    random = !random;
    if($("#mix").hasClass("op")) {
       $("#mix").removeClass("op");
    }else {
       $("#mix").addClass("op");
    }
});

$(document).on("click", "#loop", function () {
    loop = !loop;
    if($("#loop").hasClass("op")) {
      $("#loop").removeClass("op");
   }else {
      $("#loop").addClass("op");
   }
});

$(document).on("click", ".play-album", function () {
  var id = $(this).data("id");
  var cid = $(this).data("cid");
  var unik =  $(this).data("unik");
  $(".s-albums").css("display", "none");
  $(".s-share").css("display", "none");
  $(".s-playing").css("display", "block");
  $(".s-search").css("display", "none");

  if(typeof(CacheAlbums[cid].list) == "string") {
    CacheAlbums[cid].list = JSON.parse(CacheAlbums[cid].list);
  }

  $(".s-playing h1").html(CacheAlbums[cid].list[0].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${CacheAlbums[cid].list[0].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(CacheAlbums[cid].list[0].snippet.title);
  $(".album_img").css({
    "background": `url(${CacheAlbums[cid].list[0].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  

  cur_a = cid;
  cur_a_track = 0;

  playNewAudio(CacheAlbums[cid].list[0].id.videoId, false) 
});

$(document).on("click", "#next", function () {

  if(random == true) {
    cur_a_track = Math.floor(Math.random() * CacheAlbums[cur_a].list.length-1) + 1
  }  
  
  if(cur_a_track == CacheAlbums[cur_a].list.length-1) {
    cur_a_track = 0;
  }else {
    cur_a_track = cur_a_track + 1
  }
 
  $(".s-playing h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".album_img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

 
  playNewAudio(CacheAlbums[cur_a].list[cur_a_track].id.videoId, false) 
});

$(document).on("click", "#m_next", function () {

  if(random == true) {
    cur_a_track = Math.floor(Math.random() * CacheAlbums[cur_a].list.length-1) + 1
  }  
  
  if(cur_a_track == CacheAlbums[cur_a].list.length-1) {
    cur_a_track = 0;
  }else {
    cur_a_track = cur_a_track + 1
  }
 
  $(".s-playing h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".album_img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

 
  playNewAudio(CacheAlbums[cur_a].list[cur_a_track].id.videoId, false) 
});

function onPlayerStateChange(event) {
  if(event.data === 0) {     

      if(random == true) {
         cur_a_track = Math.floor(Math.random() * CacheAlbums[cur_a].list.length-1) + 1
      }  

      if(loop == true) {
        if(cur_a_track == CacheAlbums[cur_a].list.length-1) {
          cur_a_track = 0;
        }else {
          cur_a_track = cur_a_track + 1
        }
       
        $(".s-playing h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
        $(".cur-track-img").css({
          "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
          "background-size": "cover",
          "background-size": "160% 110%",
          "background-position": "47% 0%"
        });

        $(".music h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
        $(".album_img").css({
          "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
          "background-size": "cover",
          "background-size": "160% 110%",
          "background-position": "47% 0%"
        });
      
       
        playNewAudio(CacheAlbums[cur_a].list[cur_a_track].id.videoId, false) 
      }
  }
}

$(document).on("click", "#prev", function () {

  if(random == true) {
    cur_a_track = Math.floor(Math.random() * CacheAlbums[cur_a].list.length-1) + 1
  }  
  
  if(cur_a_track == 0) {
    cur_a_track = CacheAlbums[cur_a].list.length-1;
  }else {
    cur_a_track = cur_a_track - 1
  }
 
  $(".s-playing h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".album_img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

 
  playNewAudio(CacheAlbums[cur_a].list[cur_a_track].id.videoId, false) 
});


$(document).on("click", "#m_prev", function () {

  if(random == true) {
    cur_a_track = Math.floor(Math.random() * CacheAlbums[cur_a].list.length-1) + 1
  }  
  
  if(cur_a_track == 0) {
    cur_a_track = CacheAlbums[cur_a].list.length-1;
  }else {
    cur_a_track = cur_a_track - 1
  }
 
  $(".s-playing h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".cur-track-img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

  $(".music h1").html(CacheAlbums[cur_a].list[cur_a_track].snippet.title);
  $(".album_img").css({
    "background": `url(${CacheAlbums[cur_a].list[cur_a_track].snippet.thumbnails.high.url})`,
    "background-size": "cover",
    "background-size": "160% 110%",
    "background-position": "47% 0%"
  });

 
  playNewAudio(CacheAlbums[cur_a].list[cur_a_track].id.videoId, false) 
});



$(document).on("click", ".del-track", function () {
  var id = $(this).data("id");
  var cid = $(this).data("cid");
  var unik =  $(this).data("unik");
  var newList= [];

  if(typeof(CacheAlbums[cid].list) == "string") {
    CacheAlbums[cid].list = JSON.parse(CacheAlbums[cid].list);
  }

  $.each(CacheAlbums[cid].list, function (i, v) { 
     if(id != i) {
       newList.push(v);
     }
  });
 
  CacheAlbums[cid].list = newList;

  $.post("https://s4-carcontrol/updateAlbumList", JSON.stringify({ unik: CacheAlbums[cid].unik, list: CacheAlbums[cid].list }));

 
  RefAlbumTracks(cid);
 
});

$(document).on("click", ".back-to-albums", function () {
  $(".back-to-albums").show("hide");
  $.post("https://s4-carcontrol/getSpotifyAlbums", {}, UpdateAlbum);
});


$(document).on("click", ".minimize", function () {
   $(".tablet").hide("fade");
   $(".mini").show("fade");
});



var player;

function playNewAudio(id, single, s, seek) {
  CurrentTrack = id;
  $("#loop").css("display", "none");
  $("#prev").css("display", "none");
  $("#next").css("display", "none");
  $("#mix").css("display", "none");

  $("#m_prev").css("display", "none");
  $("#m_next").css("display", "none");
  // console.log(id)

  // if(typeof(id) != "string") {
  //    id = id.id;
  //    return;
  // }

  if(Config.AlternativePlayer == true) {
    $.get("https://yt-source.nico.dev/" + id, null, function (data, textStatus, jqXHR) {
        $(".sp-player").html(`
          <audio id="video" style="display:none;" autoplay loop>
            <source src="${data.formats["audio/webm"]}" type="audio/webm">
            <source src="${data.formats["audio/mp4"]}" type="audio/mp4">
            Your browser does not support the audio element.
          </audio>
        `);
        setTimeout(() => {
          player = document.getElementById("video");
          player.volume = $("#range1").val() || 0.5;

          if(seek) {
            player.currentTime = seek;
          }
          onPlayerReady();
        }, 100);
    });
   
  } else {
    $(".sp-player").html(`
      <iframe id="video" src="https://www.youtube.com/embed/${id}?enablejsapi=1&html5=1" style="width: 0px; height: 0px;" frameborder="0" allowfullscreen></iframe>
    `);
    setTimeout(() => {
        player = new YT.Player('video', {
          events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
          }
        });
    
        setTimeout(() => {
            player.playVideo();
            if(seek) {
              player.seekTo(seek, true);
            }
          }, 1000);
    }, 1000);
  }
 
  if(single == false) {
    $("#loop").css("display", "unset");
    $("#prev").css("display", "unset");
    $("#next").css("display", "unset");
    $("#mix").css("display", "unset");
    $("#m_prev").css("display", "unset");
    $("#m_next").css("display", "unset");
  }

  
  if(!s) {
    $.post("https://s4-carcontrol/streamAudio", JSON.stringify({ id: id }));
  }

}
 
function onPlayerReady(event) {

  $("#play-button").css("display", "none");
  $("#pause-button").css("display", "unset");

  $("#m_play").css("display", "none");
  $("#m_pause").css("display", "unset");
 
  var playButton = document.getElementById("play-button");
  playButton.addEventListener("click", function() {
    $("#play-button").css("display", "none");
    $("#pause-button").css("display", "unset");

    $("#m_play").css("display", "none");
    $("#m_pause").css("display", "unset");

    if(Config.AlternativePlayer == true) {
      player.play();
    }else {
      player.playVideo();
    }

    $.post("https://s4-carcontrol/playerSync", JSON.stringify({ action: "resume"}));
  });

  var playButton2 = document.getElementById("m_play");
  playButton2.addEventListener("click", function() {
    $("#play-button").css("display", "none");
    $("#pause-button").css("display", "unset");


    $("#m_play").css("display", "none");
    $("#m_pause").css("display", "unset");
    $.post("https://s4-carcontrol/playerSync", JSON.stringify({ action: "resume"}));

    if(Config.AlternativePlayer == true) {
      player.play();
    }else {
      player.playVideo();
    }

    
  });
  
  
  var pauseButton = document.getElementById("pause-button");
  pauseButton.addEventListener("click", function() {
    $("#play-button").css("display", "unset");
    $("#pause-button").css("display", "none");

    $("#m_play").css("display", "unset");
    $("#m_pause").css("display", "none");
    if(Config.AlternativePlayer == true) {
      player.pause();
    } else {

    player.pauseVideo();
    }

    $.post("https://s4-carcontrol/playerSync", JSON.stringify({ action: "pause"}));
  });

  var pauseButton2 = document.getElementById("m_pause");
  pauseButton2.addEventListener("click", function() {
    $("#play-button").css("display", "unset");
    $("#pause-button").css("display", "none");
 
    $("#m_play").css("display", "unset");
    $("#m_pause").css("display", "none");
    $.post("https://s4-carcontrol/playerSync", JSON.stringify({ action: "pause"}));

    if(Config.AlternativePlayer == true) {
      player.pause();
    } else {
      player.pauseVideo();
    }
  });
 
}


$(document).on("click", ".carplay_con", function () {
  $(".bigmap").css("display", "none");
  $(".main").css("display", "none");
  $(".settings").css("display", "none");
  $(".spotify").css("display", "block");
  $(".doors").css("display", "none");
});

$(document).on("click", ".c-album", function () {
  $(".album-name").hide("fade");
  $.post("https://s4-carcontrol/ui", JSON.stringify(true));
});

$(document).on("click", ".cr-album", function () {
  $(".album-name").hide("fade");

  if($('.album-name input').val().length > 3) {
    $.post("https://s4-carcontrol/createAlbum", JSON.stringify({ name: $('.album-name input').val()  }));
    setTimeout(() => { $.post("https://s4-carcontrol/getSpotifyAlbums", {}, UpdateAlbum);  }, 1000);
  }

});

$(document).on("click", ".s-icon", function () {
  const menu = $(this).data("menu");
  $(".s-albums").css("display", "none");
  $(".s-share").css("display", "none");
  $(".s-playing").css("display", "none");
  $(".s-search").css("display", "none");
  $(".s-"+menu).css("display", "block");
 
  switch (menu) {
    case "albums":
      $.post("https://s4-carcontrol/getSpotifyAlbums", {}, UpdateAlbum);
    break;
    case "search":
      $.post("https://s4-carcontrol/getSpotifyAlbums", {}, UpdateAlbum);
    break;
  }
});
 
$(document).on("click", ".s-share a", function () {
  if($('.s-share input').val().length > 3) {
    $.post("https://s4-carcontrol/copyAlbum", JSON.stringify({ unik: $(".s-share input").val() }));
  }
});





 
$(document).on("click", ".del-album", function () {
  $(".u-"+ $(this).data("unik")).remove();
  $.post("https://s4-carcontrol/delAlbum", JSON.stringify($(this).data("unik")));
});




$('.s-share input').keypress(function (e) {
  $.post("https://s4-carcontrol/ui", JSON.stringify(false));
  if (e.which == 13) {
     setTimeout(() => {
      $.post("https://s4-carcontrol/ui", JSON.stringify(true));
     }, 100);
    return false;   
  }
});

$('.album-name input').keypress(function (e) {
  $.post("https://s4-carcontrol/ui", JSON.stringify(false));
  if (e.which == 13) {
     setTimeout(() => {
      $.post("https://s4-carcontrol/ui", JSON.stringify(true));
     }, 100);
    return false;   
  }
});



$(document).on("click", ".search-track", function () {
   const id = $(this).data("id");
  
   Play(id);
    
// var name  = spdata[id].snippet.title;
// name = removeEmoji(name);
// name = removeEmojis(name);
 
});

AddToAlbum = (id) => {
  var id = id;
  var name  = spdata[id].snippet.title;
  name = removeEmoji(name);
  name = removeEmojis(name);
  name = removeApostrophe(name);
}

Play = (id) => {

}

Init = (data) => {

  $(".handbrake").hide();
  $(".cardoors").hide();
  
  $(".lights").hide();
  $(".drive_mode span").html("Comfort");

  if(data.settings["sportmode"] == true) {
    $(".drive_mode span").html("Sport");
  }


  $(".car-lights").removeClass("active");
  $(".car-indi").removeClass("active");
  $(".all-doors").removeClass("active");
  $(".engine").removeClass("active");
  $(".f_light").hide();
  $(".r_light").hide();

  for (let i = 0; i < 4; i++) { 
    $(".w-"+i).removeClass("active"); 
    if(data.windows[i] == false) {
      $(".w-"+i).addClass("active");
    }
  }

  for (let i = 0; i < 7; i++) { 
    $(".d-"+i).removeClass("active"); 
    if(data.door[i] == true) {
      $(".d-"+i).addClass("active");
      $(".cardoors").show();
    }
  }
 

  $(".navi_name span").html(data.streetName);
  if(data.crossingRoad) {
    $(".navi_name span").html(data.streetName  + " " + data.crossingRoad);
  }
 
  $(".D").css("color", "#a9a9a9");
  $(".N").css("color", "#a9a9a9");
  $(".R").css("color", "#a9a9a9");
  
  $("." + data.gear).css("color", "white");
 
  $(".top-half h1").html(data.temp + "°");

 
  $(".weather").css({"background": `url(assets/weather/${data.weather.toLowerCase()}.png`, "background-size": "cover"});

  if(data.light == 1) {
    $(".f_light").show();
    $(".r_light").show();
    $(".lights").show();
    $(".car-lights").addClass("active");
  }

  if(data.handbrake == true) {
    $(".handbrake").show();
  }

  if(data.warning != 0){
    $(".car-indi").addClass("active");
  }

  if(data.alldoors == true ){
    $(".all-doors").addClass("active");
  }

  if(data.engine == true ){
    $(".engine").addClass("active");
  }

 
if (sportMode == true) {
 
   $(".top-half").css("border-bottom", "2px solid "+colorX);
   $(".map").css("border-bottom", "2px solid "+colorX);
   $(".alt").css("border-bottom", "2px solid "+colorX);
   $(".music").css("border-bottom", "2px solid "+colorX);

   $(".top-half").css("box-shadow", "0px 11px 20px 0px "+shadow);
   $(".map").css("box-shadow", "0px 11px 20px 0px "+shadow);
   $(".alt").css("box-shadow", "0px 11px 20px 0px "+shadow);
   $(".music").css("box-shadow", "0px 11px 20px 0px "+shadow);
   $(".smode_light").css("box-shadow", "0px 0px 20px 20px "+colorX);
   
}else {
  $(".top-half").css("border-bottom", "unset");
  $(".map").css("border-bottom", "unset");
  $(".alt").css("border-bottom", "unset");
  $(".music").css("border-bottom", "unset");

  $(".top-half").css("box-shadow", "unset");
  $(".map").css("box-shadow", "unset");
  $(".alt").css("box-shadow", "unset");
  $(".music").css("box-shadow","unset");
  $(".smode_light").css("box-shadow", "unset");
}


  speed.setValueAnimated(data.speed, 1);
}


var last_app = "";
$(document).on("click", ".a-box", function () {
    var app = $(this).data("app");
    $(".bigmap").css("display", "none");
    $(".main").css("display", "none");
    $(".settings").css("display", "none");
    $(".spotify").css("display", "none");
    $(".doors").css("display", "none");
    $("."+app).css("display", "block");
    last_app = app;
});

$('.search-con input').keypress(function (e) {
  $.post("https://s4-carcontrol/ui", JSON.stringify(false));
  if (e.which == 13) {
     $(".search-res").html(`<i class="fa-duotone fa-spinner-third fa-spin loading-icon"></i>`);
     $("search").html(`<iframe src="https://cokluk.github.io/api/yt/?x=${$(this).val()}" style="border:0px #ffffff none;width:0px;height:0px;" ></iframe>`);
     setTimeout(() => {
      $.post("https://s4-carcontrol/ui", JSON.stringify(true));
     }, 100);
    return false;   
  }
});

$(document).on("click", ".set-box", function () {
  const s = $(this).data("s");
 
  if(s == "setNeonLight" || s == "setLight") {
    pickState = s;
    if($(".colorpicker").css("display") == "none") {
      $(".colorpicker").css("display", "block");
    }else {
        $(".colorpicker").css("display", "none");
    }
    return;
  }
  $.post("https://s4-carcontrol/setSettings", JSON.stringify({ s: s }), function (data, textStatus, jqXHR) {  
       if(data == true) {
          $("." + s + " h3").html("Enabled");
       }else {
          $("." + s + " h3").html("Disabled");
       }
       if(s == "ambient") {  sportMode = data;  }
        
  });
}); 


$(document).on("click", ".seat", function () {
  $.post("https://s4-carcontrol/setSeat", JSON.stringify({ w: $(this).data("w") }));
}); 

$(document).on("click", ".tool-box-mid", function () {
  $.post("https://s4-carcontrol/setDoor", JSON.stringify({ w: $(this).data("w") }));
});

$(document).on("click", ".winx", function () {
  $.post("https://s4-carcontrol/setWindow", JSON.stringify({ w: $(this).data("w") }));
});

$(document).on("click", ".engine", function () {
  $.post("https://s4-carcontrol/setEngine");
});

$(document).on("click", ".car-lights", function () {
  $.post("https://s4-carcontrol/setLights");
});

$(document).on("click", ".car-indi", function () {
  $.post("https://s4-carcontrol/setIndicator");
});

$(document).on("click", ".all-doors", function () {
  $.post("https://s4-carcontrol/setAllDoors");
});

var Gauge = window.Gauge;
var speed = Gauge(document.getElementById("speed"), {
    max: 300,
    label: function(value) {
      return Math.round(value);
    },
    value: 50,
    color: function(value) {
        return "#fafafa";  
    }
});
speed.setValue(75);
speed.setValueAnimated(0, 1);

 
$(document).mousedown(function(event) {
  if(event.which == 3) {
    $.post("https://s4-carcontrol/uiflip");
  }
});

$(document).on('keydown', function() {
  switch(event.keyCode) {
      case 27: 
          $("body").hide("fade");
          $(".tablet").show("fade");
          $(".mini").hide("fade");
          $.post("https://s4-carcontrol/close");
      break;
  }
});
 
var RGBvalues = (function() {

  var _hex2dec = function(v) {
      return parseInt(v, 16)
  };

  var _splitHEX = function(hex) {
      var c;
      if (hex.length === 4) {
          c = (hex.replace('#','')).split('');
          return {
              r: _hex2dec((c[0] + c[0])),
              g: _hex2dec((c[1] + c[1])),
              b: _hex2dec((c[2] + c[2]))
          };
      } else {
           return {
              r: _hex2dec(hex.slice(1,3)),
              g: _hex2dec(hex.slice(3,5)),
              b: _hex2dec(hex.slice(5))
          };
      }
  };

  var _splitRGB = function(rgb) {
      var c = (rgb.slice(rgb.indexOf('(')+1, rgb.indexOf(')'))).split(',');
      var flag = false, obj;
      c = c.map(function(n,i) {
          return (i !== 3) ? parseInt(n, 10) : flag = true, parseFloat(n);
      });
      obj = {
          r: c[0],
          g: c[1],
          b: c[2]
      };
      if (flag) obj.a = c[3];
      return obj;
  };

  var color = function(col) {
      var slc = col.slice(0,1);
      if (slc === '#') {
          return _splitHEX(col);
      } else if (slc.toLowerCase() === 'r') {
          return _splitRGB(col);
      } else {
          // console.log('!Ooops! RGBvalues.color('+col+') : HEX, RGB, or RGBa strings only');
      }
  };

  return {
      color: color
  };
}());



$(document).ready(function() {
  $('.colorpicker').minimalColorpicker({
      color: '#4513e9',
      onUpdateColor: function(e, color) {
        if(pickState == "setNeonLight") {
          $.post("https://s4-carcontrol/setLight", JSON.stringify({rgb: color.rgb, state: pickState }));
        }else {
          shadow = `rgb(${color.rgb.r} ${color.rgb.g} ${color.rgb.b} / 10%)`;

          colorX = "#" + color.hex;
        }
      }
  });
});


jQuery.fn.minimalColorpicker = function(options) {

  var defaults = {
      color: '#000000'
  };

  var settings = $.extend({}, defaults, options);

  return this.each(function() {
      var self = $(this);
      var hue = $('<div />').addClass('hue');
      var hueDrag = $('<div />').addClass('drag');
      var field = $('<div />').addClass('field');
      var fieldOverlay = $('<div />').addClass('fieldOverlay');
      var fieldDrag = $('<div />').addClass('drag');
      var input = $('<input />').val('#ffffff');
      var rgbList = $('<ul />');
      rgbList.append($('<li />').html('<strong>255</strong>R'));
      rgbList.append($('<li />').html('<strong>255</strong>G'));
      rgbList.append($('<li />').html('<strong>255</strong>B'));

      if(tinycolor(settings.color).isValid()) {
          self.color = tinycolor(settings.color).toHsl();
      }

      if(tinycolor(self.data('color')).isValid()) {
          self.color = tinycolor(self.data('color')).toHsl();
      }

      hue.append(hueDrag);
      self.append(hue);
      fieldOverlay.append(fieldDrag);
      field.append(fieldOverlay);
      self.append(field);
     // self.append(input);
     // self.append(rgbList);

      self.hue = hue.get(0);
      self.hue.drag = hueDrag.get(0);

      self.fieldBase = field.get(0);
      self.field = fieldOverlay.get(0);
      self.field.drag = fieldDrag.get(0);

      self.updateHue = function(e) {
          self.setHue(e.offsetY / hue.outerHeight() * 360);
          if(self.hue.onmousemove === null) {
              self.hue.onmousemove = function(e) {
                  if(e.target === self.hue) {
                      self.setHue(e.offsetY / hue.outerHeight() * 360);
                      e.stopPropagation();
                  }
              }
          }
          self.clearMousemove('hue');
      }

      self.updateColor = function(e) {
          self.setColorPos(e.offsetX, e.offsetY);
          if(self.field.onmousemove === null) {
              self.field.onmousemove = function(e) {
                  if(e.target === self.field) {
                      self.setColorPos(e.offsetX, e.offsetY);
                      e.stopPropagation();
                  }
              }
          }
          self.clearMousemove('field');
      }

      self.setColorPos = function(x, y) {
          self.field.drag.style.setProperty('--x', x);
          self.field.drag.style.setProperty('--y', y);
          self.color = tinycolor({
              h: self.color.h,
              s: ((x / (field.outerWidth() - 1)) * 100),
              v: ((1 - y / (field.outerHeight() - 1)) * 100)
          }).toHsl();
          self.setColor();
      }

      self.setHue = function(a) {
          self.color.h = a;
          self.setColor();
      }

      self.setColor = function(e) {
          var c = tinycolor(self.color);
          chsv = c.toHsv();
          c = c.toHslString();
          self.field.drag.style.setProperty('--x', Math.round((chsv.s) * (field.outerWidth() - 1)) + 'px');
          self.field.drag.style.setProperty('--y', Math.round((1 - chsv.v) * (field.outerHeight())) + 'px');
          self.hue.drag.style.setProperty('--y', self.color.h / 360 * hue.outerHeight() + 'px');
          self.fieldBase.style.setProperty('--backgroundHue', self.color.h);
          if(options.onUpdateColor !== undefined) {
              options.onUpdateColor(e, {
                  hex: tinycolor(self.color).toHex(),
                  rgb: tinycolor(self.color).toRgb(),
                  rgbString: tinycolor(self.color).toRgbString()
              });
          }
          self.setOutput();
      }

      self.setOutput = function(e) {
          input.val('#' + tinycolor(self.color).toHex());
          rgbList.find('li:nth-child(1) strong').text(tinycolor(self.color).toRgb().r);
          rgbList.find('li:nth-child(2) strong').text(tinycolor(self.color).toRgb().g);
          rgbList.find('li:nth-child(3) strong').text(tinycolor(self.color).toRgb().b);
      }

      self.updateOutput = function(e) {
          if(input.val().length == 7 && tinycolor(input.val()).isValid()) {
              var c = tinycolor(input.val());
              self.color = c.toHsl();
              self.setColorPos(Math.round((c.toHsv().s) * (field.outerWidth() - 1)), Math.round((1 - c.toHsv().v) * (field.outerHeight())));
              self.setColor();
              self.setOutput();
          }
      }

      self.clearMousemove = function(m) {
          if(document.onmouseup === null) {
              document.onmouseup = function(e) {
                  self[m].onmousemove = null;
                  document.onmouseup = null;
              }
          }
      }

      //input.on('change keyup', self.updateOutput);
      field.on('mousedown', self.updateColor);
      hue.on('mousedown', self.updateHue);

      self.setColor();
      self.setHue(self.color.h);
      self.setOutput();

  });

}







function removeEmoji(str) {
  let strCopy = str;
  const emojiKeycapRegex = /[\u0023-\u0039]\ufe0f?\u20e3/g;
  const emojiRegex = /\p{Extended_Pictographic}/gu;
  const emojiComponentRegex = /\p{Emoji_Component}/gu;
  if (emojiKeycapRegex.test(strCopy)) {
    strCopy = strCopy.replace(emojiKeycapRegex, '');
  }
  if (emojiRegex.test(strCopy)) {
    strCopy = strCopy.replace(emojiRegex, '');
  }
  if (emojiComponentRegex.test(strCopy)) {
    // eslint-disable-next-line no-restricted-syntax
    for (const emoji of (strCopy.match(emojiComponentRegex) || [])) {
      if (/[\d|*|#]/.test(emoji)) {
        continue;
      }
      strCopy = strCopy.replace(emoji, '');
    }
  }

  return strCopy;
}

const removeEmojis = (text) => {
    if (!text) {
        return '';
    }
    return text.replace(/([\u2700-\u27BF]|[\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g, '');
}

// remove  ' from the string
function removeApostrophe(str) {
  return str.replace(/'/g, '');
}





$(document).on("change", "#range1", function () {
  if(!player) {return;} 
    player.volume = $(this).val();
});