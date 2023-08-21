import 'package:get/get.dart';
import 'package:x_ray_scanner/bindings/camera_binding.dart';
import 'package:x_ray_scanner/const/app_screens.dart';
import 'package:x_ray_scanner/views/screens/camera_screen/camera_screen.dart';
import 'package:x_ray_scanner/views/screens/splash_screen/splash_screen.dart';


class AppRoutes{
  static List<GetPage> pages = <GetPage>[
    GetPage(name: AppScreen.initialScreen, page: ()=>const SplashScreen()),
    GetPage(name: AppScreen.cameraScreen, page: ()=> CameraScreen(),binding: CameraBinding()),
  ];
}