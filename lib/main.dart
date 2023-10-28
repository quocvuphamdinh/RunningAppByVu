import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/app/app_binding.dart';
import 'package:running_app_flutter/routes/app_pages.dart';
import 'package:running_app_flutter/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData.fromView(WidgetsBinding.instance.window),
        child: ScreenUtilInit(builder: ((context, child) {
          return GetMaterialApp(
            builder: EasyLoading.init(),
            initialRoute: AppRoutes.Welcome,
            getPages: AppPages.routes,
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            title: 'Vũ Running App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: const SignUpPage(),
          );
        })));
  }
}
