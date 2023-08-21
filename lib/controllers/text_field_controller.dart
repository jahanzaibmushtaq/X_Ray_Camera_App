import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageTextFieldController extends GetxController{



  final textValue = "".obs;
  final isBold = false.obs;
  final isItalic = false.obs;
  final  colors = const Color(0xffff0000).obs;


  void onChangeColor(Color color){
    colors(color);
  }

}