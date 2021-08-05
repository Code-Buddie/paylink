class ParkingInfo{
  final String carPlates;
  final String amount;
  final String area;

  ParkingInfo(this.carPlates, this.amount, this.area);

  @override
  String toString() {
    return 'carPlates: $carPlates, amount: $amount, area: $area';
  }

  factory ParkingInfo.fromJson(Map<String, dynamic> json) {
    return ParkingInfo(json['carPlates'],'200',json['area']  );
  }
}