import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import 'package:vascular_blood/storage/getx.dart';
import 'package:vascular_blood/theme/button.dart';

class SwitchNetwork extends StatefulWidget {
  const SwitchNetwork({super.key});

  @override
  State<SwitchNetwork> createState() => _SwitchNetworkState();
}

class _SwitchNetworkState extends State<SwitchNetwork>
    with WidgetsBindingObserver {
  late Completer<void> _resumeCompleter;

  bool wifiOn = false;
  bool wifiOff = false;
  String wifiButtonText = "Setting";

  final List<AppLifecycleState> stateHistoryList = <AppLifecycleState>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetCompleter();
  }

  void _resetCompleter() {
    _resumeCompleter = Completer<void>();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed && !_resumeCompleter.isCompleted) {
      debugPrint("App resumed, completing completer");
      _resumeCompleter.complete();
      debugPrint("compeler copleter successfully");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

// Check wifi connection
  Future<void> _checkWifiConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      setState(() {
        wifiOn = true;
      });
      //'"MKL_WIFI_0A34CC"'
    }
  }

  Future<void> _waitForWifiConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return; // Already connected to Wi-Fi
    }
    await for (var result in Connectivity().onConnectivityChanged) {
      if (result.contains(ConnectivityResult.wifi)) {
        break; // Exit the loop once Wi-Fi is connected
      }
    }
  }

  Future<void> handleMobileData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return; // Already connected to Wi-Fi
    }
  }

  Future<void> handleWifiStatus() async {
    if (Platform.isAndroid) {
      const settings = OpenSettingsPlusAndroid();

      await settings.wifi();

      _resetCompleter();
      await _waitForWifiConnection();
      await _resumeCompleter.future;
      await _checkWifiConnection();
    } else {
      // For ios
      const settings = OpenSettingsPlusIOS();
      await settings.wifi();
      _resetCompleter();
      await _waitForWifiConnection();
      await _resumeCompleter.future;
      await _checkWifiConnection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
      
        centerTitle: true,
        title: const Text(
          "Switch Network",
          style: TextStyle(color: Colors.white),
        ),
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
      body: Stack(children: [
        Stack(children: [
          Positioned(
            bottom: -screenHeight * 0.14,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/pat2.png",
              height: screenHeight * 0.4,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.02),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.07,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/wifi.png",
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.2,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Turn off mobile data and connect to the microscope's Wi-Fi. Once connected, the Next button will be enabled",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey.shade700, fontSize: 18.5),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.015),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.mobiledata_off,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Mobile Data",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      "Turn off your mobile data",
                                      // textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize:
                                                screenWidth < 360 ? 12 : 16,
                                            color: Colors.grey.shade700,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.013),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.wifi,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Wifi Setting",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      "Connect to microscope wifi",
                                      // textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize:
                                                screenWidth < 360 ? 12 : 16,
                                            color: Colors.grey.shade700,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              TextButton(
                                style: ButtonStyle(
                                    minimumSize: const WidgetStatePropertyAll(
                                        Size(75, 40)),
                                    maximumSize: const WidgetStatePropertyAll(
                                        Size(75, 40)),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Set your desired border radius
                                      ),
                                    ),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            Colors.black)),
                                onPressed: () => handleWifiStatus(),
                                child:wifiOn?const Icon(Icons.check,color: Colors.white,): Text(
                                  wifiButtonText,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Center(
                    child: ElevatedButton(
                      onPressed: wifiOn
                          ? () {
                              try {
                                bool isControllerInMemory =
                                    Get.isRegistered<MainController>();
                                if (isControllerInMemory) {
                                  final MainController mainController =
                                      Get.find<MainController>();
                                  //Diameter Mode
                                  mainController.capturedImages.value =
                                      List<File?>.filled(2, null,
                                          growable: false);
                                  //Parameter Mode
                                }
                              } catch (e) {
                                Logger().i(
                                    "No existing MicroController found. This is likely the user's first visit");
                              }

                              Get.toNamed(Routes.micro);
                            }
                          : null,
                      style: ButtonStyles.primaryButton(context).copyWith(
                          backgroundColor: WidgetStatePropertyAll(
                              wifiOn ? Colors.black : Colors.grey.shade300)),
                      child: Text(
                        "Next",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: 18,
                                color: Colors.white, // Text color
                                fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
