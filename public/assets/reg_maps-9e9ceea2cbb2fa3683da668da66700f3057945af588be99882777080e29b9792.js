$(document).ready(function() {
     var options = {
      map: "#map",
      mapOptions: {
        streetViewControl: false,
      },
      markerOptions: {
        draggable: true
      }
    };
    $(".location").geocomplete(options).bind("geocode:result", function(event, result){
       //get the value of the result
      $('.latitude').val(result.geometry.location.k);
      $('.longitude').val(result.geometry.location.B);
      var map = $(".location").geocomplete("map");
      map.setZoom(18);
      map.setCenter(result.geometry.location);
    });
       $(".location").bind("geocode:dragged", function(event, latLng){
      var map = $(".location").geocomplete("map");
        map.panTo(latLng);
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({'latLng': latLng }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          if (results[0]) {
            $('#name_field').val(results[0].formatted_address);
            $('#long_field').val(results[0].geometry.location.k);
            $('#lat_field').val(results[0].geometry.location.B);
          }
        }
      });
    });
  });
