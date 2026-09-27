# Android setup checklist

بعد `flutter create`:

1. افتح `android/app/src/main/AndroidManifest.xml`.
2. داخل `<manifest>` أضف:
   `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
   `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
3. داخل `<application>` أضف:
   `<meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_MAPS_KEY"/>`
4. تأكد أن minSdk مناسب للحزم الحالية (Firebase Auth الحديثة تتطلب Android API 23+).
5. نفّذ:
   `flutter clean`
   `flutter pub get`
   `flutter run`
