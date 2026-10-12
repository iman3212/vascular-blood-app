import 'package:vascular_blood/exports/modules.dart';

class InternetManagment extends StatefulWidget {
  const InternetManagment(
      {super.key, required this.onTryAgain, required this.content});
  final VoidCallback onTryAgain;
  final String content;

  @override
  State<InternetManagment> createState() => _InternetManagmentState();
}

class _InternetManagmentState extends State<InternetManagment>
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

          return Stack(
            children: [
              Positioned(
                bottom: -screenHeight * 0.4, // Adjusted based on screen height
                child: Image.asset(
                  'assets/images/pat1.jpg',
                  height: screenHeight * 0.8, // Adjusted based on screen height
                  width: screenWidth,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal:
                        screenWidth * 0.05), // Adjusted based on screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: _positionAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image.asset(
                          "assets/images/check_internet.png",
                          width: screenWidth *
                              0.65, // Adjusted based on screen width
                          height: screenWidth *
                              0.65, // Adjusted based on screen width
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
                        SizedBox(width: screenWidth * 0.02), // Adjusted spacing
                        Text(
                          "No Internet",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontSize:
                                    screenWidth * 0.06, // Responsive font size
                              ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your Internet is disconnected",
                        textAlign:
                            TextAlign.center, // Adjusted text alignment
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(widget.content,
                        textAlign: TextAlign.justify, // Adjusted text alignment
                        style: Theme.of(context).textTheme.titleSmall),

                    ElevatedButton(
                      style: ButtonStyle(
                        // Responsive padding
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                      onPressed: widget.onTryAgain,
                      child: Text(
                        "Start",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05), // Adjusted spacing
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
