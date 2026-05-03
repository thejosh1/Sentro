import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:sentro/core/services/storage_service.dart';

class InactivityService extends GetxService {
  static const _timeout = Duration(minutes: 2, seconds: 30);
  Timer? _timer;

  /// Call this to start/reset the countdown.
  /// No-ops when the user is not authenticated.
  void resetTimer() {
    final isLoggedIn = StorageService.token?.isNotEmpty ?? false;
    if (!isLoggedIn) return;

    _timer?.cancel();
    _timer = Timer(_timeout, _onInactive);
  }

  /// Cancel the timer entirely (call on manual logout or when on public routes).
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onInactive() {
    final currentRoute = Get.currentRoute;

    // const authRoutes = [
    //   Routes.login,
    //   Routes.getStarted,
    //   Routes.register,
    //   Routes.forgetPassword,
    //   Routes.createPasswordNew,
    //   Routes.verifyEmailReset,
    //   Routes.activateAccount,
    //   Routes.completeActivation,
    //   Routes.createPassword,
    // ];
    // if (authRoutes.contains(currentRoute)) return;

    log('[InactivityService] Idle timeout — logging out. Preserving router: $currentRoute');

    // Flag + router only written on inactivity, never anywhere else
    StorageService.saveData('inactivity_logout', true);
    StorageService.saveLastRoute(currentRoute);

    StorageService.logout();

    // cToast(
    //   title: 'Session Expired',
    //   message: 'You were logged out due to inactivity.',
    //   color: kRed,
    // );

    // Get.offAllNamed(Routes.login);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}