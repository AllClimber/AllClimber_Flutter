import 'dart:ui';

import 'package:all_climbing/opencv/route_adjuster.dart';
import 'package:image_picker/image_picker.dart';

class RouteEditor {
  XFile? image;

  bool attachImage({image = XFile}) {
    return true;
  }

  Color extractColor({x = double, y = double}) {
    return const Color.fromARGB(0, 120, 25, 32);
  }

  Future<String> filter(
      {photoPath = String, color = String, sensitivity = int}) async {
    var result =
        RouteAdjusterChannel.adjust(photoPath, 100,-100);
    return result;
  }
}
