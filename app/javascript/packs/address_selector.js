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

    createMap(initUserPos);

    map.on('click', function(event) {
      var clickCoords = event.lngLat;
      console.log(clickCoords);
    });

  }, function(error) { // Fallback method if localisation denied by user
      if (error.code == error.PERMISSION_DENIED)
      createMap(initUserPos);
    }
  );
} else {
  // Construct
}
