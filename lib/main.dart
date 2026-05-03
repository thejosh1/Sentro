import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentro/core/services/activity_service.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/size_config.dart';
import 'core/controllers/theme_controller.dart';
import 'core/router/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");

  // Get.put(InactivityService(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  // REMOVE the orientation lock here to allow the fold to trigger layouts
  // Get.put(DashboardController(AccountServiceImpl()));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sentro',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeController.themeMode,
      builder: (context, child) {
        SizeConfig().init(context);

        return Listener(
          onPointerDown: (_) => Get.find<InactivityService>().resetTimer(),
          onPointerUp: (_) {
            // Also unfocus keyboard
            final focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
              focus.focusedChild!.unfocus();
            }
          },
          child: DisplayFeatureSubScreen(child: child!),
        );
      },
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
