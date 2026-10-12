import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:get/get.dart'; // For Get.back()
import 'package:vascular_blood/routes/route.dart';
import 'package:vascular_blood/screens/result/indicator.dart';
import 'package:vascular_blood/screens/result/pie-chart.dart';

class GeneralResults extends StatelessWidget {
  final arg = Get.arguments;

  GeneralResults({super.key});

  @override
  Widget build(BuildContext context) {
    final frontInner = arg.frontInnerDiameter != null
        ? arg.frontInnerDiameter.toString()
        : 'N/A';
    final backInner = arg.backInnerDiameter != null
        ? arg.backInnerDiameter.toString()
        : 'N/A';
    final frontOuter = arg.frontExternalDiameter != null
        ? arg.frontExternalDiameter.toString()
        : 'N/A';
    final backOuter = arg.backExternalDiameter != null
        ? arg.backExternalDiameter.toString()
        : 'N/A';
    final frontCenter = arg.concentricFront == true ? 'Yes' : 'No';
    final backCenter = arg.concentricBack == true ? 'Yes' : 'No';
    final finalFlag = arg.finalFlag ? 'Pass' : 'Fail';
    final date = arg.date ?? 'N/A';
    final frontFlag = arg.frontFlag ? 'Pass' : 'Fail';
    final backFlag = arg.backFlag ? 'Pass' : 'Fail';
    //pie chart
    final innerFrontError = arg.innerFrontError;
    final outerFrontError = arg.outerFrontError;
    final centerFrontError = arg.centerFrontError;
    final innerBackError = arg.innerBackError;
    final outerBackError = arg.outerBackError;
    final centerBackError = arg.centerBackError;
//chart
    final frontInneCh = arg.frontInnerDiameter ?? 0;
    final frontOuterCh = arg.frontExternalDiameter ?? 0;
    final backInnerCh = arg.backInnerDiameter ?? 0;
    final backOuterCh = arg.backExternalDiameter ?? 0;

    final Map<String, double> reportData = {
      'Front ID': frontInneCh,
      'Front OD': frontOuterCh,
      'Back ID': backInnerCh,
      'Back OD': backOuterCh,
    };

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Overall Result",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(7.0),
              child: InkWell(
                onTap: () {
                  if (arg != null) {
                    Get.toNamed(Routes.needletable, arguments: arg);
                  } else {
                    return;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/images/needle.png',
                    width: 35,
                    height: 35,
                  ),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Result Cards and Quality Control
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResultCard(
                  side: 'Front Side',
                  inner: frontInner,
                  outer: frontOuter,
                  center: frontCenter,
                  flag: frontFlag,
                  colrorIndex: 0,
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    child: VerticalDivider(
                      color: Colors.grey.shade300,
                    )),
                ResultCard(
                  side: 'Back side',
                  inner: backInner,
                  outer: backOuter,
                  center: backCenter,
                  flag: backFlag,
                  colrorIndex: 1,
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.all(5), // فاصله از تصویر
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ستون متن
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overall QC Assurance',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4), // فاصله بین متن‌ها
                        Row(
                          children: [
                            const Icon(
                              Icons.lock_clock,
                              size: 20,
                            ),
                            const SizedBox(width: 4), // فاصله بین آیکون و متن
                            Text(
                              'Time : ${date.toString().split('T').first}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ستون دکمه
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          finalFlag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Divider(
              color: Colors.grey.shade300,
            ),
            const Text(
              'Vessel Diameter Errors',
              style: TextStyle(fontSize: 17),
            ),

            // Middle Section: Pie Charts
            SizedBox(
                        height: MediaQuery.of(context).size.height*0.15,

               child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Front',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 246, 3, 3),
                                    text: 'Inner',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 212, 49, 49),
                                    text: 'Outer',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 246, 83, 83),
                                    text: 'Center',
                                    isSquare: true,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 18, 18, 18),
                                    text: 'Inner',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 89, 88, 89),
                                    text: 'Outer',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Indicator(
                                    color: Color.fromARGB(255, 184, 182, 185),
                                    text: 'Center',
                                    isSquare: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: ChartTest(
                        finner: innerFrontError,
                        fouter: outerFrontError,
                        fcenter: centerFrontError,
                        binner: innerBackError,
                        bouter: outerBackError,
                        bcenter: centerBackError,
                      ),
                    ),
                  ],
                )),

            // Bottom Section: Bar Chart

            Divider(
              color: Colors.grey.shade300,
            ),

            const Text(
              'Diameter Comparison',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Text(
              ' Inner and Outer Diameter Measurements',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
              child: Flexible(
                  child: Chart(
                padding: const EdgeInsets.all(8),
                layers: [
                  ChartAxisLayer(
                    settings: ChartAxisSettings(
                      x: ChartAxisSettingsAxis(
                        frequency: 1.0,
                        max: reportData.length.toDouble(),
                        min: 1.0,
                        textStyle: TextStyle(
                          color: Colors.grey.shade700, // تغییر رنگ متن محور X
                          fontSize: 11.0,
                        ),
                      ),
                      y: ChartAxisSettingsAxis(
                        frequency: 1.0,
                        max: reportData.values
                            .reduce((a, b) => a > b ? a : b)
                            .toDouble(),
                        min: 0.0,
                        textStyle: TextStyle(
                          color: Colors.grey.shade700, // تغییر رنگ متن محور Y
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    labelX: (value) {
                      int index = value.toInt() - 1;
                      if (index >= 0 && index < reportData.keys.length) {
                        return reportData.keys.elementAt(index);
                      }
                      return "";
                    },
                    labelY: (value) => value.toInt().toString(),
                  ),
                  ChartBarLayer(
                    items: reportData.entries
                        .map((e) => ChartBarDataItem(
                              value: e.value.toDouble(),
                              x: reportData.keys.toList().indexOf(e.key) + 1,
                              color: Colors.primaries[
                                  reportData.keys.toList().indexOf(e.key) %
                                      Colors.primaries.length],
                            ))
                        .toList(),
                    settings: const ChartBarSettings(
                      thickness: 12.0,
                      radius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ],
              )
                  // Chart(
                  //   padding: const EdgeInsets.all(8),
                  //   layers: [
                  //     ChartAxisLayer(
                  //       settings: ChartAxisSettings(
                  //         x: ChartAxisSettingsAxis(
                  //           frequency: 1.0,
                  //           max: reportData.length.toDouble(),
                  //           min: 1.0,
                  //           textStyle: TextStyle(
                  //             color: Colors.grey.shade400,
                  //             fontSize: 11.0,
                  //           ),
                  //         ),
                  //         y: ChartAxisSettingsAxis(
                  //           frequency: 1.0,
                  //           max: reportData.values
                  //               .reduce((a, b) => a > b ? a : b)
                  //               .toDouble(),
                  //           min: 0.0,
                  //           textStyle: TextStyle(
                  //             color: Colors.grey.shade500,
                  //             fontSize: 10.0,
                  //           ),
                  //         ),
                  //       ),
                  //       labelX: (value) {
                  //         int index = value.toInt() - 1;
                  //         if (index >= 0 && index < reportData.keys.length) {
                  //           return reportData.keys.elementAt(index);
                  //         }
                  //         return "";
                  //       },
                  //       labelY: (value) => value.toInt().toString(),
                  //     ),
                  //     ChartBarLayer(
                  //       items: reportData.entries
                  //           .map((e) => ChartBarDataItem(
                  //                 value: e.value.toDouble(),
                  //                 x: reportData.keys.toList().indexOf(e.key) + 1,
                  //                 color: Colors.red,
                  //               ))
                  //           .toList(),
                  //       settings: const ChartBarSettings(
                  //         thickness: 12.0,
                  //         radius: BorderRadius.all(Radius.circular(10.0)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.side,
    required this.inner,
    required this.outer,
    required this.center,
    required this.flag,
    required this.colrorIndex,
  });

  final String side;
  final String inner;
  final String outer;
  final String center;
  final String flag;
  final int colrorIndex;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  side,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 5),
            Text(
              'Inner: $inner (mm)',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            Text(
              'Outer: $outer (mm)',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            Text(
              'Center: $center',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 7),
            Container(
              decoration: BoxDecoration(
                color: flag == 'Fail' ? Colors.red : Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
