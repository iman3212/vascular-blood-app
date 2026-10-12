import 'package:flutter/material.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/onboarding/onboarding3.dart'; // Make sure this import is correct

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  _OnBoarding2State createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 300;

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/onboarding2.jpg",
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
                        width: size.width,
                        height: size.height *
                            0.3, // Relative height for responsiveness
                        "assets/images/onboarding-gradient.PNG",
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
                      horizontal:
                          size.width * 0.04, // Responsive horizontal padding
                      vertical: size.height * 0.02,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AI-Powered Detection",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            "Accurate detection and measurement of artificial vessel sizes with AI.",
                            textAlign: isSmallScreen
                                ? TextAlign.left
                                : TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        
                          
                          SizedBox(height: size.height * 0.02),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                  vertical: size.height * 0.02),
                            ),
                            onPressed: () {
                              _navigateToNextPage(context);
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.5,
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

  // Custom method for page transition animation
  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const OnBoarding3(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(4.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
