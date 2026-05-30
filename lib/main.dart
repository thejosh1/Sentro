import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentro/core/controllers/permission_controller.dart';
import 'package:sentro/core/services/activity_service.dart';
import 'package:sentro/screen/main_view/controller/main_controller.dart';

import 'core/constants/app_theme.dart';
import 'core/constants/size_config.dart';
import 'core/controllers/theme_controller.dart';
import 'core/controllers/visibility_controller.dart';
import 'core/router/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PermissionController(), permanent: true);
  Get.put(VisibilityController(), permanent: true);
  await GetStorage.init();

  Get.put(InactivityService(), permanent: true);
  Get.put(ThemeController(), permanent: true);
  // REMOVE the orientation lock here to allow the fold to trigger layouts
  Get.put(MainController());


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
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
