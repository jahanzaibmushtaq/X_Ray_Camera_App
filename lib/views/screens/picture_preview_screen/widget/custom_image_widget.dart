import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({Key? key, required this.image}) : super(key: key);
  final String image;

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
                  child: Center(child: Image.asset(image)),
                ),
              ],
            );
          }),
    );
  }
}
