import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/verification/controller.dart';
import 'package:vascular_blood/theme/color.dart';

class AccountVerification extends StatelessWidget {
  AccountVerification({super.key});

  VerificationController verifController = Get.put(VerificationController());

  // timer controller
  final CountdownController _controller = CountdownController(autoStart: true);

  String enteredOtp = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Positioned(
              bottom: -size.height * 0.11,
              child: Image.asset(
                "assets/images/pat1.jpg",
                height: size.height * 0.3,
                width: size.width,
                fit: BoxFit.cover,
              )),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                    vertical: size.height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.safety_check,
                          size: 35,
                        ),
                        Text("Account Verification",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: size.width < 360 ? 18 : 24)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "A security code has been sent to your email. Please check your inbox and enter the security code ",
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                     SizedBox(height: size.height * 0.03),
                    OtpTextField(
                      clearText: true,
                      fieldWidth: size.width * 0.14,
                      enabledBorderColor: Colors.grey.shade300,
                      borderWidth: 1.3,
                      focusedBorderColor: Colors.red,
                      cursorColor: Colors.red,

                      numberOfFields: 4,
                      showFieldAsBox: true,
                      borderColor: Colors.grey,
                      //handle validation or checks here
                      onCodeChanged: (String code) {},
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        enteredOtp = verificationCode;
                        verifController.checkOtp(verificationCode);
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Countdown(
                      controller: _controller,
                      seconds: 120,
                      onFinished: () => verifController.tokenExpired(),
                      build: (BuildContext context, double time) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (time.toInt()).toString(),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "secound",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey.shade600),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Obx(
                      () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              maximumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Maximum size for the button
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Minimum size for the button
                              backgroundColor:
                                  verifController.enableButton.value
                                      ? Colors.grey.shade300
                                      : LightThemeColor.primaryColor),
                          onPressed: () {
                            if (enteredOtp.isNotEmpty) {
                              verifController.checkOtp(enteredOtp);
                            }
                          },
                          child: verifController.processing.value
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Text(
                                  "Verify",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                )),
                    ),
                                      SizedBox(height: size.height * 0.013),

                    Obx(
                      () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              maximumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Maximum size for the button
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Minimum size for the button
                              backgroundColor:
                                  verifController.enableButton.value
                                      ? LightThemeColor.primaryColor
                                      : Colors.grey.shade300),
                          onPressed: () async {
                            if (verifController.enableButton.value) {
                              final result =
                                  await verifController.resendUrlToken();
                              result ? _controller.restart() : null;
                            }
                          },
                          child: verifController.isProcessing.value
                              ? const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Text(
                                  "Resend",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Wrong email ? ",
                          style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: size.width < 360 ? 12 : 16,
                                        color: Colors.grey.shade700,
                                      ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.signUp);
                            },
                            child:  Text("Click to edit",style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                        fontSize: size.width * 0.04),))
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.004,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAllNamed(Routes.signIn);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(color: const Color.fromARGB(255, 252, 227, 226),borderRadius: BorderRadiusDirectional.circular(60)),
                            child: const Icon(Icons.arrow_back)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Back to Sign In ",
                            style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: size.width < 360 ? 12 : 16,
                                        color: Colors.grey.shade700,
                                      ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
