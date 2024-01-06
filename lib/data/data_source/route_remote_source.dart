import 'package:get/get_connect/connect.dart';

import '../../model/Route.dart';

class RouteRemoteSource extends GetConnect {
  List<Route> getRoutes() {
    return List.empty();
  }

  Future<bool> uploadRoute(Route route) async {
    return true;
    var response = await post('http://localhost:1234.com', route);
    return response.isOk;
  }
}
