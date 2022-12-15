import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

  final  Completer<GoogleMapController>_completer=Completer();
   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
   static const LatLng  destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
