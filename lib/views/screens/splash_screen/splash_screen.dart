import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_ray_scanner/const/app_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),()=>Get.offNamed(AppScreen.cameraScreen));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const[
          FlutterLogo(size: 60,)

        ],
      ),
    );
  }
}
