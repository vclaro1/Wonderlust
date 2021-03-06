function initialize(array) {
    var googl         = google.maps;
        mapp         = new googl.Map(document.getElementById('map'),
                                  {
                                    center  : new googl.LatLng(52.52, 13.40),
                                    zoom    : 10
                                  }
                                 );
    var DirectionsDisp = [];
    for (i = array.length - 2; i >= 0; i--) {
      DirectionsDisp.push(new googl.DirectionsRenderer({
                                          map             : mapp,
                                          preserveViewport: true,
                                          suppressMarkers : true,
                                          polylineOptions : {strokeColor:'blue'},
                                          //panel           : document.getElementById('panel').appendChild(document.createElement('li'))
                                        }));};

    App         = { map               : mapp,
                    bounds            : new googl.LatLngBounds(),
                    directionsService : new googl.DirectionsService(),    
                    directionsDisplays: DirectionsDisp};

    for (i = 0; i <= DirectionsDisp.length - 1; i++) {
        if (array[i+1][2] == "FLIGHT") {
              var flightPlanCoordinates = [{lat: array[i][0], lng: array[i][1]},
                                          {lat: array[i+1][0], lng: array[i+1][1]}];
              var flightPath = new google.maps.Polyline({path: flightPlanCoordinates,
                                             geodesic: true,
                                             title:"Avion",
                                             strokeColor: '#FF0008',
                                             strokeOpacity: 1.0,
                                             strokeWeight: 2});
              flightPath.setMap(mapp);
        } else {
            var travel;
            if (array[i+1][2] == "WALKING") {
              travel = googl.TravelMode.WALKING;
            } else if (array[i+1][2] == "BICYCLING") {
              travel = googl.TravelMode.BICYCLING;
            } else if (array[i+1][2] == "TRANSIT") {
              travel = googl.TravelMode.TRANSIT;
            } else {
              travel = googl.TravelMode.DRIVING;
            }
            hola1 = {  origin     : {lat: array[i][0], lng: array[i][1]},
                        destination :  {lat: array[i+1][0], lng: array[i+1][1]},
                        travelMode  :  travel}
            App.directionsService.route(hola1, function(result, status) {
              if (status == google.maps.DirectionsStatus.OK) {
                App.directionsDisplays[i].setDirections(result);
                App.map.fitBounds(App.bounds.union(result.routes[0].bounds));
              }
          });
        }
    }
}
google.maps.event.addDomListener(window, 'load', initialize);