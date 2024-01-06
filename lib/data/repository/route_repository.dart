import 'package:all_climbing/data/data_source/route_local_source.dart';
import 'package:all_climbing/data/data_source/route_remote_source.dart';

import '../../model/Route.dart';

class RouteRepository {

  final RouteLocalSource localDataSource;
  final RouteRemoteSource remoteDataSource;

  RouteRepository(this.localDataSource, this.remoteDataSource);

  Future<List<Route>> getRoutes() async {
    var localRoutes = localDataSource.getRoutes();
    if (localRoutes.isEmpty) {
      var remoteRoutes = remoteDataSource.getRoutes();
      localDataSource.saveRoutes(remoteRoutes);
      return remoteRoutes ?? [];
    }
    return localRoutes;
  }

  Future<bool> uploadRoute(Route route) async {
    return await remoteDataSource.uploadRoute(route);
  }
}
