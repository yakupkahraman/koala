import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/constants.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationPendingPage extends StatelessWidget {
  const EmailVerificationPendingPage({super.key, required this.isBusiness});

  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(
            '/auth/register-type/register/creating-password?isBusiness=$isBusiness',
          );
        },
        child: Icon(Icons.arrow_circle_right_outlined),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Lottie.asset(
                    'assets/lottie/email_verification_pending.json',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "E-posta doğrulama bekleniyor",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  "Lütfen e-posta adresinize gelen doğrulama linkine tıklayın.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
