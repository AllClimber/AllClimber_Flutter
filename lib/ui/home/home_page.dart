import 'package:all_climbing/data/data_source/route_local_source.dart';
import 'package:all_climbing/data/data_source/route_remote_source.dart';
import 'package:all_climbing/data/repository/route_repository.dart';
import 'package:all_climbing/model/Route.dart';
import 'package:all_climbing/ui/add_route/add_route_page.dart';
import 'package:all_climbing/ui/base/export.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RouteLocalSource localDataSource = RouteLocalSource();
  final RouteRemoteSource remoteDataSource = RouteRemoteSource();
  late RouteRepository routeRepository =
      RouteRepository(localDataSource, remoteDataSource);

  void _addRoute() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRoutePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CustomScrollBody(
        children: [
          CustomFutureBuilder(
            future: routeRepository.getRoutes(),
            successBuilder: (context, routes) {
              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var route = routes[index];
                  return RouteItem(route: route);
                },
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.black12,
                  height: 0,
                ),
                itemCount: routes.length,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRoute,
        tooltip: 'Add new route',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  const RouteItem({
    super.key,
    required this.route,
  });

  final dynamic route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 72,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  route.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                route.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                "${route.gymName} - ${route.wall}",
                style: const TextStyle(fontSize: 13),
              ),
            ],
          )
        ],
      ),
    );
  }
}
