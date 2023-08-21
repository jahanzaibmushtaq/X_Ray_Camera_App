import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hsv_color_pickers/hsv_color_pickers.dart';
import 'package:screenshot/screenshot.dart';
import 'package:x_ray_scanner/const/app_images.dart';
import 'package:x_ray_scanner/controllers/image_preview_controller.dart';

import 'widget/custom_bold_italic_checkbox_widget.dart';
import 'widget/custom_icon_button_widget.dart';

class PicturePreviewScreen extends StatefulWidget {
  const PicturePreviewScreen({Key? key, required this.imageFile})
      : super(key: key);
  final File imageFile;
  // final String selectedImage;
  @override
  State<PicturePreviewScreen> createState() => _PicturePreviewScreenState();
}

class _PicturePreviewScreenState extends State<PicturePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final imagePreviewController = Get.find<ImagePreviewController>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.blue),
          actions: [
            CircleAvatar(
              child: IconButton(icon: const Icon(Icons.undo),onPressed: ()=>imagePreviewController.onUndoList(),),

            ),            const SizedBox(width: 10,),
            CircleAvatar(
              child: IconButton(icon: const Icon(Icons.save),onPressed: ()=>imagePreviewController.onTakeScreenShotAndSave(),),

            ),
            const SizedBox(width: 10,)
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Expanded(
              child: Screenshot(
                controller: imagePreviewController.screenshotController,
                child: Stack(
                  children: [
                    ColorFiltered(
                        colorFilter: const ColorFilter.matrix(<double>[
                          -1.0, 0.0, 0.0, 0.0, 255.0, //
                          0.0, -1.0, 0.0, 0.0, 255.0, //
                          0.0, 0.0, -1.0, 0.0, 255.0, //
                          0.0, 0.0, 0.0, 1.0, 0.0, //
                        ]),
                        child: Image.file(
                          widget.imageFile,
                          width: Get.width,
                          fit: BoxFit.fill,
                        )),
                    Center(
                      child: Obx(
                        () => Stack(
                          children: List.generate(
                              imagePreviewController.widgetList.length,
                              (index) => imagePreviewController
                                  .widgetList[index].customImageWidget),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Obx(
                () => Visibility(
                  visible: imagePreviewController.isTextPanel.value ||
                      imagePreviewController.isStickerPanel.value,
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomIconButtonWidget(
                        function: () =>
                            imagePreviewController.onPressTextPanel(),
                        iconData: Icons.abc_outlined,
                      ),
                      CustomIconButtonWidget(
                        function: () =>
                            imagePreviewController.onPressStickerPanel(),
                        iconData: Icons.insert_emoticon_sharp,
                      ),
                    ],
                  ),
                  child: imagePreviewController.isTextPanel.isTrue
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    imagePreviewController.isTextPanel(false);
                                    FocusScope.of(context).unfocus();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: HuePicker(
                                      trackHeight: 10,
                                      thumbShape: const RoundSliderThumbShape(
                                          enabledThumbRadius: 13),
                                      controller:
                                          imagePreviewController.hueController,
                                      onChanged: (HSVColor color) {
                                        setState(() {
                                          imagePreviewController
                                              .onUpdateColor(color.toColor());
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      child: CustomBoldItalicCheckBoxWidget(
                                          imagePreviewController:
                                              imagePreviewController))
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () => imagePreviewController
                                      .isStickerPanel(false),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ),
                            SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    10,
                                    (index) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                              child: GestureDetector(
                                                onTap: ()=>imagePreviewController.onCreateImage("${AppImages.sticker}${index + 1}.png"),
                                                child: Image.asset(
                                            "${AppImages.sticker}${index + 1}.png",
                                            height: Get.height * 0.06,
                                            width: Get.height * 0.06,
                                          ),
                                              )),
                                        )),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
