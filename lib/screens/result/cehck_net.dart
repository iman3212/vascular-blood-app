import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/theme/theme.dart';

class InternetCheck extends StatefulWidget {
  const InternetCheck({super.key, required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  State<InternetCheck> createState() => _InternetCheckState();
}

class _InternetCheckState extends State<InternetCheck>
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
    final img = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       title: const Text('Switch Network',style: TextStyle(color: Colors.white),),
            leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: InkWell(
            onTap: () {
             Get.back();
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ),
           
      ),
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
                      SlideTransition(
                        position: _positionAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          // child:Image.file(img)
                          child: Image.asset(
                            "assets/images/wifi.png",
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
                            Icons.mobiledata_off,
                            size: screenWidth * 0.08, // Responsive icon size
                          ),
                          SizedBox(
                              width: screenWidth * 0.02), // Adjusted spacing
                          Text(
                            "Internet Review",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please disconnect from Wi-Fi microscope :",
                        textAlign: TextAlign.center, // Adjusted text alignment
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 253, 231, 231),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "MKL_WIFI_0A34CC",
                            style: AppTheme()
                                .lightTheme
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.red, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Text(
                        "Check your internet connection and connect to  Wi-Fi network with internet access or enable your mobile data",
                        textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey.shade700, fontSize: 18.5),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      ElevatedButton(  onPressed: () => Get.offNamed(Routes.result),
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.black,
                          maximumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Maximum size for the button
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Minimum 
                       
                       
                      ), child: Text(
                          "Next",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ), 
                      )
                     
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
