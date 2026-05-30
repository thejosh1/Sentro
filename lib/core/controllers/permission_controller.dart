import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentro/core/router/app_pages.dart';

class PermissionController extends GetxController {
  static PermissionController get to => Get.find();

  final cameraGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkCameraPermission();
  }

  Future<void> checkCameraPermission() async {
    final status = await Permission.camera.status;
    cameraGranted.value = status.isGranted;
  }

  Future<bool> requestCameraPermission() async {
    // Check first — no need to re-request if already granted
    final current = await Permission.camera.status;
    if (current.isGranted) {
      cameraGranted.value = true;
      return true;
    }

    final status = await Permission.camera.request();

    if (status.isGranted) {
      cameraGranted.value = true;

      // Auto-dismiss the permissions page if it was pushed
      if (Get.currentRoute == Routes.permissions) {
        Get.back();
      }

      return true;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    cameraGranted.value = false;
    return false;
  }
}