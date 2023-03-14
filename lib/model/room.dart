class Room {
  int? uuid;
  String? name;
  String? device;

  Room({this.uuid, this.name, this.device});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      // uuid: json['uuid'],
      name: json['name_room'],
      // device: json['available_devices']
    );
  }
}
