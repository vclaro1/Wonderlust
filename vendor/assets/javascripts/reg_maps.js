      $(function(){
        
        var options = {
          map: ".map_canvas",
          location: "Chile"
        };
        
        $("#geocomplete").geocomplete(options);
        
      });
        $(function(){
        
        $("#geocomplete").geocomplete()
          .bind("geocode:result", function(event, result){
            resultado = JSON.stringify(result.geometry.location).split(",");
            lat = parseFloat(resultado[0].split(":")[1]);
            lng = parseFloat(resultado[1].split(":")[1].slice(0,-1));
            name = result.formatted_address
            $(document).ready(function(){
              $("#name_field").val(name)
              $("#lat_field").val(lat)
              $("#long_field"),val(lng)
            });
          })
          .bind("geocode:error", function(event, status){
            $.log("ERROR: " + status);
          })
          .bind("geocode:multiple", function(event, results){
            $.log("Multiple: " + results.length + " results found");
          });
        
        $("#find").click(function(){
          $("#geocomplete").trigger("geocode");
        });
        
        
        $("#examples a").click(function(){
          $("#geocomplete").val($(this).text()).trigger("geocode");
          return false;
        });
        
      });