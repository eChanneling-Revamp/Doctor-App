import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/session_widgets/add_session_widgets.dart';

class AddSessionScreen extends StatelessWidget {
  const AddSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const CustomBackButton(),
        centerTitle: true,
        title: Text(
          'Add New Session',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 20.h),
          child: const AddSessionForm(),
        ),
      ),
    );
  }
}
