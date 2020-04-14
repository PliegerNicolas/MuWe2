import mapboxgl from 'mapbox-gl';
// import 'mapbox-gl/dist/mapbox-gl.css';

let map;
let initUserPos;
let userPos;

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

const clearMarkers = () => {
  const old_markers = Array.from(document.getElementsByClassName("marker"));
  old_markers.forEach((old_marker) => {
    old_marker.remove();
  })
}

const setMarkers = (markers_pos) => {
  clearMarkers();
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

const userData = (data) => {
  const user_count = document.getElementById("user-count");
  const city = document.getElementById("city");
  const user_plural = document.getElementById("user-plural");
  user_count.innerHTML = data.online_users;
  city.innerHTML = data.city;
  if (data.online_users > 1) {
    user_plural.innerHTML = 'Users';
  } else {
    user_plural.innerHTML = 'User';
  }

}

const flyToCity = (city_coords) => {
  if(city_coords) {
    map.flyTo({
      center: city_coords,
      essential: true
    })
    const city_input = document.querySelector("#filter-city");
    const city = city_input.value;
    city_input.value = '';
    city_input.placeholder = city;
  }
}

const filter = () => {
  const filter_button = document.getElementById("filter-button");
  filter_button.addEventListener("click", function() {
    getJams();
  });
}

const getUserData = () => {
  const token = document.getElementsByName("csrf-token")[0].content
  fetch(window.location.origin + "/local_data", {
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({
      user_pos: userPos,
    }),
    credentials: "same-origin"
  })
  .then(function(response) {
    return response.json();
  })
  .then(function(data) {
    userData(data);
  })
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
      user_pos: userPos,
      map_center: mapCenter,
      max_lat: mapBounds._ne.lat,
      min_lat: mapBounds._sw.lat,
      max_lng: mapBounds._ne.lng,
      min_lng: mapBounds._sw.lng,
      filter : {
        city: document.querySelector("#filter-city").value,
        periode: document.querySelector("#filter-periode").value,
        start_time: document.querySelector("#filter-start-time").value,
        end_time: document.querySelector("#filter-end-time").value,
        max_participants: document.querySelector("#filter-max-participants").value,
        status: document.querySelector("#filter-status").value
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

    geolocate.on('geolocate', function(event) {
      userPos = { lng: event.coords.longitude, lat: event.coords.latitude }
      getUserData(userPos);
    })

    map.on('dragend', () => {
      getJams();
    })
    map.on('zoomend', () => {
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
