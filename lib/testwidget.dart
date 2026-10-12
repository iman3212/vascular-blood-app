import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/global/globalwidgets/Result/detect_fail.dart';
import 'package:vascular_blood/routes/route.dart';

class FuckingTest extends StatelessWidget {
  FuckingTest({super.key});

  final FlipCardController _controller = FlipCardController();
  var overall = null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxCheck = size.width < 360 ? true : false;

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: InkWell(
                  onTap: () {
                    Get.offNamed(Routes.menu);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),

              title: const Text(
                "QC Results",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () {
                        overall != null
                            ? Get.toNamed(Routes.general, arguments: overall)
                            : print('');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          'assets/images/res.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    )
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.table_rows,
                    //     color: Colors.white,
                    //     size: 30,
                    //   ),
                    //   onPressed: () {
                    //     if (reController.data.value != null) {
                    //       print('${reController.data.value.diameter}');
                    //       Get.toNamed(Routes.needletable,
                    //           arguments: reController.data.value.diameter);
                    //     } else {
                    //       return;
                    //     }
                    //   },
                    // ),
                    )
              ],
            ),
            body: Stack(children: [
              Positioned(
                  bottom: -120,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/pat2.png',
                    width: MediaQuery.of(context).size.width,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(20, size.height * 0.015, 20, 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuHeader(
                            title: 'Front Side',
                            onTap: () {
                              // reController.selectedItem.value = 0;
                              _controller.toggleCard();
                            },
                            index: 0,
                          ),
                          MenuHeader(
                            title: 'Back Side',
                            onTap: () {
                              _controller.toggleCard();
                            },
                            index: 1,
                          ),
                          MenuHeader(
                            title: 'Overall',
                            onTap: () {
                              overall != null
                                  ? Get.toNamed(Routes.general,
                                      arguments: overall)
                                  : print('');
                            },
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FlipCard(
                      controller: _controller,
                      flipOnTouch: true,
                      direction: FlipDirection.HORIZONTAL,
                      back: Card1(
                        size: size,
                        maxCheck: maxCheck,
                      ),
                      front: Card2(
                        size: size,
                        maxCheck: maxCheck,
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({
    super.key,
    required this.title,
    required this.onTap,
    required this.index,
  });
  final String title;
  final onTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )),
    );
  }
}

class Card1 extends StatelessWidget {
  const Card1({
    super.key,
    required this.size,
    required this.maxCheck,
  });

  final Size size;
  final bool maxCheck;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
        ),
        true
            ? Container()
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
        // isNullCheck
        true ? DetectFail(size: size) : Container()
      ],
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
    required this.size,
    required this.maxCheck,
  });

  final Size size;
  final bool maxCheck;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
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
      ),
      true
          ? Container()
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
              ],
            ),
      true ? DetectFail(size: size) : Container()
    ]);
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
                const Text(
                  'Status',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
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
