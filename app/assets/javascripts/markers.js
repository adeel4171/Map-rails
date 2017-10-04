// var geocoder;
// var map;
// var marker;
// var infowindow
// var flag = 0 
// var positionArray = []
// var directionsDisplay;
// var directionsService = new google.maps.DirectionsService();

// function gmaps_init(){

//   var latlng = new google.maps.LatLng(51.751724,-1.255284);

//   var options = {
//     zoom: 2,
//     center: latlng,
//     mapTypeId: google.maps.MapTypeId.ROADMAP
//   };
//   map = new google.maps.Map(document.getElementById("gmaps-canvas"), options);
//   directionsDisplay = new google.maps.DirectionsRenderer();
//   directionsDisplay.setMap(map);

//   geocoder = new google.maps.Geocoder();

//   marker = new google.maps.Marker({
//     map: map,
//     draggable: true
//   });

//   // event triggered when marker is dragged and dropped
//   google.maps.event.addListener(marker, 'dragend', function() {
//     geocode_lookup( 'latLng', marker.getPosition() );
   
//   });

//   // event triggered when map is clicked
//   google.maps.event.addListener(map, 'click', function(event) {
//     marker.setPosition(event.latLng)
//     geocode_lookup( 'latLng', event.latLng);
//   });

//   $('#gmaps-error').hide();
// }




// function calcRoute(latitude1,longitude1,latitude2,longitude2) {
//     //var start = new google.maps.LatLng(37.334818, -121.884886);
//     //var end = new google.maps.LatLng(38.334818, -181.884886);
//     //var end = new google.maps.LatLng(37.441883, -122.143019);
//     var start = new google.maps.LatLng(latitude1, longitude1);
//     var end = new google.maps.LatLng(latitude2, longitude2);
//     var request = {
//       origin: start,
//       destination: end,
//       travelMode: google.maps.TravelMode.DRIVING
//     };
//     directionsService.route(request, function(response, status) {
//       if (status == google.maps.DirectionsStatus.OK) {
//         directionsDisplay.setDirections(response);
//         directionsDisplay.setMap(map);
//       } else {
//         alert("Directions Request from " + start.toUrlValue(6) + " to " + end.toUrlValue(6) + " failed: " + status);
//       }
//     });
//   }

// function fetchLocations(a,b,c,d)
// {
// 	calcRoute(a,b,c,d);

// }



// // function setZoom(){
// //     google.maps.event.addListener(map, 'zoom_changed', function() {
// //     zoomChangeBoundsListener = 
// //         google.maps.event.addListener(map, 'bounds_changed', function(event) {
// //             if (this.getZoom() > 15 && this.initialZoom == true) {
// //                 // Change max/min zoom here
// //                 this.setZoom(15);
// //                 this.initialZoom = false;
// //             }
// //             google.maps.event.removeListener(zoomChangeBoundsListener);
// //         });
// //     });
// //     map.initialZoom = true;
// // }

// function convertLocationToLatLong(location){
//     var location = location.split(',').map(function(item) {
//         return parseFloat(item);
//     });
//     return location
// }

// // function plotMap(location1,location2){
// //     var location1 = new google.maps.LatLng(location1[0],location1[1]);
// //     if (location2){
// //         var location2 = new google.maps.LatLng(location2[0],location2[1]);      
// //     }
// //     var bounds = new google.maps.LatLngBounds();
// //     bounds.extend(location1);
// //     if(location2){
// //         bounds.extend(location2);    
// //     }
// //     map.fitBounds(bounds);       
// //     setZoom();
// // }

// function update_map( geometry ) {

//   map.fitBounds( geometry.viewport )
//   marker = new google.maps.Marker({
//     map: map,
//     draggable: true
//   });
//   positionArray.push(geometry.location);
//   marker.setPosition( geometry.location )
//   console.log('Array', positionArray);
 
//   if (positionArray.length > 1)
//   {
  	
//   	console.log('Geometry Location', geometry.location);
//   	//alert(google.maps.geometry.spherical.computeDistanceBetween(positionArray[0], positionArray[1]) / 1000);
//   	var route = [
//                     positionArray[0],
//                     positionArray[1]
//                 ];

//   	var polyline = new google.maps.Polyline({
//         path: route,
//         strokeColor: "#FF5E56",
//         strokeOpacity: 0.6,
//         strokeWeight: 5
//     });
//     location1 = convertLocationToLatLong(positionArray[0].toUrlValue())
//     location2 = convertLocationToLatLong(positionArray[1].toUrlValue())

