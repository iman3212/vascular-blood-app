import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vascular_blood/global/globalwidgets/textfields/logintextfiled.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/screens/forget-password/controller.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newEmail = TextEditingController();
  TextEditingController newEmailRepeat = TextEditingController();
  ForgetPasswordController forgetPassword = Get.put(ForgetPasswordController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -size.height * 0.07,
            child: Image.asset(
              "assets/images/pat1.jpg",
              height: size.height * 0.3,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06, vertical: size.height * 0.02),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock, size: size.height * 0.04),
                              SizedBox(width: size.width * 0.02),
                              Text(
                                "New password",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.015),
                          Text(
                            "Please enter your new email and repeat",
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height * 0.05),
                          Padding(
                            padding:  EdgeInsets.only(left: size.width * 0.04,right: size.width * 0.04),
                            child: Form(
                              key: _formKey,
                              child: Obx(
                                () => Column(
                                  children: [
                                    LoginTextfield(
                                      controller: newEmail,
                                      label: "New password",
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.red,
                                        size: size.height * 0.03,
                                      ),
                                      isPassword: true,
                                      isEmail: false,
                                      obscureText:
                                          forgetPassword.obscureText.value,
                                      obscureIcon: IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          forgetPassword.obscure();
                                        },
                                        icon: Icon(
                                          forgetPassword.obscureText.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.red,
                                          size: size.height * 0.03,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    LoginTextfield(
                                      controller: newEmailRepeat,
                                      label: "New password repeat",
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.red,
                                        size: size.height * 0.03,
                                      ),
                                      isPassword: true,
                                      obscureText:
                                          forgetPassword.obscureText.value,
                                      isEmail: false,
                                      obscureIcon: IconButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          forgetPassword.obscure();
                                        },
                                        icon: Icon(
                                          forgetPassword.obscureText.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.red,
                                          size: size.height * 0.03,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                              
                            ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    forgetPassword.recoveryPassword(
                                        newEmail.text, newEmailRepeat.text);
                                  }
                                },
                                child:forgetPassword.isProcessing.value?SpinKitThreeBounce(): Text('Save',  style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),) ,
                               
                              )),
                              SizedBox(height:size.height*0.03,),
                           InkWell(
                  onTap: () {
                    Get.offAllNamed(Routes.signIn);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Back to Log in ",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                )    
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
    );
  }
}
