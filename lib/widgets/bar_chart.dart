import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class BarChartWidget extends StatefulWidget {

  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final List points = [
    const FlSpot(0, 3),
    const FlSpot(2, 5),
    const FlSpot(4, 7),
    const FlSpot(6, 9),
    const FlSpot(8, 11),
    const FlSpot(10, 9),
    const FlSpot(12, 7),
    const FlSpot(12, 5),
    const FlSpot(12, 5),
    const FlSpot(12, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
            barGroups: _chartGroups(),
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide())),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false), ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
          ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    return points.map((point) =>
      BarChartGroupData(
        x: point.x.toInt(),
        barRods: [
          BarChartRodData(
            toY: point.y,
            color: const Color.fromARGB(200, 21, 21, 21),
          )
        ]
      )

    ).toList();
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: false,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Jan';
          break;
        case 2:
          text = 'Mar';
          break;
        case 4:
          text = 'May';
          break;
        case 6:
          text = 'Jul';
          break;
        case 8:
          text = 'Sep';
          break;
        case 10:
          text = 'Nov';
          break;
      }

      return Text(text);
    },
  );
}