import 'package:flutter/material.dart';
import 'package:koala/pages/auth/auth_page.dart';
import 'package:koala/pages/auth/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> checkIfSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seen_onboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfSeenOnboarding(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final seenOnboarding = snapshot.data ?? false;
          return seenOnboarding ? const AuthPage() : const OnboardingPage();
        }
      },
    );
  }
}
