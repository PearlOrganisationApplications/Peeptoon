import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late final GoogleMapController mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyCLmi7d9HhYyDKPMK8qZ-zMU8K9lMzKyh8";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(30.3461374, 77.918174);
  LatLng endLocation = LatLng(30.2870, 77.9983);

  ///************** Function For Enable Permission, Get Current location ***************///
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ///********* Permissions are denied, next time you could try
        ///********* requesting permissions again (this is also where
        ///********* Android's shouldShowRequestPermissionRationale
        ///********* returned true. According to Android guidelines
        ///********* your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ///*********** Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    ///********** When we reach here, permissions are granted and we can
    ///********** continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      startLocation = LatLng(position.latitude, position.longitude);
      // endLocation = LatLng(position.latitude, position.longitude);
      // otherLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Order Tracking")),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: GoogleMap(
        compassEnabled: true,

        myLocationButtonEnabled: true,
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true,
        //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: startLocation, //initial position
          zoom: 16.0, //initial zoom level
        ),
        markers: markers,
        //markers to show on map
        polylines: Set<Polyline>.of(polylines.values),
        //polylines
        mapType: MapType.normal,
        //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 56.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _goToCurrentLocation,
          // label: const Text(""),
          child: Icon(
            Icons.center_focus_strong_rounded,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }

  Future<void> _goToCurrentLocation() async {
    await _determinePosition();

    final GoogleMapController controller = await mapController;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: startLocation, zoom: 15),
      ),
    );
  }
}
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class OrderTrackingScreen extends StatefulWidget {
//   const OrderTrackingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OrderTrackingScreen> createState() => OrderTrackingScreenState();
// }
//
// class OrderTrackingScreenState extends State<OrderTrackingScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//
//   // TextEditingController _searchController = TextEditingController();
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   //***  Google Map Marker
//   static final Marker _kGooglemapMarker = Marker(
//       markerId: MarkerId("_kGooglePlex"),
//       infoWindow: InfoWindow(title: "Pearl Organisation"),
//       icon: BitmapDescriptor.defaultMarker,
//       position: LatLng(37.42796133580664, -122.085749655962));
//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   //***  Google Map Marker
//   static final Marker _kHomeMarker = Marker(
//     markerId: MarkerId(" _kHomeMarker"),
//     infoWindow: InfoWindow(title: "Home Marker"),
//     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//     position: LatLng(37.43296265331129, -122.08832357078792),
//   );
//
//   //*** Create Polyline In Google Map
//
//   static final Polyline _kPolyline = Polyline(
//       polylineId: PolylineId("_kPolyline"),
//       points: [
//         LatLng(37.43296265331129, -122.08832357078792),
//         LatLng(37.42796133580664, -122.085749655962),
//       ],
//       width: 5);
//
//   //*** Create Polygons In Google Map
//
//   static final Polygon _kPolygons = Polygon(
//       polygonId: PolygonId("_kPolygons"),
//       points: [
//         LatLng(37.43296265331129, -122.08832357078792),
//         LatLng(37.42796133580664, -122.085749655962),
//         LatLng(37.418, -122.092),
//         LatLng(37.435, -122.092),
//       ],
//       strokeWidth: 5,
//       fillColor: Colors.transparent);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text("Order Tracking"),
//       ),
//       body: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               // Expanded(
//               //     child: TextFormField(
//               //   // controller: _searchController,
//               //   textCapitalization: TextCapitalization.words,
//               //   decoration: InputDecoration(hintText: "Search Your City"),
//               //   onChanged: (value) {
//               //     print(value);
//               //   },
//               // )),
//               // IconButton(
//               //     onPressed: () {
//               //       // LocationServices().getPlaceId(_searchController.text);
//               //     },
//               //     icon: Icon(EvaIcons.search))
//             ],
//           ),
//           Expanded(
//             child: GoogleMap(
//               polylines: {_kPolyline},
//               polygons: {_kPolygons},
//               markers: {
//                 _kGooglemapMarker,
//                 _kHomeMarker,
//               },
//               mapType: MapType.normal,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: const Text('To the lake!'),
//         icon: const Icon(Icons.directions_boat),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     print("Show Map ID=======>>>>>>");
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
