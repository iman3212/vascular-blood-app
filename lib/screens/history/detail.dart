import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/global/globalwidgets/Result/detect_fail.dart';
import 'package:vascular_blood/global/globalwidgets/Result/fail_check.dart';
import 'package:vascular_blood/global/globalwidgets/Result/pass_check.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/image-dialog.dart';

class DetailHistory extends StatelessWidget {
  final data = Get.arguments;

  DetailHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxCheck = size.width < 360 ? true : false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color.fromARGB(255, 248, 228, 227)),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bar_chart,
                  color: Colors.white,
                ),
                SizedBox(width: size.width * 0.01),
                Text(
                  "QC Results",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  //  Get.toNamed(Routes.needletable, arguments: data);
                },
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: -size.height * 0.14,
              child: Image.asset(
                "assets/images/pat1.jpg",
                width: size.width,
                fit: BoxFit.cover, // Ensure image fits within the screen
              ),
            ),
            FlipCard(
                front: CardWidget(
                  size: size,
                  data: data,
                  maxCheck: maxCheck,
                  side: 0, // Front side
                ),
                back: CardWidget(
                  size: size,
                  data: data,
                  maxCheck: maxCheck,
                  side: 1, // Back side
                ))
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.size,
    required this.data,
    required this.maxCheck,
    required this.side,
  });

  final Size size;
  final dynamic data;
  final bool maxCheck;
  final int side; // 0 for front, 1 for back

  // Helper methods to check conditions based on side and key
  bool isBothNull() {
    if (data.key == "parameter") {
      return side == 0
          ? data.widthResult == null && data.heightResult == null
          : data.widthResultBack == null && data.heightResultBack == null;
    } else {
      return side == 0
          ? data.innerFrontDiameter == null &&
              data.externalFrontDiameter == null
          : data.innerBackDiameter == null && data.externalBackDiameter == null;
    }
  }

  bool showFirstContent() {
    return side == 0
        ? data.widthResult == null && data.externalFrontDiameter == null
        : data.widthResult == null && data.externalBackDiameter == null;
  }

  bool showSecondContent() {
    return side == 0
        ? data.innerFrontDiameter == null && data.heightResult == null
        : data.innerBackDiameter == null && data.heightResult == null;
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = side == 0 ? data.front : data.back;
    final inner = side == 0 ? data.innerFrontDiameter : data.innerBackDiameter;
    final external =
        side == 0 ? data.externalFrontDiameter : data.externalBackDiameter;
    final center = side == 0 ? data.concentricFront : data.concentricBack;
    final pass = side == 0 ? data.flagFront : data.flagBack;
    final bothNull = isBothNull();
    final showContent = showFirstContent();
    final showContent2 = showSecondContent();

    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(side == 0 ? 'Front Side Result' : 'Back Side Result'),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                final imageUrl = imagePath != null
                    ? 'http://vascular.hitechprojects.ir:8300$imagePath'
                    : "assets/images/vessel.jpg";
                showDialog(
                    context: context,
                    builder: (_) => ImageDialog(pic: imageUrl));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://vascular.hitechprojects.ir:8300$imagePath',
                    height: size.height * 0.32, // Responsive height
                    width: size.width, // Full width of screen
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(color: Colors.black, width: 1)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/vessel.jpg",
                            height: size.height * 0.32, // Responsive height
                            width: size.width, // Full width of screen
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            bothNull
                ? Container()
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                    ],
                  ),
            bothNull
                ? DetectFail(size: size)
                : SizedBox(
                    height:
                        size.height * 0.4, // Set a height for the parent widget
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              pass
                                  ? Pass(size: size)
                                  : Fail(
                                      size: size,
                                    ),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              Flexible(
                                child: Container(
                                  height:
                                      size.height * 0.25, // Responsive height
                                  width: size.width * 0.4, // Responsive width
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: showContent
                                        ? const _buildNoDetectionMassage()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade400,
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Image.asset(
                                                        data.key == "diameter"
                                                            ? "assets/images/external.png"
                                                            : "assets/images/width.png",
                                                        width:
                                                            size.width * 0.06,
                                                        height:
                                                            size.width * 0.06,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    data.key == "diameter"
                                                        ? "OD (mm)"
                                                        : 'width',
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.grey.shade300,
                                              ),
                                              Text(
                                                "External diameter of the artificial vessel",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 1),
                                                      child: Text(
                                                        external != null
                                                            ? "$external"
                                                            : "${data.widthResult}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.grey.shade300,
                          thickness: 1, // Set thickness
                          width: 20, // Set width
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CenterWidget(
                                size: size,
                                center: center,
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                              ),
                              Flexible(
                                child: Container(
                                  height: size.height * 0.22,
                                  width: size.width * 0.44,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: showContent2
                                        ? const _buildNoDetectionMassage()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade300,
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child: Image.asset(
                                                          data.key == "diameter"
                                                              ? "assets/images/inner.png"
                                                              : "assets/images/length.png",
                                                          width:
                                                              size.width * 0.06,
                                                          height:
                                                              size.width * 0.06,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                      data.key == "diameter"
                                                          ? "ID (mm)"
                                                          : 'Length',
                                                      style: const TextStyle(
                                                          fontSize: 17)),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.grey.shade300,
                                              ),
                                              Text(
                                                "Internal diameter of the artificial vessel",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              const SizedBox(height: 25),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 1),
                                                      child: Text(
                                                        data.key == "diameter"
                                                            ? "$inner"
                                                            : "${data.heightResult}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }
}

class _buildNoDetectionMassage extends StatelessWidget {
  const _buildNoDetectionMassage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detection Failed",
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Unable to detect the internal diameter in the image.",
            style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class CenterWidget extends StatelessWidget {
  const CenterWidget({
    super.key,
    required this.size,
    required this.center,
  });

  final Size size;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color statusColor = center ? Colors.green : Colors.red;
    final String statusText = center ? "YES" : "NO";
    return Container(
      height: size.height * 0.17,
      width: size.width * 0.43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/center.png",
                        width: size.width * 0.06,
                        height: size.width * 0.06,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  "Centrality",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Located at the center",
              style: textTheme.bodySmall!.copyWith(color: Colors.grey.shade700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Divider(color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: statusColor,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                        statusText,
                        style: textTheme.bodySmall!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
