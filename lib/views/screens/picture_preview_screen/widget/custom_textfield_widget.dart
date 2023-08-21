import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';
import 'package:x_ray_scanner/controllers/image_preview_controller.dart';
import 'package:x_ray_scanner/controllers/text_field_controller.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({super.key, required this.index});
  final int index;
  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late ImageTextFieldController imageTextFieldController ;
  @override
  void initState() {
    imageTextFieldController = Get.find<ImageTextFieldController>(tag: "tagInstance${widget.index}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        notifier.value = m;
      },
      child: AnimatedBuilder(
          animation: notifier,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Transform(
                  transform: notifier.value,
                  child: Center(
                    child: Obx(()=>TextField(
                      onTap: () {
                        Get.find<ImagePreviewController>()
                            .onSelectField(widget.index);
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: "Enter text",
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20,
                          color: imageTextFieldController.colors.value,
                          fontWeight: imageTextFieldController.isBold.isTrue
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontStyle: imageTextFieldController.isItalic.value
                              ? FontStyle.italic
                              : FontStyle.normal),
                    )),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
