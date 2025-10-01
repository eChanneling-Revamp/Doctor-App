import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/singup/signup_screen.dart';
import 'screens/singup/signup_photo_screen.dart';
import 'screens/singup/signup_contact_screen.dart';
import 'screens/singup/signup_success_screen.dart';

void main() {
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const SplashScreen(),
        '/signin': (context) => const SignInScreen(),
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/signup-photo': (context) => const SignUpPhotoScreen(),
        '/signup-contact': (context) => const SignUpContactScreen(),
        '/signup-success': (context) => const SignUpSuccessScreen(),
      },
    );
  }
}
