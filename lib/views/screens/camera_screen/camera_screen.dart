import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_ray_scanner/controllers/camera_controller.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({Key? key}) : super(key: key);
  final CameraHomeController cameraHomeController =
      Get.find<CameraHomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => cameraHomeController.isException.isFalse
            ? cameraHomeController.isWait.isFalse
                ? Stack(
                    children: [
                      SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.matrix(<double>[
                            -1.0, 0.0, 0.0, 0.0, 255.0, //
                            0.0, -1.0, 0.0, 0.0, 255.0, //
                            0.0, 0.0, -1.0, 0.0, 255.0, //
                            0.0, 0.0, 0.0, 1.0, 0.0, //
                          ]),
                          child: CameraPreview(
                              cameraHomeController.cameraController),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.black38),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center ,
                            children: [
                              const SizedBox(),
                              IconButton(
                                  onPressed: () =>
                                      cameraHomeController.captureImage(),
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                    size: 50,
                                  )),
                              IconButton(
                                  onPressed: () =>
                                      cameraHomeController.toggleCameraLens(),
                                  icon: const Icon(
                                    Icons.cameraswitch_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )
            : const Center(
                child: Text("Camera Not Response"),
              )),
      ),
    );
  }
}
