import 'package:vascular_blood/exports/modules.dart';

class Pass extends StatelessWidget {
  const Pass({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      height: size.height * 0.17,
      width: size.width * 0.40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/pass.png",
                  height: size.height * 0.045,
                  width: size.width * 0.07,
                ),
                Text(
                  "QC ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 17 * textScaleFactor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),

            SizedBox(height: size.height * 0.002),
            Text(
              "QC Assurance Result",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey.shade700),
            ),
            // SizedBox(height: size.height * 0.005),
            Divider(
              color: Colors.grey.shade300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: Text(
                      "Pass",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 15 * textScaleFactor,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
