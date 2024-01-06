import 'package:all_climbing/controller/route/route_editor.dart';
import 'package:all_climbing/data/repository/route_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/Route.dart' as route_model;

class AddRouteController extends GetxController {
  var originalImage = Rxn<XFile?>();
  var image = Rxn<XFile?>();
  var filteredImage = Rxn<XFile?>();
  var tappedColor = Rxn<Color?>();
  var sensitivity = 50.0.obs;

  final ImagePicker picker = ImagePicker();
  final RouteEditor routeEditor = RouteEditor();

  final TextEditingController gymController = TextEditingController();
  final TextEditingController wallController = TextEditingController();
  final TextEditingController routeController = TextEditingController();

  void pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    image.value = pickedImage;
    tappedColor.value = null;
  }

  void getImageColor(Offset localPosition) async {
    tappedColor.value =
        routeEditor.extractColor(x: localPosition.dx, y: localPosition.dy);
  }

  void changeSensitivity(double value) {
    sensitivity.value = value;
    filterImage();
  }

  void filterImage() async {
    final String? image = originalImage.value?.path;
    if (image == null) return;

    final Color? color = tappedColor.value;
    if (color == null) return;

    final int sensitivity = this.sensitivity.value.toInt();

    final String filteredImage =
        await routeEditor.filter(photoPath: image, color: color, sensitivity: sensitivity);

    this.filteredImage.value = XFile(filteredImage);
  }

  void uploadRoute() async {
    final String? image = filteredImage.value?.path;
    if (image == null) return;

    final String gym = gymController.text;
    final String wall = wallController.text;
    final String routeName = routeController.text;

    var result =
        await Get.find<RouteRepository>().uploadRoute(route_model.Route(
      gym: gym,
      wall: wall,
      name: routeName,
      image: image,
    ));

    if (result) {
      Get.snackbar('Success', 'Route uploaded successfully', duration: 1.seconds);
      Get.back();
    } else {
      Get.snackbar('Error', 'Route upload failed').show();
    }
  }
}
