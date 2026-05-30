import 'package:get/get.dart';

class VisibilityController extends GetxController {
  static VisibilityController get to => Get.find();

  final isObscured = false.obs;

  void toggle() => isObscured.value = !isObscured.value;
}