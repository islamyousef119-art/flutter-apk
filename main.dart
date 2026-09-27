import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/role_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // The app intentionally falls back to demo mode when Firebase has not been
  // configured yet. After running `flutterfire configure`, Firebase becomes live.
  try {
    await Firebase.initializeApp();
    await NotificationService.initialize();
  } catch (_) {}

  runApp(const NovaApp());
}

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'توصيل أسرع مع نوفا',
      debugShowCheckedModeBanner: false,
      theme: NovaTheme.data,
      locale: const Locale('ar'),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: RoleScreen(),
      ),
    );
  }
}
