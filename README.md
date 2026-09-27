# توصيل أسرع مع نوفا 🚀

مشروع Flutter عربي RTL لتطبيق توصيل متعدد الأدوار: عميل + مندوب + مالك.

## الموجود في النسخة الحالية
- شاشة اختيار الدور.
- تسجيل دخول بالبريد + تسجيل Google عند إعداد Firebase.
- وضع تجربة سريع بدون حساب.
- واجهة عميل: بحث، تصنيفات، مطاعم، مفضلة، منيو، سلة، عنوان توصيل، إنشاء طلب، تتبع.
- واجهة مندوب: online/offline، عروض طلبات، قبول/رفض، رحلة الطلب ومراحلها.
- منطق backend جاهز لقبول أول مندوب باستخدام Firestore transaction.
- لوحة مالك: مؤشرات، طلبات، مطاعم، مندوبون، مستخدمون، إجراءات تشغيل.
- Google Maps + نقاط المطعم/العميل/المندوب.
- مسار قيادة حقيقي عند توفير Google Directions API key، مع fallback للخط المباشر في وضع عدم وجود المفتاح.
- Firebase Cloud Messaging scaffold للإشعارات.
- Firestore security rules للأدوار والطلبات والمواقع.
- RTL وMaterial 3 وهوية Nova.

## تشغيل حقيقي
1. ثبّت Flutter 3.29+ وAndroid SDK.
2. داخل المشروع شغّل `flutter pub get`.
3. شغّل `flutterfire configure` لإضافة `firebase_options.dart` وربط Firebase.
4. فعّل Email/Password وGoogle وCloud Firestore وCloud Messaging.
5. أنشئ Custom Claims للأدوار: `customer`, `driver`, `owner`.
6. أضف Google Maps Android API key في إعدادات Android، وفعّل Maps SDK for Android + Directions API.
7. للتوجيه داخل التطبيق شغّل البناء مع `--dart-define=GOOGLE_MAPS_API_KEY=YOUR_KEY`.
8. انشر `firestore.rules`.

## ملاحظة مهمة
النسخة الحالية تحتوي على Demo Mode كامل للواجهات والمنطق الأساسي حتى يمكن تجربة التطبيق قبل إدخال مفاتيح Firebase/Google. لم يتم الادعاء بأن APK إنتاجي نهائي تم بناؤه هنا؛ بيئة العمل الحالية لا تحتوي على Flutter/Android SDK، لذلك يلزم تنفيذ build على بيئة Flutter فعلية بعد وضع مفاتيح المشروع.
