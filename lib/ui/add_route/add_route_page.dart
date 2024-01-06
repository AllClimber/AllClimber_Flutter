import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/route/AddRouteController.dart';
import 'route_image_edit_widget.dart';

class AddRoutePage extends StatelessWidget {
  final controller = Get.put(AddRouteController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Route'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RouteImageEditWidget(),
            TextField(
              controller: controller.gymController,
              decoration: const InputDecoration(labelText: 'Climbing Gym Name'),
            ),
            TextField(
              controller: controller.wallController,
              decoration: const InputDecoration(labelText: 'Wall Sector Name'),
            ),
            TextField(
              controller: controller.routeController,
              decoration: const InputDecoration(labelText: 'Route Name'),
            ),
            ElevatedButton(
              onPressed: controller.uploadRoute,
              child: const Text('Upload Route'),
            ),
          ],
        ),
      ),
    );
  }
}
