import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/app/app_binding.dart';
import 'package:running_app_flutter/routes/app_pages.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/local_storage.dart';
import 'package:running_app_flutter/utils/dependency.dart';

void main() async {
  DependencyInjection.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

initServices() async {
  print('Starting services ...');
  await Get.putAsync(() => LocalStorageService().init());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final store = Get.find<LocalStorageService>();

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData.fromView(WidgetsBinding.instance.window),
        child: ScreenUtilInit(builder: ((context, child) {
          return GetMaterialApp(
            builder: EasyLoading.init(),
            initialRoute:
                !store.isLogin ? AppRoutes.Welcome : AppRoutes.Run_Main,
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
