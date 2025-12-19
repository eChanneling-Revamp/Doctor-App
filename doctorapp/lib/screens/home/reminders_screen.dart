import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/share_widgets/custom_back_button.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => Navigator.pop(context)),
        title: Text(
          'Reminders',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
