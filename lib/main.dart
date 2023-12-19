import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:running_app_flutter/app/app_binding.dart';
import 'package:running_app_flutter/data/providers/database/database_service.dart';
import 'package:running_app_flutter/data/providers/network/api_service.dart';
import 'package:running_app_flutter/firebase_options.dart';
import 'package:running_app_flutter/routes/app_pages.dart';
import 'package:running_app_flutter/routes/app_routes.dart';
import 'package:running_app_flutter/services/firebase_storage.dart';
import 'package:running_app_flutter/services/local_storage.dart';
import 'package:running_app_flutter/utils/dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  initApiService();
  await initServices();
  await initFirebase();
  DependencyInjection.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

initFirebase() async {
  print("Init firebase...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(FirebaseStorageService(), permanent: true);
  print("Firebase init successfully...");
}

initApiService() {
  print("Init ApiService...");
  Get.put(ApiService(Dio(BaseOptions(contentType: "application/json"))),
      permanent: true);
  print("ApiService created...");
}

initDatabase() async {
  print("Init database...");
  Get.lazyPut(() => DatabaseService());
  await Get.putAsync(() => Get.find<DatabaseService>().database);
  print('Database created...');
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
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            builder: ((context, child) {
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
