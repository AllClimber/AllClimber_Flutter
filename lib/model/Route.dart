class Route {
  final String name;
  final String wall;
  final String grade;
  final String image;
  final String gymId;
  final String gymName;

  Route({
    required this.name,
    required this.wall,
    required this.grade,
    required this.image,
    required this.gymId,
    required this.gymName,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      name: json['name'],
      wall: json['wall'],
      grade: json['grade'],
      image: json['image'],
      gymId: json['gymId'],
      gymName: json['gymName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wall': wall,
      'grade': grade,
      'image': image,
      'gymId': gymId,
      'gymName': gymName,
    };
  }
}