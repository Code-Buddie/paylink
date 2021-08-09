class Area {
  final int id;
  final String name;

  Area(this.id, this.name);

  @override
  String toString() {
    return 'id: $id, name:  $name';
  }

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(json['id'], json['name']);
  }
}
