import 'package:get/get_connect/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/Route.dart';

class RouteRemoteSource extends GetConnect {

  var db = FirebaseFirestore.instance;
  
  Future<List<Route>> getRoutes() async {
  List<Route> routesList = [];
  try {
    var querySnapshot = await db.collection("routes").get();
    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
      var route = await Route.fromJson(docSnapshot.data() as Map<String, dynamic>);
      routesList.add(route);
    }
    print("Successfully completed");
  } catch (e) {
    print("Error completing: $e");
  }
  return routesList;
}

  Future<bool> uploadRoute(Route route) async {
    return true;
    var response = await post('http://localhost:1234.com', route);
    return response.isOk;
  }
}
