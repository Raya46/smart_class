class Room {
  String? uuid;
  String? name;
  int? device;

  Room({required this.uuid, this.name, this.device});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      uuid: json['uuid'],
      name: json['name_room'],
      // device: json['available_devices']
    );
  }
}
