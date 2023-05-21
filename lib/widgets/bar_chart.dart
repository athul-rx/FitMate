// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class BarChartWidget extends StatefulWidget {
  
  bool showtitle = false;
  BarChartWidget({Key? key, required this.showtitle }) : super(key: key);

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
            color: const Color.fromARGB(255, 81, 81, 81),
          )
        ]
      )

    ).toList();
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: widget.showtitle,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = '12\nam';
          break;
        case 2:
          text = '';
          break;
        case 4:
          text = '12\npm';
          break;
        case 6:
          text = '';
          break;
        case 8:
          text = '';
          break;
        case 10:
          text = '12\nam';
          break;
      }

      return Text(text);
    },
  );
}