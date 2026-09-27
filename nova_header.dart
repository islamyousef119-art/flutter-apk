import 'package:flutter/material.dart';
import '../theme.dart';

class NovaHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const NovaHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w900, color: NovaTheme.dark)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
