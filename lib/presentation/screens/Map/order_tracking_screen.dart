import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => OrderTrackingScreenState();
}

class OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // TextEditingController _searchController = TextEditingController();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //***  Google Map Marker
  static final Marker _kGooglemapMarker = Marker(
      markerId: MarkerId("_kGooglePlex"),
      infoWindow: InfoWindow(title: "Pearl Organisation"),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(37.42796133580664, -122.085749655962));
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  //***  Google Map Marker
  static final Marker _kHomeMarker = Marker(
    markerId: MarkerId(" _kHomeMarker"),
    infoWindow: InfoWindow(title: "Home Marker"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: LatLng(37.43296265331129, -122.08832357078792),
  );

  //*** Create Polyline In Google Map

  static final Polyline _kPolyline = Polyline(
      polylineId: PolylineId("_kPolyline"),
      points: [
        LatLng(37.43296265331129, -122.08832357078792),
        LatLng(37.42796133580664, -122.085749655962),
      ],
      width: 5);

  //*** Create Polygons In Google Map

  static final Polygon _kPolygons = Polygon(
      polygonId: PolygonId("_kPolygons"),
      points: [
        LatLng(37.43296265331129, -122.08832357078792),
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.418, -122.092),
        LatLng(37.435, -122.092),
      ],
      strokeWidth: 5,
      fillColor: Colors.transparent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text("Order Tracking"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Expanded(
              //     child: TextFormField(
              //   // controller: _searchController,
              //   textCapitalization: TextCapitalization.words,
              //   decoration: InputDecoration(hintText: "Search Your City"),
              //   onChanged: (value) {
              //     print(value);
              //   },
              // )),
              // IconButton(
              //     onPressed: () {
              //       // LocationServices().getPlaceId(_searchController.text);
              //     },
              //     icon: Icon(EvaIcons.search))
            ],
          ),
          Expanded(
            child: GoogleMap(
              polylines: {_kPolyline},
              polygons: {_kPolygons},
              markers: {
                _kGooglemapMarker,
                _kHomeMarker,
              },
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    print("Show Map ID=======>>>>>>");
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
