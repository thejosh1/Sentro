
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sentro/screen/onboarding/view/get_started.dart';
import 'package:sentro/screen/onboarding/view/splash.dart';

part 'app_routes.dart';

class AppPages {
  static const splash = Routes.initial;
  static const getStarted = Routes.getStarted;
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

  ];
}
