import '../models/catalog.dart';

class DemoData {
  static const restaurants = <Restaurant>[
    Restaurant(id:'r1',name:'Nova Burger',category:'برجر',address:'شارع الجمهورية - ميت غمر',image:'',rating:4.8,deliveryFee:15,eta:25,menu:[
      MenuItem(id:'m1',name:'Nova Beef Burger',description:'برجر لحم مع جبنة وصوص نوفا',price:145),
      MenuItem(id:'m2',name:'Chicken Crispy',description:'دجاج كريسبي وصوص خاص',price:130),
      MenuItem(id:'m3',name:'Loaded Fries',description:'بطاطس بصوص الجبنة',price:55),
    ]),
    Restaurant(id:'r2',name:'Pizza Nova',category:'بيتزا',address:'شارع الجيش - ميت غمر',image:'',rating:4.7,deliveryFee:18,eta:30,menu:[
      MenuItem(id:'m4',name:'Margherita',description:'طماطم وموتزاريلا وريحان',price:180),
      MenuItem(id:'m5',name:'Chicken Ranch',description:'فراخ ورانش وموتزاريلا',price:220),
      MenuItem(id:'m6',name:'Garlic Bread',description:'خبز بالثوم والجبنة',price:65),
    ]),
    Restaurant(id:'r3',name:'Sweet Nova',category:'حلويات',address:'شارع التحرير - ميت غمر',image:'',rating:4.9,deliveryFee:12,eta:20,menu:[
      MenuItem(id:'m7',name:'Nutella Crepe',description:'كريب نوتيلا وفراولة',price:95),
      MenuItem(id:'m8',name:'Waffle Box',description:'وافل مع صوصات متنوعة',price:110),
    ]),
    Restaurant(id:'r4',name:'Nova Mix',category:'شرقي',address:'الموقف الجديد - ميت غمر',image:'',rating:4.6,deliveryFee:10,eta:22,menu:[
      MenuItem(id:'m9',name:'كشري كبير',description:'كشري مصري كامل',price:75),
      MenuItem(id:'m10',name:'حواوشي',description:'رغيف حواوشي طازج',price:90),
    ]),
  ];
}
