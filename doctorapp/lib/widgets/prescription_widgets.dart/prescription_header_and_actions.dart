import 'package:flutter/material.dart';
import '../shared_widgets.dart';
import '../../utils/snackbar_utils.dart';

class PrescriptionHeader extends StatelessWidget {
  const PrescriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: const AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Mary De Silva',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Age : 28  \nID : E00210\nRef : App-2025002',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F7EB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(color: Color(0xFF10B981)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PrescriptionBottomActions extends StatelessWidget {
  final VoidCallback? onShare;
  final VoidCallback? onSend;

  const PrescriptionBottomActions({super.key, this.onShare, this.onSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Share',
            onPressed: onShare ?? () => SnackbarUtils.info(context, 'Shared'),
            backgroundColor: const Color(0xFF4A3FFF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed:
                  onSend ??
                  () => SnackbarUtils.info(context, 'Sent to patient'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Send to Patient',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
