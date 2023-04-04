import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WalkingData {
  final DateTime time;
  final double steps;

  WalkingData(this.time, this.steps);
}

class WalkingGraph extends StatelessWidget {
  final List<WalkingData> walkingData = [
    WalkingData(DateTime(2023, 4, 1, 10), 0),
    WalkingData(DateTime(2023, 4, 1, 12), 500),
    WalkingData(DateTime(2023, 4, 1, 14), 1500),
    WalkingData(DateTime(2023, 4, 1, 16), 3000),
    WalkingData(DateTime(2023, 4, 1, 18), 5000),
    WalkingData(DateTime(2023, 4, 1, 20), 7000),
  ];

   WalkingGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final seriesList = [
      charts.Series<WalkingData, DateTime>(
        id: 'Steps',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WalkingData data, _) => data.time,
        measureFn: (WalkingData data, _) => data.steps,
        data: walkingData,
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      animationDuration: const Duration(milliseconds: 500),
      domainAxis: const charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(format: 'h a', transitionFormat: 'h a'),
        ),
      ),
      // primaryMeasureAxis: const charts.NumericAxisSpec(
      //   tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
      //     (measure) {
            
      //     },
      //   ),
      // ),
    );
  }
}
