import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static const apiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  static Future<List<LatLng>> route(LatLng origin, LatLng destination) async {
    if (apiKey.isEmpty) return [origin, destination];
    final uri = Uri.parse('https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode != 200) return [origin, destination];
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = json['routes'] as List?;
    if (routes == null || routes.isEmpty) return [origin, destination];
    final encoded = (routes.first as Map<String,dynamic>)['overview_polyline']?['points'] as String?;
    if (encoded == null) return [origin, destination];
    return _decode(encoded);
  }
  static List<LatLng> _decode(String encoded) {
    final points=<LatLng>[];int index=0,lat=0,lng=0;
    while(index<encoded.length){int shift=0,result=0;int b;do{b=encoded.codeUnitAt(index++)-63;result|=(b&0x1f)<<shift;shift+=5;}while(b>=0x20);lat+=((result&1)!=0?~(result>>1):(result>>1));shift=0;result=0;do{b=encoded.codeUnitAt(index++)-63;result|=(b&0x1f)<<shift;shift+=5;}while(b>=0x20);lng+=((result&1)!=0?~(result>>1):(result>>1));points.add(LatLng(lat/1e5,lng/1e5));}
    return points;
  }
}
