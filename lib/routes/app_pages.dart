import 'package:get/get.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_controller.dart';
import 'package:running_app_flutter/presentation/sign_up/sign_up_page.dart';
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
        name: AppRoutes.SignUp,
        page: () => const SignUpPage(),
        bindings: [SignUpBinding()])
  ];
}
