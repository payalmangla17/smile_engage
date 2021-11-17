import 'package:flutter/material.dart';
import 'package:smile_engage/pages/authentication/complete_profile/complete_profile_screen.dart';
import 'package:smile_engage/pages/authentication/forget_password_screen.dart';
import 'package:smile_engage/pages/authentication/otp/otp_screen.dart';
import 'package:smile_engage/pages/authentication/register/register_page.dart';
import 'package:smile_engage/pages/authentication/sign_in_page.dart';
import 'package:smile_engage/pages/home/home_page.dart';
import 'package:smile_engage/pages/introduction_animation/introduction_animation.dart';
import 'package:smile_engage/pages/page_viewer/features.dart';

import '../welcome_screen.dart';
import 'ui_routes.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.welcome_screen:
        return MaterialPageRoute(builder: (_) {
          return WelcomeScreen();
        });
      case Routes.features:
        return MaterialPageRoute(builder: (_) {
          return Features();
        });

      case Routes.intro:
        return MaterialPageRoute(builder: (_) {
          return IntroductionAnimationScreen();
        });
      case Routes.login:
        return MaterialPageRoute(builder: (_) {
          return LoginPage();
        });
      case Routes.register:
        return MaterialPageRoute(builder: (_) {
          return RegisterPage();
        });
      case Routes.forget_password:
        return MaterialPageRoute(builder: (_) {
          return ForgetPasswordScreen();
        });
      case Routes.complete_profile_screen:
        return MaterialPageRoute(builder: (_) {
          return CompleteProfileScreen();
        });
      case Routes.otp_screen:
        return MaterialPageRoute(builder: (_) {
          return OtpScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });
    }
  }
}
