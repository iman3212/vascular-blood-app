import 'package:vascular_blood/exports/modules.dart';

class ResultWidget2 extends StatelessWidget {
  const ResultWidget2({
    super.key,
    required this.size,
    required this.isParameter,
    required this.resultData,
     required this.side,
  });

  final Size size;
  final bool isParameter;
  final resultData;
   final int side;

  @override
  Widget build(BuildContext context) {
    late var showContent;
    late var showCheck;

    if (isParameter) {
      showCheck = resultData?.heightResult;
    } else {
     if (side == 0) {
        showCheck = resultData?.frontExternalDiameter;
      }else{
        showCheck = resultData?.backExternalDiameter;
      }
    }
    showCheck == null ? showContent = true : showContent = false;
    final maxCheck = size.width < 360 ? true : false;
    return Flexible(
      child: Container(
        height: size.height * 0.20,
        width: size.width * 0.44,
        decoration: BoxDecoration(
          color: Colors.transparent,
        
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: showContent
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detection Failed",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5,),
                    Text(
                        "Unable to detect the external diameter in the image",
                         style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey.shade700)),
                    // Row(
                    //   children: [
                    //     OutlinedButton(
                    //         style: OutlinedButton.styleFrom(
                    //             //side: BorderSide(color: Colors.white)
                    //             ),
                    //         onPressed: () {
                    //           DetectFailDialog().showDialog();
                    //         },
                    //         child: const Text(
                    //           "More",
                    //           style: TextStyle(color: Colors.black),
                    //         ))
                    //   ],
                    // )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                         decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(60)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Image.asset(
                                  isParameter
                                      ? "assets/images/length.png"
                                      : "assets/images/external.png",
                                  width: size.width * 0.06,
                                  height: size.width * 0.06,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(isParameter ? "Length(mm)" : "OD (mm)",
                           style: TextStyle(fontSize: 17)),
                      ],
                    ),
                     Divider(
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "External diameter of the artificial vessel",
                     style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey.shade700),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                           decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 1),
                            child: Text(
                              isParameter
                                  ? resultData!.heightResult.toString()
                                  :side==0? resultData!.frontExternalDiameter.toString() :resultData!.backExternalDiameter.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: maxCheck ? 15 : 18,
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
    );
  }
}
