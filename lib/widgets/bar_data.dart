import 'package:fitmate/widgets/individual_bar.dart';

class BarData {
  final int sun;
  final int mon;
  final int tue;
  final int wed;
  final int thu;
  final int fri;
  final int sat;

  BarData({
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
  });

  void initializeBarData() {
    IndividualBar(x: 0, y: sun);
    IndividualBar(x: 1, y: mon);
    IndividualBar(x: 2, y: tue);
    IndividualBar(x: 3, y: wed);
    IndividualBar(x: 4, y: thu);
    IndividualBar(x: 5, y: fri);
    IndividualBar(x: 6, y: sat);

  }
}
