import 'package:all_climbing/data/data_source/route_local_source.dart';
import 'package:all_climbing/data/data_source/route_remote_source.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/Route.dart';

class RouteRepository {

  final RouteLocalSource localDataSource;
  final RouteRemoteSource remoteDataSource;

  RouteRepository(this.localDataSource, this.remoteDataSource);

  Future<List<Route>> getRoutes() async {
    var localRoutes = localDataSource.getRoutes();
    if (localRoutes.isEmpty) {
      var remoteRoutes = await remoteDataSource.getRoutes();
      for (var route in remoteRoutes) {
        print('Name: ${route.name}, GymName: ${route.gymName}, Wall: ${route.wall}, Image: ${route.image}');
      }

      localDataSource.saveRoutes(remoteRoutes);
      return remoteRoutes ?? [];
    }
    return localRoutes;
  }

  Future<String?> uploadRouteImage(XFile? xFile) async {
    return await remoteDataSource.uploadRouteImage(xFile);
  }

  Future<bool> uploadRoute(Route route) async {
    return await remoteDataSource.uploadRoute(route);
  }
}
