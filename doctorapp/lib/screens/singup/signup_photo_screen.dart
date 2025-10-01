import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';

class SignUpPhotoScreen extends StatefulWidget {
  const SignUpPhotoScreen({super.key});

  @override
  State<SignUpPhotoScreen> createState() => _SignUpPhotoScreenState();
}

class _SignUpPhotoScreenState extends State<SignUpPhotoScreen> {
  bool _hasPhoto = false;

  void _uploadPhoto() {
    // Handle photo upload
    setState(() {
      _hasPhoto = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Photo upload feature coming soon')),
    );
  }

  void _back() {
    Navigator.pop(context);
  }

  void _next() {
    Navigator.pushNamed(context, '/signup-contact');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Logo
              const LogoWidget(size: 60),

              const SizedBox(height: 80),

              // Profile Photo Section
              GestureDetector(
                onTap: _uploadPhoto,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child:
                      _hasPhoto
                          ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          )
                          : Stack(
                            children: [
                              const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4A3FFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              ),

              const SizedBox(height: 24),

              // Text
              Text(
                'Personalize your account with a photo You\ncan always change it later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const Spacer(),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _back,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'Next',
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
