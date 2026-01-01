import 'package:go_router/go_router.dart';
import 'package:koala/features/auth/presentation/pages/auth_gate.dart';
import 'package:koala/features/auth/presentation/pages/auth_page.dart';
import 'package:koala/features/auth/presentation/pages/company_informations_page.dart';
import 'package:koala/features/auth/presentation/pages/creating_password_page.dart';
import 'package:koala/features/auth/presentation/pages/onboarding_page.dart';
import 'package:koala/features/auth/presentation/pages/register_type_page.dart';
import 'package:koala/features/home/presentation/pages/explore_pages/explore_page.dart';
import 'package:koala/features/jobs/presentation/pages/jobs_page.dart';
import 'package:koala/features/chat/presentation/pages/chat_list_page.dart';
import 'package:koala/features/chat/presentation/pages/chat_page.dart';
import 'package:koala/features/chat/domain/chat.dart';
import 'package:koala/features/profile/presentation/pages/profile_page.dart';
import 'package:koala/features/home/presentation/pages/shell_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koala/features/auth/presentation/pages/login_page.dart';
import 'package:koala/features/auth/presentation/pages/register_page.dart';
import 'package:koala/features/auth/presentation/pages/email_verification_pending_page.dart';

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
                      token: state.uri.queryParameters['token'],
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
      // GoRoute(
      //   path: '/search',
      //   builder: (context, state) => const SearchExplorePage(),
      // ),

      // Chat Detail Route (outside of shell)
      GoRoute(
        path: '/chat-detail',
        builder: (context, state) {
          final chatData = state.extra as Chat;
          return ChatPage(chat: chatData);
        },
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
            path: '/jobs',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const JobsPage()),
          ),
          GoRoute(
            path: '/chat',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: const ChatListPage()),
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
