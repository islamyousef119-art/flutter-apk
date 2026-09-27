import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme.dart';
import '../services/directions_service.dart';

class MapPanel extends StatefulWidget {
  final LatLng restaurant, customer; final LatLng? driver; final double height;
  const MapPanel({super.key,required this.restaurant,required this.customer,this.driver,this.height=310});
  @override State<MapPanel> createState()=>_MapPanelState();
}
class _MapPanelState extends State<MapPanel>{List<LatLng>? route;@override void initState(){super.initState();_load();}Future<void> _load()async{final start=widget.driver??widget.restaurant;final points=await DirectionsService.route(start,widget.customer);if(mounted)setState(()=>route=points);}
@override Widget build(BuildContext context){final markers=<Marker>{Marker(markerId:const MarkerId('restaurant'),position:widget.restaurant,infoWindow:const InfoWindow(title:'المطعم')),Marker(markerId:const MarkerId('customer'),position:widget.customer,infoWindow:const InfoWindow(title:'العميل')),if(widget.driver!=null)Marker(markerId:const MarkerId('driver'),position:widget.driver!,infoWindow:const InfoWindow(title:'المندوب'))};final points=route??[widget.driver??widget.restaurant,widget.customer];final lines=<Polyline>{Polyline(polylineId:const PolylineId('delivery_route'),points:points,width:6,color:NovaTheme.primary)};final center=LatLng((widget.restaurant.latitude+widget.customer.latitude)/2,(widget.restaurant.longitude+widget.customer.longitude)/2);return ClipRRect(borderRadius:BorderRadius.circular(28),child:SizedBox(height:widget.height,child:GoogleMap(initialCameraPosition:CameraPosition(target:center,zoom:12.5),markers:markers,polylines:lines,myLocationEnabled:true,myLocationButtonEnabled:true,zoomControlsEnabled:false,compassEnabled:false)));}}
