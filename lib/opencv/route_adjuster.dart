import 'package:flutter/services.dart';

class RouteAdjusterChannel {
  static const MethodChannel _channel =
      MethodChannel('com.allclimbing.all_climbing/route_adjuster');

  static Future<String> adjust(
      String filePath, int brightness, int saturation) async {
    var result = await _channel.invokeMethod('adjust', {
      'filePath': filePath,
      'brightness': brightness.toString(),
      'saturation': saturation.toString()
    });

    print(result);
    return result;
  }
}
