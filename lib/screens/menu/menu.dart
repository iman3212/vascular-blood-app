import 'dart:async';
import 'package:flutter/services.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/logout.dart';
import 'package:vascular_blood/global/globalwidgets/menu/menuHeader.dart';
import 'package:vascular_blood/global/globalwidgets/menu/menuItem.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/menu/controller.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final MenuScreenController menuController = Get.put(MenuScreenController());

  // Defining the states
  final int diameter = 1;
  final int parameter = 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Setting system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // Status bar color
    ));

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen =
              constraints.maxWidth < 300; // Updated breakpoint

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/pattern.jpg",
                        width: size.width,
                        height: 220,
                        fit: BoxFit.fitWidth,
                      ),
                      Positioned(
                        top: 20,
                        left: size.width * 0.04,
                        right: size.width * 0.04,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quality Control Type",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                       
                                        color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    LogOutDialog().showLogoutDialog();
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    
                                  ),
                                ),
                              ],
                            ),
                            MenuHeaderItem(
                              title: 'View History',
                              content: 'Click to view your activity record',
                              icon: Icons.history,
                              func: () {
                                Timer(const Duration(seconds: 1),
                                    () => Get.toNamed(Routes.history));
                              },
                              buttonText: 'View',
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 25, // Adjusted height for responsiveness
                      //     decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(120),
                      //         topRight: Radius.circular(120),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: size.height * 0.77,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: -size.height * 0.13,
                          child: Image.asset(
                            'assets/images/pat1.jpg',
                            width: size.width,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(18, 20, 18, 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose QC Type",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Select the quality control assurance type: Diameter (Inner and Outer) or Dimensions (Length and Width)",
                                //"Pick vessel measurement preference: diameter or dimensions",
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey.shade700),
                                overflow: TextOverflow.ellipsis,
                                maxLines: isSmallScreen ? 3 : 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              isSmallScreen
                                  ? Column(
                                      children: [
                                        MenuItem(
                                          menuController: menuController,
                                          field: diameter,
                                          image1:
                                              'assets/images/diameter-option2.jpg',
                                          image2:
                                              'assets/images/diameter-option.png',
                                          title1: 'Inner Diameter',
                                          title2: 'Outer Diameter',
                                          content1:
                                              'Internal diameter quality control',
                                          content2:
                                              'External diameter quality control',
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        MenuItem(
                                          menuController: menuController,
                                          field: parameter,
                                          image1:
                                              'assets/images/vein-length.jpg',
                                          image2:
                                              'assets/images/vein-width.jpg',
                                          title1: 'Width Parameter',
                                          title2: 'Length Parameter',
                                          content1: 'Width quality control assurance',
                                          content2: 'Length quality control assurance',
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: MenuItem(
                                            menuController: menuController,
                                            field: diameter,
                                            image1:
                                                'assets/images/diameter-option2.jpg',
                                            image2:
                                                'assets/images/diameter-option.png',
                                            title1: 'Inner Diameter',
                                            title2: 'Outer Diameter',
                                            content1:
                                                'Internal diameter quality control',
                                            content2:
                                                'External diameter quality control',
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.04),
                                        Flexible(
                                          child: MenuItem(
                                            menuController: menuController,
                                            field: parameter,
                                            image1:
                                                'assets/images/vein-length.jpg',
                                            image2:
                                                'assets/images/vein-width.jpg',
                                            title1: 'Width Parameter',
                                            title2: 'Length Parameter',
                                            content1:
                                                'Width quality control assurance',
                                            content2:
                                                'Length quality control assurance',
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: size.height * 0.027),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.black,
                                  minimumSize:
                                      Size(size.width, size.height * 0.07),
                                ),
                                onPressed: () async {
                                  Logger().i(
                                      'User chose ${menuController.selectedItem.value} item');
                                  await menuController.setType(
                                      menuController.selectedItem.value);
                                  Get.toNamed(Routes.switchNetwork);
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.024,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (!(constraints.maxWidth < 300))
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
