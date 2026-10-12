import 'package:flutter/material.dart';
import 'package:vascular_blood/screens/onboarding/onboarding2.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen =
                constraints.maxWidth < 360; // Updated breakpoint

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/images/onboarding1.jpg",
                    height: size.height,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/onboarding-gradient.PNG",
                        width: MediaQuery.of(context).size.width,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 5,
                  right: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.height * 0.02,
                    ),
                    child: SingleChildScrollView(
                      // This enables vertical scrolling
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quality Control Assurance",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: isSmallScreen
                                      ? 18
                                      : 24, // Dynamic font size
                                ),
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            "Providing precise assessments of artificial vessels , adhering to the highest standards.",
                            textAlign: isSmallScreen
                                ? TextAlign.left
                                : TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: isSmallScreen
                                      ? 12
                                      : 18.5, // Dynamic font size
                                ),
                          ),
                        
                          SizedBox(height: size.height * 0.02),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1,
                                vertical: size.height * 0.02,
                              ),
                            ),
                            onPressed: () {
                              // Add animation for navigation
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const OnBoarding2(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(4.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 14 : 18.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
