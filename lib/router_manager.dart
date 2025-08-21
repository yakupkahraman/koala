import 'package:go_router/go_router.dart';
import 'package:koala/pages/auth/auth_gate.dart';
import 'package:koala/pages/auth/auth_page.dart';
import 'package:koala/pages/auth/company_informations_page.dart';
import 'package:koala/pages/auth/creating_password_page.dart';
import 'package:koala/pages/auth/onboarding_page.dart';
import 'package:koala/pages/auth/register_type_page.dart';
import 'package:koala/pages/explore_page.dart';
import 'package:koala/pages/my_jobs_page.dart';
import 'package:koala/pages/chat_page.dart';
import 'package:koala/pages/profile_page.dart';
import 'package:koala/shell_page.dart';
import 'package:koala/pages/search_explore_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koala/pages/auth/login_page.dart';
import 'package:koala/pages/auth/register_page.dart';
import 'package:koala/pages/auth/email_verification_pending_page.dart';

class RouterManager {
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/explore',
    redirect: (context, state) async {
      final loggedIn = await isUserLoggedIn();

      final authRoutes = ['/auth', '/authgate', '/onboarding'];
      final isAuthRoute = authRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      if (!loggedIn && !isAuthRoute) {
        return '/authgate';
      }
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: 'register-type',
            builder: (context, state) => const RegisterTypePage(),
            routes: [
              GoRoute(
                path: 'register',
                builder: (context, state) => RegisterPage(
                  isBusiness: state.uri.queryParameters['isBusiness'] == 'true',
                ),
                routes: [
                  GoRoute(
                    path: 'email-verification-pending',
                    builder: (context, state) => EmailVerificationPendingPage(
                      isBusiness:
                          state.uri.queryParameters['isBusiness'] == 'true',
                    ),
                  ),
                  GoRoute(
                    path: 'creating-password',
                    builder: (context, state) => CreatingPasswordPage(
                      isBusiness:
                          state.uri.queryParameters['isBusiness'] == 'true',
                    ),
                    routes: [
                      GoRoute(
                        path: 'company-informations',
                        builder: (context, state) =>
                            const CompanyInformationsPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(path: '/authgate', builder: (context, state) => const AuthGate()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchExplorePage(),
      ),

      //Main Shell
      ShellRoute(
        builder: (context, state, child) => ShellPage(child: child),
        routes: [
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ExplorePage()),
          ),
          GoRoute(
            path: '/my-jobs',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const MyJobsPage()),
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ChatPage()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ProfilePage()),
          ),
        ],
      ),
    ],
  );
}
