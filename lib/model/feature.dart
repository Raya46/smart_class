class Feature {
  final int id;
  final String name;

  Feature({required this.id, required this.name});

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      name: json['name_feature'],
    );
  }
}