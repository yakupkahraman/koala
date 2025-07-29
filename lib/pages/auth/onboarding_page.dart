import 'package:flutter/material.dart';
import 'package:koala/components/my_button.dart';
import 'package:koala/constants.dart';
import 'package:koala/pages/auth/login_or_register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: kDefaultPadding,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == 2;
                    });
                  },
                  children: [
                    OnboardingContent(
                      title: "selam",
                      description: "müq uygulama",
                    ),
                    OnboardingContent(
                      title: "uwu",
                      description: "müq uygulama",
                    ),
                    OnboardingContent(title: "owo", description: "valla müq"),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 6,
                  activeDotColor: kMainGreenColor,
                ),
              ),
              const SizedBox(height: 30),
              MyButton(
                onPressed: () async {
                  if (isLastPage) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('seen_onboarding', true);
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginOrRegisterPage(),
                        ),
                      );
                    }
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                title: isLastPage ? 'HAYDİ BAŞLAYALIM!' : 'SONRAKİ',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, size: 100, color: Colors.blueAccent),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
