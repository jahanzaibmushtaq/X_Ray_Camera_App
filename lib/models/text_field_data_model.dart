import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:x_ray_scanner/controllers/image_preview_controller.dart';
import 'package:x_ray_scanner/controllers/text_field_controller.dart';
import 'package:x_ray_scanner/views/screens/picture_preview_screen/widget/custom_textfield_widget.dart';

class ImageWidgetDataModel {
  Widget customImageWidget;
  ImageTextFieldController imageTextFieldTag;
  int index;
  ImageWidgetDataModel(
      { required this.imageTextFieldTag,
      required this.customImageWidget,
      required this.index});
}
