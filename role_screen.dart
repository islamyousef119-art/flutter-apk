import 'package:flutter/material.dart';
import '../theme.dart';
import 'auth_screen.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                height: 92,
                width: 92,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [NovaTheme.primary, Color(0xFF8D73FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Color(0x336C4CF1), blurRadius: 28, offset: Offset(0, 14))
                  ],
                ),
                child: const Icon(Icons.delivery_dining_rounded,
                    color: Colors.white, size: 52),
              ),
              const SizedBox(height: 24),
              const Text('توصيل أسرع مع نوفا',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('اختار طريقة استخدامك للتطبيق',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 38),
              _RoleCard(
                icon: Icons.person_rounded,
                title: 'أنا عميل',
                text: 'اطلب من المطاعم وتابع طلبك لحظة بلحظة',
                color: NovaTheme.primary,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AuthScreen(role: 'customer'))),
              ),
              const SizedBox(height: 16),
              _RoleCard(
                icon: Icons.two_wheeler_rounded,
                title: 'أنا مندوب',
                text: 'استقبل الطلبات القريبة واختر الطلب المناسب',
                color: NovaTheme.secondary,
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AuthScreen(role: 'driver'))),
              ),
              const SizedBox(height: 18),
              TextButton.icon(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AuthScreen(role: 'owner'))),
                icon: const Icon(Icons.admin_panel_settings_outlined),
                label: const Text('دخول لوحة المالك'),
              ),
              const Spacer(),
              Text('نسخة تجريبية للواجهة — سيتم ربط البيانات الحقيقية بعد إعداد Firebase',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: color.withOpacity(.12)),
          boxShadow: const [
            BoxShadow(color: Color(0x0D111827), blurRadius: 24, offset: Offset(0, 10))
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 62, width: 62,
              decoration: BoxDecoration(
                color: color.withOpacity(.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 31),
            ),
            const SizedBox(width: 16),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 5),
                Text(text, style: TextStyle(color: Colors.grey.shade600, height: 1.35)),
              ],
            )),
            const Icon(Icons.arrow_forward_ios_rounded, size: 17),
          ],
        ),
      ),
    );
  }
}
