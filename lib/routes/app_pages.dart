import 'package:get/get.dart';
import 'package:running_app_flutter/presentation/exercise_detail/exercise_detail_controller.dart';
import 'package:running_app_flutter/presentation/exercise_detail/exercise_detail_page.dart';
import 'package:running_app_flutter/presentation/exercise_list/exercise_list_controller.dart';
import 'package:running_app_flutter/presentation/exercise_list/exercise_list_page.dart';
import 'package:running_app_flutter/presentation/forgot_password/forgot_password_controller.dart';
import 'package:running_app_flutter/presentation/forgot_password/forgot_password_page.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_controller.dart';
import 'package:running_app_flutter/presentation/home/analysis/analysis_page.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/exercise/exercise_page.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/home_page.dart';
import 'package:running_app_flutter/presentation/home/home_page/recent_exercise/recent_exercise_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/recent_exercise/recent_exercise_page.dart';
import 'package:running_app_flutter/presentation/home/home_page/weekly_goal_setting/weekly_goal_setting_controller.dart';
import 'package:running_app_flutter/presentation/home/home_page/weekly_goal_setting/weekly_goal_setting_page.dart';
import 'package:running_app_flutter/presentation/home/profile/edit_profile/edit_profile_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/edit_profile/edit_profile_page.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/profile_page.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_controller.dart';
import 'package:running_app_flutter/presentation/home/profile/run_history/run_history_page.dart';
import 'package:running_app_flutter/presentation/home/run_main_controller.dart';
import 'package:running_app_flutter/presentation/home/run_main_page.dart';
import 'package:running_app_flutter/presentation/login/login_controller.dart';
import 'package:running_app_flutter/presentation/login/login_page.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/result_exercise_run_controller.dart';
import 'package:running_app_flutter/presentation/result_exercise_run/result_exercise_run_page.dart';
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
        bindings: [RunMainBinding()]),
    GetPage(
        name: AppRoutes.Home,
        page: () => const HomePage(),
        bindings: [HomeBinding()]),
    GetPage(
        name: AppRoutes.Exercise,
        page: () => const ExercisePage(),
        bindings: [ExerciseBinding()]),
    GetPage(
        name: AppRoutes.Analysis,
        page: () => const AnalysisPage(),
        bindings: [AnalysisBinding()]),
    GetPage(
        name: AppRoutes.Profile,
        page: () => const ProfilePage(),
        bindings: [ProfileBinding()]),
    GetPage(
        name: AppRoutes.WeeklyGoalSetting,
        page: () => const WeeklyGoalSettingPage(),
        bindings: [WeeklyGoalSettingBinding()]),
    GetPage(
        name: AppRoutes.ExerciseDetail,
        page: () => const ExerciseDetailPage(),
        bindings: [ExerciseDetailBinding()]),
    GetPage(
        name: AppRoutes.ExerciseList,
        page: () => const ExerciseListPage(),
        bindings: [ExerciseListBinding()]),
    GetPage(
        name: AppRoutes.RecentExercise,
        page: () => const RecentExercisePage(),
        bindings: [RecentExerciseBinding()]),
    GetPage(
        name: AppRoutes.ResultExerciseRun,
        page: () => const ResultExerciseRunPage(),
        bindings: [ResultExerciseRunBinding()]),
    GetPage(
        name: AppRoutes.EditProfile,
        page: () => const EditProfilePage(),
        bindings: [EditProfileBinding()]),
    GetPage(
        name: AppRoutes.RunHistory,
        page: () => const RunHistoryPage(),
        bindings: [RunHistoryBinding()]),
  ];
}
