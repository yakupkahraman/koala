import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:koala/components/my_button.dart';
import 'package:koala/components/my_textfield.dart';
import 'package:koala/constants.dart';
import 'package:koala/pages/auth/company_informations_page.dart';
import 'package:lottie/lottie.dart';
import 'package:koala/pages/main_page.dart';

class EmailVerificationPendingPage extends StatelessWidget {
  const EmailVerificationPendingPage({super.key, required this.isBusiness});

  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  CreatingPasswordPage(isBusiness: isBusiness),
            ),
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

class CreatingPasswordPage extends StatefulWidget {
  const CreatingPasswordPage({super.key, required this.isBusiness});
  final bool isBusiness;

  @override
  State<CreatingPasswordPage> createState() => _CreatingPasswordPageState();
}

class _CreatingPasswordPageState extends State<CreatingPasswordPage> {
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool get passwordsMatch {
    return passwordController.text == confirmPasswordController.text &&
        passwordController.text.isNotEmpty;
  }

  bool get isPasswordStrong {
    final password = passwordController.text;
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: kDefaultPadding,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Text(
                          "Şifrenizi Oluşturalım",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 50),
                        MyTextfield(
                          labelText: "Şifre",
                          controller: passwordController,
                          isObscureText: isVisiblePassword,
                          showSuffixIcon: true,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => setState(() {}),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisiblePassword
                                  ? HugeIcons.strokeRoundedViewOff
                                  : HugeIcons.strokeRoundedView,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() {
                                isVisiblePassword = !isVisiblePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyTextfield(
                          labelText: "Şifre Tekrar",
                          controller: confirmPasswordController,
                          isObscureText: isVisibleConfirmPassword,
                          showSuffixIcon: true,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) => setState(() {}),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisibleConfirmPassword
                                  ? HugeIcons.strokeRoundedViewOff
                                  : HugeIcons.strokeRoundedView,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {
                              setState(() {
                                isVisibleConfirmPassword =
                                    !isVisibleConfirmPassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Şifre Güçlü/Eşleşme Göstergesi
                        if (passwordController.text.isNotEmpty) ...[
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Şifre Güçlü Göstergesi
                                Row(
                                  children: [
                                    Icon(
                                      isPasswordStrong
                                          ? HugeIcons
                                                .strokeRoundedCheckmarkCircle02
                                          : HugeIcons.strokeRoundedCancelCircle,
                                      color: isPasswordStrong
                                          ? Colors.green
                                          : Colors.orange,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      isPasswordStrong
                                          ? 'Güçlü şifre'
                                          : 'Şifre güçlendirilmeli',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isPasswordStrong
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),

                                if (!isPasswordStrong) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    '• En az 8 karakter\n• Büyük harf, küçük harf ve rakam içermeli',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],

                                // Şifre Eşleşme Göstergesi
                                if (confirmPasswordController
                                    .text
                                    .isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        passwordsMatch
                                            ? HugeIcons
                                                  .strokeRoundedCheckmarkCircle02
                                            : HugeIcons
                                                  .strokeRoundedCancelCircle,
                                        color: passwordsMatch
                                            ? Colors.green
                                            : Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        passwordsMatch
                                            ? 'Şifreler eşleşiyor'
                                            : 'Şifreler eşleşmiyor',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: passwordsMatch
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      if (!widget.isBusiness) {
                        if (isPasswordStrong && passwordsMatch) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                            (route) => false, // Tüm önceki sayfaları temizle
                          );
                        } else {
                          // Uyarı mesajı göster
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                !isPasswordStrong
                                    ? 'Lütfen güçlü bir şifre oluşturun'
                                    : 'Şifreler eşleşmiyor',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              backgroundColor: Colors.green[100],
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } else {
                        if (isPasswordStrong && passwordsMatch) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyInformationsPage(),
                            ),
                          );
                        } else {
                          // Uyarı mesajı göster
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                !isPasswordStrong
                                    ? 'Lütfen güçlü bir şifre oluşturun'
                                    : 'Şifreler eşleşmiyor',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              backgroundColor: Colors.green[100],
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                    title: widget.isBusiness ? "DEVAM ET" : "BİTİR",
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
