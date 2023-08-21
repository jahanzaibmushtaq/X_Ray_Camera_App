import 'package:get/get.dart';
import 'package:x_ray_scanner/controllers/camera_controller.dart';

class CameraBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CameraHomeController());
  }
}