import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/exports/screens.dart';
import 'package:vascular_blood/theme/color.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class NeddleTable extends StatelessWidget {
  NeddleTable({super.key});
  final FlipCardController _controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    var tableValues = Get.arguments;
    final List? frontNeedle = tableValues.needlesFront;
    final List? backNeedle = tableValues.needlesback;

    Color hexToColor(String hexString) {
      hexString = hexString.replaceAll("#", ""); // Remove '#' if present
      if (hexString.length == 6) {
        hexString = "FF$hexString"; // Add full opacity (FF) if missing
      }
      return Color(int.parse(hexString, radix: 16));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.shade400,
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
                borderRadius: BorderRadius.circular(60),
                color: const Color.fromARGB(255, 244, 215, 215),
              ),
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
          "Needle Table",
          style: TextStyle(color: Colors.red, fontSize: 21),
        ),
      ),
      body: Stack(children: [
        Positioned(
          bottom: -40,
          left: 0,
          right: 0,
          child: Image.asset(
            "assets/images/pat2.png",
            fit: BoxFit.cover,
            height: 200,
          ),
        ),
        FlipCard(
          controller: _controller,
          flipOnTouch: true,
          direction: FlipDirection.HORIZONTAL,
          front: Container(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Details(),
                    const SizedBox(height: 20),
                    Table(
                      border: TableBorder.all(
                        borderRadius: BorderRadius.circular(5),
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Gauge',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Needle',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Length',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Color',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...(frontNeedle ?? []).map((needle) {
                          return TableRow(
                            decoration: BoxDecoration(
                              color: (frontNeedle!.indexOf(needle) % 2 == 0)
                                  ? Colors.white
                                  : Colors.grey.shade100,
                            ),
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${needle['gauge_number']}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "mm",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${needle['needle_od']}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "mm",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  "variable",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 25,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            hexToColor(needle['color_code'])),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          back: Container(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Details(),
                    const SizedBox(height: 20),
                    Table(
                      border: TableBorder.all(
                        borderRadius: BorderRadius.circular(5),
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Gauge',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Needle',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Length',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  'Color',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...(backNeedle ?? []).map((needle) {
                          return TableRow(
                            decoration: BoxDecoration(
                              color: (backNeedle!.indexOf(needle) % 2 == 0)
                                  ? Colors.white
                                  : Colors.grey.shade100,
                            ),
                            children: [
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${needle['gauge_number']}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "mm",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${needle['needle_od']}',
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "mm",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  "variable",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 25,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            hexToColor(needle['color_code'])),

                                    //  Text(
                                    //   needle['color'],
                                    //   style: const TextStyle(
                                    //     color: Colors.black87,
                                    //     fontSize: 18,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          "assets/images/red_needle.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Recommended Sizes",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "The following needle sizes are suggested based on the measured diameter",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500
                      //color: Colors.black87,
                      ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          // Updated WaveWidget Section
          SizedBox(
            height: 80, // Ensure enough height for the wave
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: WaveWidget(
                      config: CustomConfig(
                        gradients: [
                          [
                            LightThemeColor.primaryColor,
                            const Color(0xEEF44336)
                          ],
                          [Colors.red[800]!, const Color(0x77E57373)],
                          [
                            const Color.fromARGB(255, 230, 59, 59),
                            const Color.fromARGB(102, 184, 53, 53)
                          ],
                          [
                            const Color.fromARGB(255, 232, 35, 35),
                            const Color.fromARGB(255, 250, 113, 103)
                          ],
                        ],
                        durations: [35000, 19440, 10800, 6000],
                        heightPercentages: [0.20, 0.23, 0.25, 0.30],
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight,
                      ),
                      size: Size(
                        MediaQuery.of(context).size.width,
                        100, // Match the height of the parent
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
