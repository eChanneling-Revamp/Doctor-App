import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
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
        title: const Text(
          'Add New Session',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: const AddSessionForm(),
      ),
    );
  }
}
