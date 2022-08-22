enum BusType {
  VVIP(45, 'assets/images/b4.png', 'assets/images/bus2.png'),
  STC(20, 'assets/images/b1.png', 'assets/images/B3.png'),
  FORD(30, 'assets/images/b5.png', 'assets/images/bus1.png'),
  VIP(40, 'assets/images/b6.png', 'assets/images/bus4.png');

  const BusType(this.maxCapacity, this.icon, this.busImage);
  final int maxCapacity;
  final String icon;
  final String busImage;
}
