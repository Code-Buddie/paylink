class Area{
  final String name;

  Area(this.name);

  @override
  String toString() {
    return 'area:  $name';
  }

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(json['name'] );
  }
}