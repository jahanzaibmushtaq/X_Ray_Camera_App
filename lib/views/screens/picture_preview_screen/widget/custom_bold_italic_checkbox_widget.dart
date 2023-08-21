import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_ray_scanner/controllers/image_preview_controller.dart';

class CustomBoldItalicCheckBoxWidget extends StatelessWidget {
  const CustomBoldItalicCheckBoxWidget({
    super.key,
    required this.imagePreviewController,
  });

  final ImagePreviewController imagePreviewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
        ()=> Checkbox(
            onChanged: (value) {
              imagePreviewController
                  .widgetList[imagePreviewController
                  .currentIndex.value]
                  .imageTextFieldTag
                  .isBold(value);
            },
            value: imagePreviewController
                .widgetList[imagePreviewController
                .currentIndex.value]
                .imageTextFieldTag
                .isBold
                .value,
          ),
        ),
        const Text("Bold"),
        Obx(
        ()=> Checkbox(
            onChanged: (value) {
               imagePreviewController
                  .widgetList[imagePreviewController
                  .currentIndex.value]
                  .imageTextFieldTag
                  .isItalic
                (value);
            },
            value: imagePreviewController
                .widgetList[imagePreviewController
                .currentIndex.value]
                .imageTextFieldTag
                .isItalic
                .value,
          ),
        ),
        const Text("Italic")
      ],
    );
  }
}
