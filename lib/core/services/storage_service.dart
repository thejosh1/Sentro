import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class StorageService {
  static final box = GetStorage();

  static void saveToken(String token) => box.write("token", token);
  static String? get token => box.read("token");


  static void setStep(String step) => box.write("step", step);
  static String? get step => box.read("step");

  static void setLocation(String location) => box.write("LOCATION", location);
  static String? get getLocation => box.read("LOCATION");

  //set data, get data, delete data, erase memory
  static void setData(String key, dynamic value) => box.write(key, value);

  static dynamic getData(String key) => box.read(key);

  static void deleteData(String key) => box.remove(key);

  static void eraseMemory() => box.erase();

  static bool isKeyExists(String key) => box.hasData(key);

  static void removeKey(String key) => box.remove(key);

  // ⬅️ NEW: Methods for app restart logic
  static void saveData(String key, dynamic value) => box.write(key, value);

  static void removeData(String key) => box.remove(key);

  static void clearToken() => box.remove("token");

  static bool get isFirstTime => box.read("isFirstTime") ?? true;

  static void setFirstTime(bool value) => box.write("isFirstTime", value);

  static void saveLastLoginDate(String date) => box.write("lastLoginDate", date);

  static String? get lastLoginDate => box.read("lastLoginDate");
  // ⬅️ END NEW METHODS

  static void saveAccountData(Map<String, dynamic> accountData) {
    box.write("accountData", accountData);
  }

  static void saveUserData(Map<String, dynamic> userJson) {
    box.write('userData', userJson);
  }

  static void saveAccountId(String accountId) => box.write("accountId", accountId);
  static String? get accountId => box.read("accountId");

  static Map<String, dynamic>? getAccountData() {
    return box.read("accountData");
  }

  static void deleteAccountData() {
    box.remove("accountData");
  }

  static void saveUserID(int userId) {
    box.write("userId", userId);
  }

  static int? get userId => box.read("userId");

  static void setPublicAccessMode(bool val) {
    box.write("publicAccessMode", val);
  }

  static bool? get isPublicAccessMode => box.read("publicAccessMode");

  static Future<void> saveSocialPassword(
      String provider, String password) async {
    await box.write('social_pw_$provider', password);
  }

  /// Retrieve the saved password for a social provider
  static String? getSocialPassword(String provider) {
    return box.read('social_pw_$provider');
  }

  Future<String> saveReferenceImage(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(
          directory.path,
          'reference_face_${DateTime.now().millisecondsSinceEpoch}.jpg'
      );
      await imageFile.copy(imagePath);
      return imagePath;
    } catch (e) {
      throw Exception('Failed to save reference image: $e');
    }
  }

  Future<void> deleteReferenceImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting reference image: $e');
    }
  }

  static Map<String, dynamic>? getRawUserData() {
    final dynamic raw = box.read('userData');
    if (raw == null) return null;
    return Map<String, dynamic>.from(raw as Map);
  }

  /// Returns a parsed UserData model or null
  // static UserData? getUserData() {
  //   final raw = getRawUserData();
  //   if (raw == null) return null;
  //   try {
  //     return UserData.fromJson(raw);
  //   } catch (e) {
  //     // If parsing fails, clean up corrupted storage and return null
  //     box.remove('userData');
  //     return null;
  //   }
  // }

  static const String _userEmailKey = 'user_email';

  /// Save the user's email
  static void saveUserEmail(String email) => box.write(_userEmailKey, email);

  /// Get the saved user email
  static String? get userEmail => box.read(_userEmailKey);

  /// Remove the saved user email
  static void clearUserEmail() => box.remove(_userEmailKey);

  /// remove saved user
  static void deleteUserData() {
    box.remove('userData');
  }

  Future<bool> referenceImageExists(String imagePath) async {
    try {
      final file = File(imagePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  static void saveBiometricEnabled(bool value) => box.write("biometric_enabled", value);

  /// Get biometric enabled status
  static bool get isBiometricEnabled => box.read("biometric_enabled") ?? false;

  /// Save biometric data (unique identifier)
  static void saveBiometricData(String data) => box.write("biometric_data", data);

  /// Get stored biometric data
  static String? get biometricData => box.read("biometric_data");

  /// Save biometric type (1=fingerprint, 2=faceId, 3=iris, 4=voice)
  static void saveBiometricType(int type) => box.write("biometric_type", type);

  /// Get saved biometric type
  static int? get biometricType => box.read("biometric_type");

  /// Save last login email for biometric login
  static void saveLastLoginEmail(String email) => box.write("last_login_email", email);

  /// Get last login email
  static String? get lastLoginEmail => box.read("last_login_email");

  // ================= PHONE NUMBER =================

  static const String _phoneKey = 'onboarding_phone';

  static void saveOnboardingPhone(String phone) {
    box.write(_phoneKey, phone);
  }

  static String? get onboardingPhone => box.read(_phoneKey);

  static void clearOnboardingPhone() {
    box.remove(_phoneKey);
  }


  /// Clear all biometric data
  static void clearBiometricData() {
    box.remove("biometric_enabled");
    box.remove("biometric_data");
    box.remove("biometric_type");
  }

  static void logout() {
    clearToken();
    deleteUserData();
    deleteAccountData();
    box.remove('publicAccessMode');
    box.remove('step');
  }


  static void saveIdentifier(String id) => box.write('identifier', id);
  static String? get identifier => box.read('identifier');

  static void saveLastRoute(String route) => box.write('last_active_route', route);

  static String? get lastRoute => box.read('last_active_route');

  static void clearLastRoute() => box.remove('last_active_route');

  static void setInactivityLogout(bool value) => box.write('inactivity_logout', value);
  static bool get wasInactivityLogout => box.read('inactivity_logout') ?? false;
  static void clearInactivityLogout() => box.remove('inactivity_logout');
}