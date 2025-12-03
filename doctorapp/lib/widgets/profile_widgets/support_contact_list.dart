import 'package:flutter/material.dart';
import '../../utils/snackbar_utils.dart';

class SupportContactItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SupportContactItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24),
          ],
        ),
      ),
    );
  }
}

class SupportContactList extends StatelessWidget {
  const SupportContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Support',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Phone Support
        SupportContactItem(
          icon: Icons.phone_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Phone Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening phone dialer...');
          },
        ),

        const SizedBox(height: 12),

        // Email Support
        SupportContactItem(
          icon: Icons.email_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Email Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening email client...');
          },
        ),

        const SizedBox(height: 12),

        // WhatsApp Support
        SupportContactItem(
          icon: Icons.chat_outlined,
          iconColor: const Color(0xFF4C40F7),
          iconBgColor: const Color(0xFFEDE9FE),
          title: 'Whats app Support',
          subtitle: '123456789+',
          onTap: () {
            SnackbarUtils.info(context, 'Opening WhatsApp...');
          },
        ),
      ],
    );
  }
}
