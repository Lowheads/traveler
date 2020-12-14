<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>

  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style>
    .weather {
      display: flex;
      color: white;
    }

    .weather div {
      width: 100px;
      text-align: center;
    }

    .City {
     color: black;
    }

    .weatherContent {
      background-color: rgba(14, 139, 255, 0.712);
      color: white;
    }

    .day {
      font-size: 0.938rem;
    }

    .Icon,
    .Temp {
      font-size: 1.375em;
    }

    .Icon {
      margin-right: 2px;
    }
  </style>
</head>

<body>
<div id="map" style="width:100%;height:350px;"></div>
  <div class='weather'>
    <div class='City' style="font-size: 20px;"></div>
  </div>

  <!-- jQuery -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
    // var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"dfb19fd20ff326431f940b75f34778da";

    let city = 'jeju';
    // var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"dfb19fd20ff326431f940b75f34778da";
    var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=33.5097&lon=126.5219&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";

    // let city = 'jeju';
    // var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=33.3819233&lon=126.5617798&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";
    // let city = 'London';
    // var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=51.5285582&lon=-0.2416812&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";
    $.ajax({
      url: apiURI,
      dataType: "json",
      type: "GET",
      async: "false",
      success: function(resp) {
        console.log(resp);
        console.log("도시 이름 : " + resp.timezone.split('/')[1]);
        $('.City').append(city);

        console.log("위도 : " + resp.lat + "  경도 : " + resp.lon);
        console.log("==================================================================================");

        for (let idx in resp.daily) {
          let tmp = '<div class="weatherContent">';
          let days = new Date();
          days.setTime(resp.daily[idx].dt * 1000);
          const today = moment(days);
          console.log("날짜 : " + today.format('YYYY-MM-DD'));
          tmp += '<div class="day">' + today.format('MM월 DD일') + '<div>';

          console.log("최고 기온 : " + resp.daily[idx].temp.max);
          tmp += '<div class="Temp">' + Math.floor(resp.daily[idx].temp.min) + '&ordm/' + Math.floor(resp.daily[idx].temp.max) + '&ordm<div>';
          tmp += '<div class="Temp">' + Math.floor(resp.daily[idx].pop*100.0) + '%<div>';
          console.log("최저 기온 : " + resp.daily[idx].temp.min);
          console.log("강수 확률 : " + resp.daily[idx].pop);
          console.log("자외선 지수 : " + resp.daily[idx].uvi);
          console.log("날씨 : " + resp.daily[idx].weather[0].main);
          console.log("상세날씨설명 : " + resp.daily[idx].weather[0].description);
          console.log("바람   : " + resp.daily[idx].wind_speed);
          console.log(resp.daily[idx].weather[0].icon);
          //맑음
          if(resp.daily[idx].weather[0].icon=='01d' || resp.daily[idx].weather[0].icon=='01n'){
            imgURL = '/resources/design/line/animation-ready/clear-day.svg';
          }
          //맑고 구름
          if(resp.daily[idx].weather[0].icon=='02d' || resp.daily[idx].weather[0].icon=='02n'){
            imgURL = '/resources/design/line/animation-ready/partly-cloudy-day.svg';
          }
          //구름
          if(resp.daily[idx].weather[0].icon=='03d' || resp.daily[idx].weather[0].icon=='03n'){
            imgURL = '/resources/design/line/animation-ready/cloudy.svg';
          }
          //먹구름
          if(resp.daily[idx].weather[0].icon=='04d' || resp.daily[idx].weather[0].icon=='04n'){
            imgURL = '/resources/design/line/animation-ready/cloudy.svg';
          }
          //소나기
          if(resp.daily[idx].weather[0].icon=='09d' || resp.daily[idx].weather[0].icon=='09d'){
            imgURL = '/resources/design/line/animation-ready/rain.svg';
          }
          //비
          if(resp.daily[idx].weather[0].icon=='10d' || resp.daily[idx].weather[0].icon=='10n'){
            imgURL = '/resources/design/line/animation-ready/rain.svg';
          }
          //번개
          if(resp.daily[idx].weather[0].icon=='11d' || resp.daily[idx].weather[0].icon=='11n'){
            imgURL = '/resources/design/line/animation-ready/thunderstorms.svg';
          }
          //눈
          if(resp.daily[idx].weather[0].icon=='13d' || resp.daily[idx].weather[0].icon=='13n'){
            imgURL = '/resources/design/line/animation-ready/snow.svg';
          }
          //안개
          if(resp.daily[idx].weather[0].icon=='50d' || resp.daily[idx].weather[0].icon=='50n'){
            imgURL = '/resources/design/line/animation-ready/mist.svg';
          }

        // imgURL = "http://openweathermap.org/img/w/" + resp.daily[idx].weather[0].icon + ".png";
          tmp += '<div class="Icon">' + "<img src=" + imgURL + ">" + '<div>';
          tmp += "</div>"

          $('.weather').append(tmp);
          console.log("=====================================================================================");

        }
      }
    })
    
    
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
  </script>

</body>

</html>