import 'package:cached_network_image/cached_network_image.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/image-dialog.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/services/model/history_model.dart';

class Patient extends StatelessWidget {
  final VeinModel data;
  const Patient({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isSmallScreen = screenSize.width < 300;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: isSmallScreen ? 120 : 155,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            "assets/images/history-pattern.jpg",
                            width: isSmallScreen ? 90 : 300,
                            height: isSmallScreen ? 70 : 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: InkWell(
                          onTap: () {
                            final imageUrl = data.front != null
                                ? 'http://vascular.hitechprojects.ir:8300${data.front}'
                                : 'assets/images/vessel.jpg';
                            showDialog(
                              context: context,
                              builder: (_) => ImageDialog(
                                pic: imageUrl,
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: isSmallScreen ? 60 : 75,
                            height: isSmallScreen ? 60 : 75,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://vascular.hitechprojects.ir:8300${data.front}',
                                    fit: BoxFit.cover,
                                    width: isSmallScreen ? 60 : 75,
                                    height: isSmallScreen ? 60 : 75,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/vessel.jpg',
                                      width: isSmallScreen ? 60 : 75,
                                      height: isSmallScreen ? 60 : 75,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.bar_chart,
                              size: 20,
                            ),
                            const SizedBox(width: 7),
                            Text("Activity Record",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 17)),
                          ],
                        ),
                        const Divider(indent: 5, endIndent: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: isSmallScreen ? 19 : 23,
                                      decoration: BoxDecoration(
                                        color: data.key == "diameter"
                                            ? Colors.black
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 1),
                                        child: Text(
                                          data.key == "diameter"
                                              ? "Diameter"
                                              : "Parameters",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.punch_clock,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    data.date.toString().split('T').first,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  ),
                                  const Text(" - "),
                                  const SizedBox(width: 2),
                                  Text(
                                    data.date
                                        .toString()
                                        .split('T')[1]
                                        .split('.')
                                        .first,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data.key == "diameter"
                                              ? "Inner"
                                              : "Length ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                                  isSmallScreen ? 13 : 15),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          data.key == "diameter"
                                              ? data.innerFrontDiameter == null
                                                  ? "Fail"
                                                  : "${data.innerFrontDiameter}"
                                              : data.heightResult == null
                                                  ? "Fail"
                                                  : "${data.heightResult}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                                  isSmallScreen ? 13 : 15),
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      width: 5,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          data.key == "diameter"
                                              ? "Outer"
                                              : "Width",
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: isSmallScreen ? 13 : 15,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          data.key == "diameter"
                                              ? data.externalFrontDiameter ==
                                                      null
                                                  ? "Fail"
                                                  : "${data.externalFrontDiameter.toStringAsFixed(1)}"
                                              : data.widthResult == null
                                                  ? "Fail"
                                                  : "${data.widthResult.toStringAsFixed(1)}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                                  isSmallScreen ? 13 : 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(color: Colors.red),
                      ),
                      child: IconButton(
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        padding: const EdgeInsets.all(3),
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Get.toNamed(Routes.detail, arguments: data);
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.red,
                          //  size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(width: 4),
              ],
            ),
          );
        },
      ),
    );
  }
}
