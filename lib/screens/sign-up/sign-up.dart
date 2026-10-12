import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/warning.dart';
import 'package:vascular_blood/global/globalwidgets/textfields/logintextfiled.dart';
import 'package:vascular_blood/screens/sign-up/controller.dart';
import 'package:vascular_blood/theme/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterController registerController = Get.put(RegisterController());

  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;

          return Stack(children: [
            Positioned(
              top: 0,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/pattern.jpg",
                    fit: BoxFit.fitWidth,
                    height: size.height * 0.38, // Responsive height for image
                  ),
                  Positioned(
                    top: 0,
                    right: size.width * 0.1,
                    left: size.width * 0.1,
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Aligns vertically
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vascular Blood",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: screenWidth < 360
                                        ? 18
                                        : 24, // Adjust font size
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "QC Assurance",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: screenWidth < 360
                                        ? 12
                                        : 18.5, // Adjust font size
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "assets/images/wihte-logo.png",
                          width: size.width * 0.37,
                          height: size.height < 360
                              ? size.height * 0.2
                              : size.height * 0.3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.73,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Stack(children: [
                  Positioned(
                    bottom: -size.height * 0.13,
                    child: Image.asset(
                      'assets/images/pat1.jpg',
                      width: size.width,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07,
                        vertical: size.height * 0.05),
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome To Vascular Blood!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: screenWidth < 360
                                        ? 18
                                        : 24, // Font size for small screens
                                  ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "Start your journey with us by creating an account",
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.grey.shade700,
                                    fontSize: screenWidth < 360
                                        ? 12
                                        : 18.5, // Adjust text size
                                  ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  LoginTextfield(
                                    controller: fullname,
                                    label: "Name",
                                    icon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    isPassword: false,
                                    isEmail: false,
                                  ),
                                  SizedBox(height: size.height * 0.016),
                                  LoginTextfield(
                                    controller: email,
                                    label: "Email",
                                    icon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    isPassword: false,
                                    isEmail: true,
                                  ),
                                  SizedBox(height: size.height * 0.016),
                                  Obx(
                                    () => LoginTextfield(
                                      controller: password,
                                      label: "Password",
                                      obscureText:
                                          registerController.obscureText.value,
                                      obscureIcon: IconButton(
                                          color: Colors.red,
                                          onPressed: () {
                                            registerController.obscure();
                                          },
                                          icon: Icon(
                                            registerController.obscureText.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.red,
                                            size: 25,
                                          )),
                                      icon: Icon(
                                        Icons.lock,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      isPassword: true,
                                      isEmail: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Obx(() => CustomButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      registerController.registerTokenRequest(
                                          email.text,
                                          fullname.text,
                                          password.text);
                                      StorageService.saveEmail(email.text);
                                    } else {
                                      const WarningSnackbar(
                                              title: 'warning',
                                              content:
                                                  'Please enter valid values')
                                          .show();
                                    }
                                  },
                                  text: 'Sign Up ',
                                  processing:
                                      registerController.processing.value,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.grey.shade700,
                                        fontSize: screenWidth < 360
                                            ? 10
                                            : 16, // Adjust text size
                                      ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.signIn);
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w800,
                                          fontSize: screenWidth * 0.04),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
