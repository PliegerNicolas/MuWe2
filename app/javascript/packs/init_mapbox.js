import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

let map;
let initUserPos;

const createMap = (pos) => {
  const mapElement = document.getElementById("map"); // Get map element if exists (div)
  if(mapElement) { // If map element on the page (div)
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey; // API token mapbox
    if(pos) {
      map = new mapboxgl.Map({ // Create mapbox map on user location
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10',
        center: [pos.lng, pos.lat],
        zoom: 7
      });
    } else {
      map = new mapboxgl.Map({ // Create mapbox map on default location
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10',
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
    // Ajax Get
    console.log("create ajax get");
    console.log(pos);
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

  }, function(error) { // Fallback method if localisation denied by user
      if (error.code == error.PERMISSION_DENIED)
      createMap(initUserPos);
    }
  );
} else {
  // Construct
}
