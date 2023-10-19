import 'package:get/get.dart';
import 'package:running_app_flutter/presentation/forgot_password/forgot_password_controller.dart';
import 'package:running_app_flutter/presentation/forgot_password/forgot_password_page.dart';
import 'package:running_app_flutter/presentation/home/run_main_controller.dart';
import 'package:running_app_flutter/presentation/home/run_main_page.dart';
import 'package:running_app_flutter/presentation/login/login_controller.dart';
import 'package:running_app_flutter/presentation/login/login_page.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_controller.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_page.dart';
import 'package:running_app_flutter/presentation/verification/verification_controller.dart';
import 'package:running_app_flutter/presentation/verification/verification_page.dart';
import 'package:running_app_flutter/presentation/welcome/welcome_controller.dart';
import 'package:running_app_flutter/presentation/welcome/welcome_page.dart';
import 'package:running_app_flutter/routes/app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(
        name: AppRoutes.Welcome,
        page: () => const WelcomePage(),
        bindings: [WelcomeBinding()]),
    GetPage(
        name: AppRoutes.Login,
        page: () => const LoginPage(),
        bindings: [LoginBinding()]),
    GetPage(
        name: AppRoutes.SignUp,
        page: () => const SignUpPage(),
        bindings: [SignUpBinding()]),
    GetPage(
        name: AppRoutes.ForgotPassword,
        page: () => const ForgotPasswordPage(),
        bindings: [ForgotPasswordBinding()]),
    GetPage(
        name: AppRoutes.Verification,
        page: () => const VerificationPage(),
        bindings: [VerificationBinding()]),
    GetPage(
        name: AppRoutes.Run_Main,
        page: () => const RunMainPage(),
        bindings: [RunMainBinding()])
  ];
}