//     document.getElementById('location-latitude1').value = location1[0];
//     document.getElementById('location-longitude1').value = location1[1];
//     document.getElementById('location-latitude2').value = location2[0];
//     document.getElementById('location-longitude2').value = location2[1];
//     document.getElementById('location-from').value = document.getElementById('gmaps-input-address-from').value;
//     document.getElementById('location-to').value = document.getElementById('gmaps-input-address-to').value;





//     var lengthInMeters = google.maps.geometry.spherical.computeLength(polyline.getPath());
//    //document.getElementById('results').innerHTML += "Polyline is "+lengthInMeters+" meters long<br>";
//  	calcRoute(location1[0],location1[1],location2[0],location2[1]);

//     //polyline.setMap(map);
//     //plotMap(location2,location1);

//   }
  	
// }

// function update_ui( address, latLng ) {
  
//   if (flag === 0)
//   {
//   	$('#gmaps-input-address-from').autocomplete("close");
//   	$('#gmaps-input-address-from').val(address);
//   }
//   else
//   {
//   	$('#gmaps-input-address-to').autocomplete("close");
//   	$('#gmaps-input-address-to').val(address);
//   } 
  
//   //$('#gmaps-output-latitude').html(latLng.lat());
//   //$('#gmaps-output-longitude').html(latLng.lng());

// }

// function geocode_lookup( type, value, update ) {
 
//   update = typeof update !== 'undefined' ? update : false;

//   request = {};
//   request[type] = value;

//   geocoder.geocode(request, function(results, status) {
//     $('#gmaps-error').html('');
//     $('#gmaps-error').hide();
//     if (status == google.maps.GeocoderStatus.OK) {
//       if (results[0]) {
//         update_ui( results[0].formatted_address,
//                    results[0].geometry.location )
//         if( update ) { update_map( results[0].geometry ) }
//       } else {
//         $('#gmaps-error').html("Sorry, something went wrong. Try again!");
//         $('#gmaps-error').show();
//       }
//     } else {

//       if( type == 'address' ) {
//         $('#gmaps-error').html("Sorry! We couldn't find " + value + ". Try a different search term, or click the map." );
//         $('#gmaps-error').show();
//       } else {
//         $('#gmaps-error').html("Woah... that's pretty remote! You're going to have to manually enter a place name." );
//         $('#gmaps-error').show();
//         update_ui('', value)
//       }
//     };
//   });
// };

// // initialise the jqueryUI autocomplete element
// function autocomplete_init() {
//   $("#gmaps-input-address-from").autocomplete({

//     source: function(request,response) {
//       geocoder.geocode( {'address': request.term }, function(results, status) {
//         response($.map(results, function(item) {
//           return {
//             label: item.formatted_address, 
//             value: item.formatted_address, 
//             geocode: item
//           }
//         }));
//       })
//     },

//     // event triggered when drop-down option selected
//     select: function(event,ui){
//       update_ui(  ui.item.value, ui.item.geocode.geometry.location )
//       update_map( ui.item.geocode.geometry )
//     }
//   });

//   $("#gmaps-input-address-to").autocomplete({

//     source: function(request,response) {

//       geocoder.geocode( {'address': request.term }, function(results, status) {
//         response($.map(results, function(item) {
//           return {
//             label: item.formatted_address, 
//             value: item.formatted_address, 
//             geocode: item
//           }
//         }));
//       })
//     },

//     // event triggered when drop-down option selected
//     select: function(event,ui){
//       update_ui(  ui.item.value, ui.item.geocode.geometry.location )
//       update_map( ui.item.geocode.geometry )
//     }
//   });

//   $("#gmaps-input-address-from").bind('keydown', function(event) {
//   		flag=0;
//     if(event.keyCode == 13) {
//       geocode_lookup( 'address', $('#gmaps-input-address-from').val(), true );

//       // ensures dropdown disappears when enter is pressed
//       $('#gmaps-input-address-from').autocomplete("disable")
//     } else {
//       // re-enable if previously disabled above
//       $('#gmaps-input-address-from').autocomplete("enable")
//     }
//   });

//    $("#gmaps-input-address-to").bind('keydown', function(event) {
//     flag = 1
//     if(event.keyCode == 13) {
//       geocode_lookup( 'address', $('#gmaps-input-address-to').val(), true );

//       $('#gmaps-input-address-to').autocomplete("disable")
//     } else {
//        $('#gmaps-input-address-to').autocomplete("enable")
//     }
//   });

// }; 

// $(document).ready(function() { 
//   if( $('#gmaps-canvas').length  ) {
//     gmaps_init();
//     autocomplete_init();
//   }; 
// });