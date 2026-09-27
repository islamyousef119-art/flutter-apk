import 'package:flutter/material.dart';
import '../models/catalog.dart';
import '../models/order.dart';
import '../services/app_state.dart';
import '../theme.dart';
import '../widgets/nova_header.dart';
import 'order_tracking.dart';
import 'restaurant_menu.dart';
import 'cart_screen.dart';

class CustomerHome extends StatefulWidget { const CustomerHome({super.key}); @override State<CustomerHome> createState()=>_CustomerHomeState(); }
class _CustomerHomeState extends State<CustomerHome> {
  final state=AppState.instance; String category='الكل'; String query='';
  @override void initState(){super.initState(); state.addListener(_refresh);}
  @override void dispose(){state.removeListener(_refresh);super.dispose();}
  void _refresh(){if(mounted)setState((){});}
  @override Widget build(BuildContext context){
    final categories=['الكل','برجر','بيتزا','حلويات','شرقي'];
    final list=state.allRestaurants.where((r)=>(category=='الكل'||r.category==category)&&(query.isEmpty||r.name.contains(query)||r.category.contains(query))).toList();
    return Scaffold(appBar:AppBar(title:const Text('نوفا',style:TextStyle(fontWeight:FontWeight.w900)),actions:[IconButton(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('الإشعارات جاهزة للربط بـ FCM'))),icon:const Icon(Icons.notifications_none_rounded)),IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const CartScreen())),icon:Badge(label:Text('${state.itemCount}'),isLabelVisible:state.itemCount>0,child:const Icon(Icons.shopping_bag_outlined))) ]),
      body:ListView(padding:const EdgeInsets.fromLTRB(18,8,18,32),children:[
        const NovaHeader(title:'أهلاً بيك 👋',subtitle:'اطلب أكلك المفضل بسرعة ومن غير وجع دماغ'),const SizedBox(height:18),
        TextField(onChanged:(v)=>setState(()=>query=v),decoration:const InputDecoration(hintText:'ابحث عن مطعم أو وجبة...',prefixIcon:Icon(Icons.search_rounded))),const SizedBox(height:16),
        SizedBox(height:48,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:categories.length,separatorBuilder:(_,__)=>const SizedBox(width:8),itemBuilder:(_,i){final c=categories[i];return ChoiceChip(label:Text(c),selected:category==c,onSelected:(_)=>setState(()=>category=c));})),
        const SizedBox(height:18),
        if(state.activeOrder!=null) _ActiveOrder(order:state.activeOrder!),
        if(state.activeOrder!=null) const SizedBox(height:18),
        const Text('مطاعم قريبة منك',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900)),const SizedBox(height:12),
        ...list.map((r)=>_RestaurantCard(restaurant:r)),
      ]));
  }
}
class _RestaurantCard extends StatelessWidget{final Restaurant restaurant;const _RestaurantCard({required this.restaurant});@override Widget build(BuildContext context){final s=AppState.instance;return Card(margin:const EdgeInsets.only(bottom:13),child:InkWell(borderRadius:BorderRadius.circular(24),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>RestaurantMenu(restaurant:restaurant))),child:Padding(padding:const EdgeInsets.all(15),child:Row(children:[Container(width:78,height:78,decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),gradient:const LinearGradient(colors:[Color(0xFFECE7FF),Color(0xFFDDFBF6)])),child:Icon(restaurant.category=='بيتزا'?Icons.local_pizza_rounded:restaurant.category=='حلويات'?Icons.cake_rounded:Icons.restaurant_rounded,color:NovaTheme.primary,size:36)),const SizedBox(width:13),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(restaurant.name,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(restaurant.category+' • '+restaurant.address,style:TextStyle(color:Colors.grey.shade600,fontSize:12),maxLines:1,overflow:TextOverflow.ellipsis),const SizedBox(height:8),Row(children:[const Icon(Icons.star_rounded,size:17,color:NovaTheme.accent),Text(' ${restaurant.rating}'),const SizedBox(width:12),const Icon(Icons.timer_outlined,size:16),Text(' ${restaurant.eta} دقيقة'),const Spacer(),IconButton(onPressed:()=>s.toggleFavorite(restaurant.id),icon:Icon(s.favorites.contains(restaurant.id)?Icons.favorite_rounded:Icons.favorite_border_rounded,color:s.favorites.contains(restaurant.id)?Colors.red:null))])]))])));}}
class _ActiveOrder extends StatelessWidget{final DeliveryOrder order;const _ActiveOrder({required this.order});@override Widget build(BuildContext context){return Card(color:const Color(0xFFEDEAFF),child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[const Icon(Icons.delivery_dining_rounded,color:NovaTheme.primary),const SizedBox(width:8),Expanded(child:Text('طلبك من ${order.restaurantName}',style:const TextStyle(fontWeight:FontWeight.w900,fontSize:17))),Text('#${order.id}')]),const SizedBox(height:8),Text(_status(order.status)),const SizedBox(height:10),FilledButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>OrderTracking(order:order))),child:const Text('تتبع الطلب'))]));}String _status(OrderStatus s)=>switch(s){OrderStatus.pending=>'جاري البحث عن مندوب',OrderStatus.accepted=>'تم قبول الطلب',OrderStatus.pickedUp=>'المندوب استلم الطلب',OrderStatus.onTheWay=>'المندوب في الطريق إليك',OrderStatus.delivered=>'تم التسليم',OrderStatus.cancelled=>'تم إلغاء الطلب'};}
