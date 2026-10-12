import 'package:flutter/material.dart';
import 'package:vascular_blood/exports/modules.dart';

class NoHistoryManage extends StatelessWidget {
  const NoHistoryManage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Image.asset(
              "assets/images/nohistory.png",
              width: size.width * 0.44,
              height: size.height * 0.18,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.folder,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text("NO History Yet",
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "You dont have active history yet",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: size.height * 0.012,
            ),
            Text(
                textAlign: TextAlign.center,
                "This section will be activated for you when you perform the first artificial vessel quality control , in this section, you will have access to a history of all your activities",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
