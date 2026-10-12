import 'package:vascular_blood/global/globalwidgets/snackbars.dart/warning.dart';
import 'package:vascular_blood/global/globalwidgets/textfields/logintextfiled.dart';
import 'package:vascular_blood/screens/sign-in/controller.dart';
import 'package:vascular_blood/theme/button.dart';
import 'package:vascular_blood/exports/modules.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController loginController = Get.put(LoginController());

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
          top: 0,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/pattern.jpg",
                fit: BoxFit.fitWidth,
                height: size.height * 0.38,
              ),
              Positioned(
                top: 0,
                right: size.width * 0.1,
                left: size.width * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                  color: Colors.white,
                                  fontSize: size.width < 360 ? 18 : 24),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "QC Assurance",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.white70,
                                    fontSize: size.width < 360 ? 12 : 18.5,
                                  ),
                        )
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
                  bottom: -size.height * 0.11,
                  child: Image.asset(
                    'assets/images/pat1.jpg',
                    width: MediaQuery.of(context).size.width,
                  )),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                      vertical: size.height * 0.05),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome Back !",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: size.width < 360 ? 18 : 24)),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            "Sign in to continue your journey with Vascular Blood",
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Colors.grey.shade700,
                                    fontSize: size.width < 360 ? 12 : 18.5),
                          ),
                          SizedBox(height: size.height * 0.06),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                SizedBox(height: size.height * 0.013),
                                Obx(
                                  () => LoginTextfield(
                                    controller: password,
                                    label: "Password",
                                    obscureText:
                                        loginController.obscureText.value,
                                    obscureIcon: IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          loginController.obscure();
                                        },
                                        icon: Icon(
                                          loginController.obscureText.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.red,
                                          size: 25,
                                        )),
                                    icon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    isPassword: true,
                                    isEmail: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.emailtCheck);
                                  },
                                  child: Text(
                                    "Forgot your password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.grey.shade700,
                                            fontSize:
                                                size.width < 360 ? 10 : 16),
                                  )),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                          Obx(() => CustomButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    loginController.loginTokenRequest(
                                        email.text, password.text);
                                  } else {
                                    const WarningSnackbar(
                                            title: 'warning',
                                            content:
                                                'Please enter valid values')
                                        .show();
                                  }
                                },
                                text: 'Sign In ',
                                processing: loginController.processing.value,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don’t have an account?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: size.width < 360 ? 12 : 16,
                                        color: Colors.grey.shade700,
                                      )),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.signUp);
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                        fontSize: size.width * 0.04),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
