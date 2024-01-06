import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:all_climbing/controller/route/AddRouteController.dart';
import 'package:all_climbing/controller/route/route_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RouteImageEditWidget extends StatelessWidget {
  final AddRouteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) async {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset localPosition =
                renderBox.globalToLocal(details.globalPosition);
            controller.getImageColor(localPosition);
          },
          child: Center(
            child: Obx(() => controller.image.value == null
                ? const Text('No image selected.')
                : Image.file(
                    File(controller.image.value!.path),
                    height: 300,
                    fit: BoxFit.fitHeight,
                  )),
          ),
        ),
        Obx(
          () => controller.tappedColor.value == null
              ? const Text('No color selected.')
              : Container(
                  height: 50,
                  color: controller.tappedColor.value,
                  child: Center(
                    child:
                        Text('Tapped color: ${controller.tappedColor.value}'),
                  ),
                ),
        ),
        Obx(
          () => Slider(
            value: controller.sensitivity.value,
            min: 0,
            max: 100,
            divisions: 100,
            label: controller.sensitivity.value.round().toString(),
            onChanged: controller.changeSensitivity,
          ),
        ),
        ElevatedButton(
          onPressed: controller.pickImage,
          child: const Text('Select Image'),
        ),
      ],
    );
  }
}
