import mapboxgl from 'mapbox-gl';
// import 'mapbox-gl/dist/mapbox-gl.css';
import moment from 'moment';

let map;
let initUserPos;

const createMap = (pos) => {
  const mapElement = document.getElementById("map"); // Get map element if exists (div)
  if(mapElement) { // If map element on the page (div)
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey; // API token mapbox
    if(pos) {
      map = new mapboxgl.Map({ // Create mapbox map on user location
        container: 'map',
        style: 'mapbox://styles/aetherys/ck8pnp50b0j4j1jn3mbtr97la',
        center: [pos.lng, pos.lat],
        zoom: 7
      });
    } else {
      map = new mapboxgl.Map({ // Create mapbox map on default location
        container: 'map',
        style: 'mapbox://styles/aetherys/ck8pnp50b0j4j1jn3mbtr97la',
        center: [-7.8536599, 39.557191],
        zoom: 7
      });
    }
  }
}

const saveUserLocation = (pos) => {
  const docCookie = document.cookie
  const cookieValue = docCookie.split("=")[1];
  if(cookieValue == "true") {
    // AJAX get request => save user's location if cookie found
    fetch("/save_location", {
      method: "POST",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        lat: pos.lat,
        lng: pos.lng
      })
    })
  }
}

const parseDate = (time, duration) => {
  let startTime = moment(time);
  let endTime = startTime;
  const jamDuration = moment(duration);
  endTime = endTime.add(jamDuration.format("HH"), "hours").add(jamDuration.format("mm"), "minutes");
  startTime = moment(time);
  return `${startTime.format("HH:mm")} => ${endTime.format("HH:mm")}`
}

const jamsToHTML = (jams) => {
  const jamsBox = document.getElementById("jams");
  jamsBox.innerHTML = '';
  jams.forEach(function(jam) {
    console.log(jam);
    jamsBox.insertAdjacentHTML('beforeend',
      `
        <div class="jam" data-jam-id="${jam.id}">
          <div class="name">${jam.user.first_name}</div>
          <div class="style">${jam.music_style.music_style}</div>
          <div class="status">${jam.status}</div>
          <div class="max_participants">${jam.participants.length}/${jam.max_participants}</div>
          <div class="time">${parseDate(jam.start_date_time, jam.duration)}</div>
        </div>
      `
    );
  });
}

const getJams = () => {
  const mapCenter = map.getCenter();
  const mapBounds = map.getBounds();
  fetch("/search", {
    method: "POST",
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      map_center: mapCenter,
      max_lat: mapBounds._ne.lat,
      min_lat: mapBounds._sw.lat,
      max_lng: mapBounds._ne.lng,
      min_lng: mapBounds._sw.lng
    })
  })
  .then(function(response) {
    return response.json();
  })
  .then(function(data) {
    const jams = data.jams
    jamsToHTML(jams);
  })
}

/* ==================== */
      /*executable*/
/* ==================== */

if("geolocation" in navigator) {
  // geolocation permitted
  navigator.geolocation.getCurrentPosition(function(position) {
    // Setting up variables
    const initUserPos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    }

    // Actions

    saveUserLocation(initUserPos); // Save user location if cookie is there

    createMap(initUserPos);

    const geolocate = new mapboxgl.GeolocateControl({ // Create mapbox geolocate method
      positionOptions: {
        enableHighAccuracy: true
      },
        trackUserLocation: true,
        showAccuracyCircle: false,
      }
    );

    map.addControl(geolocate); // Add geolocate method to map
    map.on('load', () => {
      geolocate.trigger(); // trigger geolocation on page load
    })

    getJams();

  }, function(error) { // Fallback method if localisation denied by user
      if (error.code == error.PERMISSION_DENIED)
      createMap(initUserPos);
    }
  );
} else {
  // Construct
}
