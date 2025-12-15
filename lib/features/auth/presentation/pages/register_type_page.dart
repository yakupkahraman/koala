import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterTypePage extends StatelessWidget {
  const RegisterTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ne olmak istersin?",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 64),

                  // İş Veren Kartı
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        UiConstants.borderRadius,
                      ),
                      side: BorderSide(
                        color: ThemeConstants.primaryColor,
                        width: 3,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.green[100],
                      highlightColor: Colors.green[50],
                      borderRadius: BorderRadius.circular(
                        UiConstants.borderRadius,
                      ),
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isBusiness', true);

                        if (context.mounted) {
                          context.push(
                            '/auth/register-type/register?isBusiness=true',
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            // İş Veren İmajı
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/koala_business.png',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // İş Veren Yazısı
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'İş Veren',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'İş yeriniz için',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Arrow Right
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Çalışan Kartı
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        UiConstants.borderRadius,
                      ),
                      side: BorderSide(
                        color: ThemeConstants.primaryColor,
                        width: 3,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.green[100],
                      highlightColor: Colors.green[50],
                      borderRadius: BorderRadius.circular(
                        UiConstants.borderRadius,
                      ),
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isBusiness', false);

                        if (context.mounted) {
                          context.push(
                            '/auth/register-type/register?isBusiness=false',
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            // Çalışan İmajı
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/koala_worker.png',
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Çalışan Yazısı
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Çalışan',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Para kazanmak için',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Arrow Right
                            Icon(
                              HugeIcons.strokeRoundedArrowRight01,
                              color: Colors.grey[600],
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
