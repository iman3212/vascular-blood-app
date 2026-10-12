import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartTest extends StatefulWidget {
  const ChartTest({
    super.key,
    required this.finner,
    required this.fouter,
    required this.fcenter,
    required this.binner,
    required this.bouter,
    required this.bcenter,
  });

  final double finner;
  final double fouter;
  final double fcenter;
  final double binner;
  final double bouter;
  final double bcenter;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<ChartTest> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 170, // افزایش عرض نمودار
        height: 170, // افزایش ارتفاع نمودار
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 30, // افزایش فضای مرکزی
                sections: showingSections(),
              ),
            ),
            Center(
              child: Text('', // تغییر متن مرکزی
                  style: const TextStyle(
                    fontSize: 18, // افزایش اندازه فونت
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0; // تنظیم اندازه فونت
      final radius = isTouched ? 40.0 : 30.0; // تنظیم شعاع بخش‌ها
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      // Define the new ARGB colors
      List<Color> donutChartColors = [
        Color.fromARGB(255, 246, 3, 3), // Deep Sky Blue
        Color.fromARGB(255, 212, 49, 49), // Deep Sky Blue
        Color.fromARGB(255, 246, 83, 83), // Deep Sky Blue
        // Deep Sky Blue
        // Deep Sky Blue
        Color.fromARGB(255, 18, 18, 18),
        Color.fromARGB(255, 89, 88, 89),
        Color.fromARGB(255, 184, 182, 185),
        // Salmon
      ];

      return PieChartSectionData(
        color: donutChartColors[i], // Use the new colors
        value: _getValueForIndex(i), // Replace with your logic to get values
        // title: _getTitleForIndex(i)
        title: _getTitleForIndex(i), // Replace with your logic to get titles
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

// Helper methods to get values and titles based on the index
  double _getValueForIndex(int index) {
    switch (index) {
      case 0:
        return widget.finner.toDouble();
      case 1:
        return widget.fouter.toDouble();
      case 2:
        return widget.fcenter.toDouble();
      case 3:
        return widget.binner.toDouble();
      case 4:
        return widget.bouter.toDouble();
      case 5:
        return widget.bcenter.toDouble();
      default:
        throw Error();
    }
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return widget.finner.toString();
      case 1:
        return widget.fouter.toString();
      case 2:
        return widget.fcenter.toString();
      case 3:
        return widget.binner.toString();
      case 4:
        return widget.bouter.toString();
      case 5:
        return widget.bcenter.toString();
      default:
        throw Error();
    }
  }
}
