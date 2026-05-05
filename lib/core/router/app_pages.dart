
import 'package:get/get.dart';
import 'package:sentro/screen/onboarding/view/create_account.dart';
import 'package:sentro/screen/onboarding/view/get_started.dart';
import 'package:sentro/screen/onboarding/view/splash.dart';

part 'app_routes.dart';

class AppPages {
  static const splash = Routes.initial;
  static const getStarted = Routes.getStarted;
  static const createAccount = Routes.createAccount;
  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const Splash(),
    ),
    GetPage(
      name: getStarted,
      page: () => const GetStarted(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: createAccount,
      page: () => const CreateAccount(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
