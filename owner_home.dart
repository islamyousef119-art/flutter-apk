import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../theme.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});
  @override State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  int tab = 0;
  final pages = const ['الرئيسية','الطلبات','المطاعم','المندوبون','المستخدمون'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Nova Control Center • ${pages[tab]}', style: const TextStyle(fontWeight: FontWeight.w900))),
    body: ListView(padding: const EdgeInsets.fromLTRB(18,8,18,30), children: [
      if (tab == 0) ..._dashboard(),
      if (tab == 1) ..._orders(),
      if (tab == 2) ..._restaurants(),
      if (tab == 3) ..._drivers(),
      if (tab == 4) ..._users(),
    ]),
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (i) => setState(() => tab = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'الطلبات'),
        NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'المطاعم'),
        NavigationDestination(icon: Icon(Icons.two_wheeler_outlined), selectedIcon: Icon(Icons.two_wheeler), label: 'المندوبون'),
        NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'المستخدمون'),
      ],
    ),
  );

  List<Widget> _dashboard() => [
    const Text('لوحة المالك 👑', style: TextStyle(fontSize:28,fontWeight:FontWeight.w900)),
    const SizedBox(height:6), Text('متابعة التشغيل والمبيعات والأداء في مكان واحد', style: TextStyle(color:Colors.grey)),
    const SizedBox(height:18),
    GridView.count(crossAxisCount:2,shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),crossAxisSpacing:10,mainAxisSpacing:10,childAspectRatio:1.35,children:const [
      _Tile('1,248','طلبات اليوم',Icons.receipt_long_rounded), _Tile('86','مطعم نشط',Icons.storefront_rounded),
      _Tile('142','مندوب',Icons.two_wheeler_rounded), _Tile('38,640 ج','مبيعات اليوم',Icons.payments_rounded),
    ]),
    const SizedBox(height:18),
    _section('إجراءات سريعة', [('إضافة مطعم',Icons.add_business_rounded),('إضافة مندوب',Icons.person_add_alt_rounded),('إنشاء كوبون',Icons.local_offer_rounded),('التقارير المالية',Icons.analytics_rounded)]),
  ];

  List<Widget> _orders() => [
    const Text('الطلبات الحالية',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)), const SizedBox(height:14),
    ...List.generate(6,(i)=>Card(child:ListTile(leading:const CircleAvatar(backgroundColor:Color(0x126C4CF1),child:Icon(Icons.receipt_long,color:NovaTheme.primary)),title:Text('NOVA-${2040+i}',style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text(i%3==0?'جاري البحث عن مندوب':i%3==1?'في الطريق':'تم التسليم'),trailing:Text('${150+i*20} ج.م')))),
  ];

  List<Widget> _restaurants() => [
    const Text('إدارة المطاعم',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:14),
    ...AppState.instance.allRestaurants.map((r)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.restaurant_rounded)),title:Text(r.name,style:const TextStyle(fontWeight:FontWeight.w900)),subtitle:Text('${r.category} • ⭐ ${r.rating} • ${r.menu.length} منتجات'),trailing:const Icon(Icons.edit_outlined)))),
  ];

  List<Widget> _drivers() => [
    const Text('المندوبون',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:14),
    ...['محمد أحمد','أحمد علي','محمود حسن','عمر السيد','سيف محمد'].map((n)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.two_wheeler)),title:Text(n,style:const TextStyle(fontWeight:FontWeight.w800)),subtitle:const Text('متاح • 4.8 ★'),trailing:Switch(value:true,onChanged:(_){}}))),
  ];

  List<Widget> _users() => [
    const Text('المستخدمون',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),const SizedBox(height:14),
    ...['أحمد','سارة','محمود','ندى','يوسف'].map((n)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.person)),title:Text(n),subtitle:const Text('عميل • نشط'),trailing:const Icon(Icons.more_vert)))),
  ];

  Widget _section(String title,List<(String,IconData)> actions) => Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900)),const SizedBox(height:10),...actions.map((a)=>Card(child:ListTile(leading:Icon(a.$2,color:NovaTheme.primary),title:Text(a.$1,style:const TextStyle(fontWeight:FontWeight.w800)),trailing:const Icon(Icons.chevron_left))))]);
}

class _Tile extends StatelessWidget {
  final String value,title; final IconData icon;
  const _Tile(this.value,this.title,this.icon);
  @override Widget build(BuildContext context)=>Card(child:Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:NovaTheme.primary,size:28),const Spacer(),Text(value,style:const TextStyle(fontSize:21,fontWeight:FontWeight.w900)),Text(title,style:TextStyle(color:Colors.grey.shade600))])));
}
