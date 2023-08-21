import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_ray_scanner/bindings/image_preview_binding.dart';
import 'package:x_ray_scanner/views/screens/picture_preview_screen/picture_preview_screen.dart';
import 'package:x_ray_scanner/views/widgets/custom_snack_bar.dart';

import '../main.dart';

class CameraHomeController extends GetxController with WidgetsBindingObserver {
  late CameraController cameraController;
  final isException = false.obs;
  final isWait = true.obs;
   CameraDescription cameraDescription = cameras[0];

  void _initializationController() async {
    isWait.value = true;
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.max);

    cameraController.initialize().then((value) {
      isException(false);
      isWait.value = false;
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            isException(true);
            break;
          default:
            isException(true);
            break;
        }
      }
    });
  }

  void captureImage() async {
    cameraController.setFlashMode(FlashMode.off);
    final image = cameraController.takePicture();
    File imageFile = File((await image).path);
    Get.to(PicturePreviewScreen(imageFile: imageFile),binding: ImagePreviewBinding());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraStateController = cameraController;

    // App state changed before we got the chance to initialize.
    if (!cameraStateController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraStateController.dispose().then((value) => print("camera pause"));
    } else if (state == AppLifecycleState.resumed) {
      _initializationController();
    }
  }

  void toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = cameraController.description.lensDirection;
    CameraDescription? newDescription = lensDirection == CameraLensDirection.front
        ? cameras.firstWhere((description) =>
            description.lensDirection == CameraLensDirection.back)
        : cameras.firstWhere((description) =>
            description.lensDirection == CameraLensDirection.front);

    if (newDescription != null) {
      cameraDescription = newDescription;
      _initializationController();
    } else {
    CustomSnackBar.showMessage("No Camera Found");
    }
  }

  @override
  void onInit() {
    _initializationController();
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    cameraController.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
