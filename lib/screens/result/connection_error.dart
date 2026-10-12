import 'package:vascular_blood/exports/modules.dart';

class Disconnection extends StatefulWidget {
  const Disconnection({super.key, required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  State<Disconnection> createState() => _DisconnectionState();
}

class _DisconnectionState extends State<Disconnection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(); // Starts the animation when the widget is built.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Stack(children: [
            Positioned(
                bottom: -10,
                child: Image.asset(
                  "assets/images/pat12.jpg",
                  width: MediaQuery.of(context).size.width,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      SlideTransition(
                        position: _positionAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Image.asset(
                            "assets/images/check_internet.png",
                            width: screenWidth *
                                0.60, // Adjusted based on screen width
                            height: screenWidth *
                                0.60, // Adjusted based on screen width
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: screenWidth * 0.08, // Responsive icon size
                          ),
                          SizedBox(
                              width: screenWidth * 0.02), // Adjusted spacing
                          Text(
                            "No Internet ",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: screenWidth *
                                      0.06, // Responsive font size
                                ),
                          ),
                        ],
                      ),
                    SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Text(
                        "Please check your internet and try again",
                        textAlign: TextAlign.center, // Adjusted text alignment
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        "Check your internet connection and connect to  Wi-Fi network with internet access or enable your mobile data",
                        textAlign: TextAlign.justify, // Adjusted text alignment
                        style: Theme.of(context).textTheme.bodySmall!,
                      ),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          // Responsive padding
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                        onPressed:widget.onTryAgain,
                        child: Text(
                          "Next",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}
