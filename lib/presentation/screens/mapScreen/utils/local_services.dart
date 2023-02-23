import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class LocationServices {
  final String key = 'AIzaSyDU6Irn61yrq4TvWOvYKdU4gCn74jqbDVI';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print("Candidate ======>>>> " + placeId);
    return placeId;
  }
}
