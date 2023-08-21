import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const/app_screens.dart';
import 'const/app_text.dart';
import 'utils/app_routes.dart';
late List<CameraDescription> cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      title: AppText.appName,
      getPages: AppRoutes.pages,
      initialRoute: AppScreen.initialScreen,
    );
  }
}
