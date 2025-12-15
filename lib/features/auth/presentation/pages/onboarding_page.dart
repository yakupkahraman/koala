import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants.dart';
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
  double currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(UiConstants.defaultPadding),
          child: Stack(
            children: [
              PageView(
                controller: controller,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2;
                  });
                },
                children: [
                  OnboardingContent(
                    title: "Günlük İş Bul",
                    description:
                        "Sana yakın günlük iş ilanlarını keşfet ve hemen başvur",
                  ),
                  OnboardingContent(
                    title: "Hızlı Başvuru",
                    description:
                        "Tek tıkla başvuru yap, işverenler seninle direkt iletişime geçsin",
                  ),
                  OnboardingContent(
                    title: "Kazanmaya Başla",
                    description: "İstediğin zamanlarda çalış, ek gelir elde et",
                  ),
                ],
              ),
              Positioned(
                right: 2,
                bottom: MediaQuery.of(context).size.height * 0.45,
                child: SmoothPageIndicator(
                  controller: controller,
                  axisDirection: Axis.vertical,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 6,
                    activeDotColor: ThemeConstants.primaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: _AnimatedButton(
                  currentPage: currentPage,
                  isLastPage: isLastPage,
                  onPressed: () async {
                    if (isLastPage) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('seen_onboarding', true);
                      if (context.mounted) {
                        context.go('/auth');
                      }
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
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

class _AnimatedButton extends StatelessWidget {
  final double currentPage;
  final bool isLastPage;
  final VoidCallback onPressed;

  const _AnimatedButton({
    required this.currentPage,
    required this.isLastPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Sayfa 0 iken tam genişlik, sayfa 1'e yaklaştıkça daralır
    final rawProgress = currentPage.clamp(0.0, 1.0);
    // Daha hızlı küçülme için easing curve uygula
    final progress = Curves.easeOutCubic.transform(rawProgress);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding =
        UiConstants.defaultPadding * 2 +
        24; // Container padding + button padding
    final fullWidth = screenWidth - padding;
    final circularSize = 60.0;

    // 0 = full width, 1 = circular
    final buttonWidth = fullWidth - ((fullWidth - circularSize) * progress);
    final borderRadius =
        UiConstants.borderRadius +
        ((30.0 - UiConstants.borderRadius) * progress);

    // Text görünürlüğü: 0-0.5 arası fade out
    final textOpacity = (1.0 - (progress * 2)).clamp(0.0, 1.0);
    // Icon görünürlüğü: 0.5-1 arası fade in
    final iconOpacity = ((progress - 0.5) * 2).clamp(0.0, 1.0);

    // İkinci geçiş için progress (1.0-2.0 arası)
    final secondProgress = (currentPage - 1.0).clamp(0.0, 1.0);
    // Aşağı ok: 1.0'dan 2.0'a giderken fade out
    final arrowOpacity = (1.0 - secondProgress).clamp(0.0, 1.0);
    // Tik: 1.0'dan 2.0'a giderken fade in
    final checkOpacity = secondProgress.clamp(0.0, 1.0);

    String buttonText = 'SONRAKİ';
    if (isLastPage) {
      buttonText = 'HAYDİ BAŞLAYALIM!';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: buttonWidth,
          height: circularSize,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              backgroundColor: ThemeConstants.primaryColor,
              overlayColor: Colors.green[50],
              padding: const EdgeInsets.all(12.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (textOpacity > 0)
                  Opacity(
                    opacity: textOpacity,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                if (iconOpacity > 0 && arrowOpacity > 0)
                  Opacity(
                    opacity: iconOpacity * arrowOpacity,
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                if (iconOpacity > 0 && checkOpacity > 0)
                  Opacity(
                    opacity: iconOpacity * checkOpacity,
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
