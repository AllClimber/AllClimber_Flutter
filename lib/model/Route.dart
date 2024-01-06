class Route {
  final String gym;
  final String wall;
  final String name;
  final String image;

  Route({
    required this.gym,
    required this.wall,
    required this.name,
    required this.image,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      gym: json['gym'],
      wall: json['wall'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gym': gym,
      'wall': wall,
      'name': name,
      'image': image,
    };
  }
}