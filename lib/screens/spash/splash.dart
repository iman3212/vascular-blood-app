import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vascular_blood/exports/modules.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController logoController;
  late AnimationController textController;
  late Animation<Offset> textOffsetAnimation;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Slide animation from left to center
    textOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // Off-screen to the left
      end: Offset.zero, // On-screen in the original position
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeInOut));

    logoController.forward();
    textController.forward();
  }

  @override
  void dispose() {
    logoController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/splash_background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(logoController),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: screenWidth *
                        0.45, // Adjust logo size based on screen width
                    height: screenWidth * 0.45,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SlideTransition(
                  position: textOffsetAnimation,
                  child: Text(
                    'Vascular Blood QC',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black45,
                        ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                SlideTransition(
                  position: textOffsetAnimation,
                  child: Text('Version 1.0.0',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 20,
              child: Center(
                  child: Text(
                '© 2025 MOCBIOTECH',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
              )))
        ],
      ),
    );
  }
}
