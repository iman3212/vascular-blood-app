import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/menu/controller.dart';

class MenuItem extends StatelessWidget {
  final String image1;
  final String image2;
  final String title1;
  final String title2;
  final String content1;
  final String content2;

  const MenuItem({
    super.key,
    required this.menuController,
    required this.field,
    required this.image1,
    required this.image2,
    required this.title1,
    required this.title2,
    required this.content1,
    required this.content2,
  });

  final MenuScreenController menuController;
  final int field;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(
      () => InkWell(
        onTap: () {
          menuController.changeSelectedItem(field);
        },
        child: Container(
          height: size.height * 0.31,
          width: size.width * 0.43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
                color: field == menuController.selectedItem.value
                    ? Colors.red
                    : Colors.grey.shade300,
                width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: CarouselSlider(
              items: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      image1,
                      width: size.width * 0.4,
                      height: size.height * 0.15,
                    ),
                    Text(title1,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.black),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: Text(
                        content1,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey.shade600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      image2,
                      width: size.width * 0.4,
                      height: size.height * 0.15,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title2,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: Text(
                        content2,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey.shade600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
              options: CarouselOptions(
                height: size.height * 0.3,
                enlargeCenterPage: true,
                reverse: true,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                viewportFraction: 1,
                autoPlay: true,
                aspectRatio: 3.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
