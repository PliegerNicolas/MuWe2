import mapboxgl from 'mapbox-gl';
// import 'mapbox-gl/dist/mapbox-gl.css';

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
        zoom: 7,
        minZoom: 4,
        maxPitch: 0
      });
    } else {
      map = new mapboxgl.Map({ // Create mapbox map on default location
        container: 'map',
        style: 'mapbox://styles/aetherys/ck8pnp50b0j4j1jn3mbtr97la',
        center: [-7.8536599, 39.557191],
        zoom: 7,
        minZoom: 4,
        maxPitch: 0
      });
    }
  }
}

const saveUserLocation = (pos) => {
  const docCookie = document.cookie
  const cookieValue = docCookie.split("=")[1];
  if(cookieValue == "true") {
    // AJAX get request => save user's location if cookie found
    const token = document.getElementsByName("csrf-token")[0].content
    fetch("/save_location", {
      method: "POST",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({
        lat: pos.lat,
        lng: pos.lng
      })
    })
  }
}

const setMarkers = (markers_pos) => {
  markers_pos.forEach((marker_pos) => {
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url(${marker_pos.marker_image})`
    element.style.backgroundSize = 'contain';
    element.style.width = '20px';
    element.style.height = '20px';

    let marker = new mapboxgl.Marker(element)
    .setLngLat([marker_pos.lng, marker_pos.lat])
    .addTo(map);
  })
}

const filter = () => {
  const filter_button = document.getElementById("filter_button");
  filter_button.addEventListener("click", function() {
    getJams();
  });
}

const getJams = () => {
  const mapCenter = map.getCenter();
  const mapBounds = map.getBounds();
  const token = document.getElementsByName("csrf-token")[0].content
  fetch(window.location.origin + "/search", {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({
      map_center: mapCenter,
      max_lat: mapBounds._ne.lat,
      min_lat: mapBounds._sw.lat,
      max_lng: mapBounds._ne.lng,
      min_lng: mapBounds._sw.lng,
      filter : {
        periode: document.querySelector("#filter_periode").value,
        start_time: document.querySelector("#filter_start_time").value,
        end_time: document.querySelector("#filter_end_time").value,
        max_players: document.querySelector("#filter_max_players").value,
        status: document.querySelector("#filter_status").value
      }
    }),
    credentials: "same-origin"
  })
  .then(function(response) {
    return response.json();
  })
  .then(function(data) {
    document.getElementById("jams").innerHTML = data.jams;
    setMarkers(data.jam_coords);
    flyToCity(data.city_coords);
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

    map.on('moveend', () => {
      getJams();
    })

    filter();

  }, function(error) { // Fallback method if localisation denied by user
      if (error.code == error.PERMISSION_DENIED)
      createMap(initUserPos);
    }
  );
} else {
  // Construct
}
