import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/widgets/my_button.dart';
import 'package:koala/core/constants.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background_map.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(UiConstants.defaultPadding),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 70),
                        SizedBox(
                          height: 90,
                          child: Image.asset('assets/images/koala_logo_1.png'),
                        ),
                        Text(
                          'KOALA',
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 64,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MyButton(
                          onPressed: () {
                            context.go('/auth/register-type');
                          },
                          title: 'KAYIT OL',
                        ),
                        const SizedBox(height: 15),
                        MyButton(
                          onPressed: () {
                            context.go('/auth/login');
                          },
                          title: 'GİRİŞ YAP',
                          isReversed: true,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
