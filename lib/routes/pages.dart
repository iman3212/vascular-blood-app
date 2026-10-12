import 'package:vascular_blood/exports/screens.dart';
import 'package:vascular_blood/screens/micro/check-first-photo.dart';
import 'package:vascular_blood/screens/micro/check-secound-photo.dart';
import 'package:vascular_blood/screens/onboarding/onboarding2.dart';
import 'package:vascular_blood/screens/onboarding/onboarding3.dart';
import 'package:vascular_blood/screens/result/cehck_net.dart';
import 'package:vascular_blood/screens/result/needles_table.dart';
import 'package:vascular_blood/screens/result/overall.dart';
import 'package:vascular_blood/screens/result/result.dart';
import 'package:vascular_blood/testwidget.dart';

class AppPages {
  // Static list of pages with their configurations
  static final pages = [
    GetPage(
        name: Routes.splash, // Route name for the splash screen
        page: () => const Splash(), // Widget for the splash screen
        binding: SplashBinding()), // Binding for the splash screen

    GetPage(
        name: Routes.signIn, // Route name for the sign-in screen
        page: () => const Login()), // Widget for the sign-in screen

    GetPage(
        name: Routes.signUp, // Route name for the sign-up screen
        page: () => const Register()), // Widget for the sign-up screen

    GetPage(
        name: Routes.micro, // Route name for the micro stream screen
        page: () => MicroStream(), // Widget for the micro stream screen
        binding: MicroBinding()), // Binding for the micro stream screen

    GetPage(
        name: Routes.menu, // Route name for the menu screen
        page: () => const Menu(), // Widget for the menu screen
        binding: MenuBinding()), // Binding for the menu screen

    GetPage(
        name: Routes.onboarding, // Route name for the first onboarding screen
        page: () =>
            const OnBoarding()), // Widget for the first onboarding screen

    GetPage(
        name: Routes.onboarding2, // Route name for the second onboarding screen
        page: () =>
            const OnBoarding2()), // Widget for the second onboarding screen

    GetPage(
        name: Routes.onboarding3, // Route name for the third onboarding screen
        page: () =>
            const OnBoarding3()), // Widget for the third onboarding screen

    GetPage(
        name: Routes.switchNetwork, // Route name for the SwitchNetwork screen
        page: () => const SwitchNetwork()), // Widget for the SwitchNetwork screen

    GetPage(
        name: Routes.result, // Route name for the result screen
        page: () => Result()), // Widget for the result screen

    GetPage(
        name: Routes.history, // Route name for the history screen
        page: () => const HistoryPage()), // Widget for the history screen

    GetPage(
        name: Routes.nointernet, // Route name for the no internet screen
        page: () => InternetManagment(
              onTryAgain: () {}, // Callback function for retry
              content: '', // Content for the no internet screen
            )),

    GetPage(
        name: Routes.detail, // Route name for the detail history screen
        page: () => DetailHistory()), // Widget for the detail history screen

    GetPage(
        name:
            Routes.nohistory, // Route name for the no history management screen
        page: () =>
            const NoHistoryManage()), // Widget for the no history management screen

    GetPage(
        name: Routes.error, // Route name for the error screen
        page: () => const ErrorPage(
              size: Size(300, 500), // Size of the error page
            )),

    GetPage(
        name: Routes.verification, // Route name for the account verification screen
        page: () =>
            AccountVerification()), // Widget for the account verification screen

    GetPage(
        name: Routes.newpassword, // Route name for the new password screen
        page: () => NewPassword()), // Widget for the new password screen

    GetPage(
        name: Routes.emailtCheck, // Route name for the email checking screen
        page: () => EmailChecking()), // Widget for the email checking screen

    GetPage(
        name: Routes.needletable, // Route name for the needle table screen
        page: () => NeddleTable()), // Widget for the needle table screen

    GetPage(
        name: Routes.guid, // Route name for the user guide screen
        page: () => UserGuid()), // Widget for the user guide screen

    GetPage(
        name: Routes.net, // Route name for the internet check screen
        page: () => InternetCheck(
              onTryAgain: () {}, // Callback function for retry
            )),

    GetPage(
        name: Routes.general, // Route name for the general results screen
        page: () => GeneralResults()), // Widget for the general results screen

    GetPage(
        name:
            Routes.checkSecound, // Route name for the second check image screen
        page: () =>
            CheckSecoundImage()),
            
            GetPage(
        name:
            Routes.test, // Route name for the second check image screen
        page: () =>
            FuckingTest()), // Widget for the second check image screen
  ];
}
