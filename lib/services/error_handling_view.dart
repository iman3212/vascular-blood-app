import 'package:vascular_blood/exports/modules.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            bottom: -10,
            right: 0,
            left: 0,
            child: Image.asset(
              "assets/images/pat12.jpg",
              width: MediaQuery.of(context).size.width,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/error.png",
                width: size.width * 1,
                height: size.height * 0.4,
              ),
              Text(
                "Oops",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.red),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                "Something went wrong !",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                    "We are sorry , but it seems there is a problem , please try again later !",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black)),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                     
                              maximumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // Maximum size for the button
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  55), // M
                    backgroundColor: Colors.red),
                  onPressed: () {
                    Get.offNamed(Routes.menu);
                  },
                  child: Text(
                    "Go Home",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
