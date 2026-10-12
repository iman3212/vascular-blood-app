import 'package:vascular_blood/exports/screens.dart'; // Ensure this import is valid

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  _OnBoarding3State createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen =
                constraints.maxWidth < 300; // Adjust for smaller screens

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/onboarding3.jpg",
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
                        height: size.height * 0.3, // Adjust for responsiveness
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
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.02,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Access Your Data Anytime",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            "We securely store your data, so you can access it whenever you need. ",
                            textAlign: isSmallScreen
                                ? TextAlign.left
                                : TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 14 : 18.5),
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

  // Custom method to add transition animation for the next page
  void _navigateToNextPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Menu(), // Replace with the actual next page
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
      (Route<dynamic> route) => false,
    );
  }
}
