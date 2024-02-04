// 📦 Package imports:
import 'package:all_climbing/ui/home/home_page.dart';
import 'package:all_climbing/ui/add_route/add_route_page.dart';
import 'package:get/route_manager.dart';

List<GetPage> routes = [
  GetPage(name: "/", page: () => const HomePage()),
  GetPage(name: "/routes/add", page: () => AddRoutePage()),
];
