import 'package:get/get.dart';
import 'package:x_ray_scanner/controllers/image_preview_controller.dart';

class ImagePreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImagePreviewController());
  }
}
