import 'package:flutter/material.dart';
import 'package:koala/components/my_button.dart';
import 'package:koala/constants.dart';
import 'package:koala/pages/auth/login_page.dart';
import 'package:koala/pages/auth/register_type_page.dart';

class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
              padding: kDefaultPadding,
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegisterTypePage(),
                              ),
                            );
                          },
                          title: 'KAYIT OL',
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(
                                    color: kMainGreenColor,
                                    width: 3.0,
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(12.0),
                              ),
                              child: Text(
                                "GİRİŞ YAP",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: kMainGreenColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
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
