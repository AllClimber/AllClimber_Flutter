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
  } catch (e) {
    print("Error completing: $e");
  }
  return routesList;
}

  Future<bool> uploadRoute(Route route) async {
    try {
      var documentReference = await db.collection('routes').add(route.toJson());
      print("Uploaded route with ID: ${documentReference.id}");
      return true;
    } catch (e) {
      print("Error uploading route: $e");
      return false;
    }
  }
}
