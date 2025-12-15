import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/widgets/my_button.dart';
import 'package:koala/core/widgets/my_textfield.dart';
import 'package:koala/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, left: 12.0, right: 12.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.grey[600],
              height: 1.5,
            ),
            children: [
              TextSpan(text: 'Devam ederek '),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Kullanım Şartları',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: ThemeConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' ve '),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Gizlilik Politikası',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: ThemeConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              TextSpan(text: "'nı kabul etmiş olursunuz."),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tekrardan Hoş Geldin!",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 36),
                              MyTextfield(labelText: 'E-posta'),
                              const SizedBox(height: 10),
                              MyTextfield(labelText: 'Şifre'),
                              const SizedBox(height: 7),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Şifrenizi mi unuttunuz?',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: MyButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('is_logged_in', true);

                                  if (context.mounted) {
                                    context.go('/explore');
                                  }
                                },
                                title: 'GİRİŞ YAP',
                              ),
                            ),
                            const SizedBox(height: 10),

                            // "YA DA" Divider
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      'YA DA',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey[300],
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        UiConstants.borderRadius,
                                      ),
                                      side: BorderSide(
                                        color: ThemeConstants.primaryColor,
                                        width: 3.0,
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.all(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 10),
                                          Image.asset(
                                            'assets/images/google_logo.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "GOOGLE İLE GİRİŞ YAP",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: ThemeConstants
                                                      .primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 34),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
