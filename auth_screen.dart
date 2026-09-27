import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'customer_home.dart';
import 'courier_home.dart';
import 'owner_home.dart';

class AuthScreen extends StatefulWidget {
  final String role;
  const AuthScreen({super.key, required this.role});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool register = false;
  bool loading = false;

  String get roleName => switch (widget.role) {
    'driver' => 'المندوب',
    'owner' => 'المالك',
    _ => 'العميل',
  };

  Future<void> _emailAuth() async {
    setState(() => loading = true);
    final service = AuthService();
    final result = register
        ? await service.registerWithEmail(email.text, password.text)
        : await service.signInWithEmail(email.text, password.text);
    if (!mounted) return;
    setState(() => loading = false);
    if (result != null) {
      _go();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر تسجيل الدخول. لو أنت في وضع التجربة استخدم زر التجربة السريعة.')),
      );
    }
  }

  Future<void> _google() async {
    setState(() => loading = true);
    final result = await AuthService().signInWithGoogle();
    if (!mounted) return;
    setState(() => loading = false);
    if (result != null) {
      _go();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Login يحتاج إعداد Firebase وSHA-1/Google provider.')),
      );
    }
  }

  void _go() {
    final page = switch (widget.role) {
      'driver' => const CourierHome(),
      'owner' => const OwnerHome(),
      _ => const CustomerHome(),
    };
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => page), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          children: [
            Text('دخول $roleName',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('حسابك هو مفتاح الطلبات والتتبع والإشعارات.',
                style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 28),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('تسجيل الدخول')),
                ButtonSegment(value: true, label: Text('حساب جديد')),
              ],
              selected: {register},
              onSelectionChanged: (s) => setState(() => register = s.first),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: loading ? null : _emailAuth,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: loading
                  ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(register ? 'إنشاء الحساب' : 'دخول'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: loading ? null : _google,
              icon: const Icon(Icons.g_mobiledata_rounded, size: 30),
              label: const Text('المتابعة باستخدام Google'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _go,
              child: const Text('تجربة الواجهة الآن بدون حساب'),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: NovaTheme.primary.withOpacity(.07),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.phone_android_rounded, color: NovaTheme.primary),
                  SizedBox(width: 12),
                  Expanded(child: Text(
                    'الخطوة التالية ستضيف تسجيل الدخول برقم الهاتف + كود SMS وربط الحساب بالدور المختار.',
                    style: TextStyle(height: 1.4),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: loading ? null : _demo,
              icon: const Icon(Icons.flash_on_rounded),
              label: const Text('دخول سريع للتجربة'),
              style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
            ),
          ],
        ),
      ),
    );
  }

  void _demo() {
    final page = switch (widget.role) {
      'driver' => const CourierHome(),
      'owner' => const OwnerHome(),
      _ => const CustomerHome(),
    };
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => page), (_) => false);
  }
}
