import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vascular_blood/global/globalwidgets/textfields/logintextfiled.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/forget-password/controller.dart';

class EmailChecking extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  ForgetPasswordController forgetPassword = Get.put(ForgetPasswordController());
  final _formKey = GlobalKey<FormState>();

  EmailChecking({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: const Color.fromARGB(255, 248, 228, 227)),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            )),
        body: Stack(
          children: [
            Positioned(
              bottom: -size.height * 0.05,
              child: Image.asset(
                "assets/images/pat1.jpg",
                height: size.height * 0.3,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.height * 0.02,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email,
                                  size: size.height * 0.04,
                                ),
                                SizedBox(width: size.width * 0.02),
                                Text(
                                  "Email verification",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Please enter the email you entered during registration",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: size.height * 0.05),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Form(
                                key: _formKey,
                                child: LoginTextfield(
                                  controller: emailController,
                                  label: 'Email',
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.red,
                                    size: size.height * 0.03,
                                  ),
                                  isPassword: false,
                                  isEmail: true,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04),
                            Obx(() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await StorageService.saveEmail(
                                          emailController.text);
                                      forgetPassword.checkEmail();
                                    }
                                  },
                                  child: forgetPassword.isProcessing.value
                                      ? const SpinKitThreeBounce(
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : Text(
                                          'Next',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
