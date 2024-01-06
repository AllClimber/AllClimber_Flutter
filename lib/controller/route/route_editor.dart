import 'dart:ui';

import 'package:image_picker/image_picker.dart';

class RouteEditor {
  XFile? image;

  bool attachImage({image = XFile}) {
    return true;
  }

  Color extractColor({x = double, y = double}) {
    return const Color.fromARGB(0, 120, 25, 32);
  }

  String filter({photoPath = String, color = String, sensitivity = int}) {
    return 'filteredImagePath';
  }
}
