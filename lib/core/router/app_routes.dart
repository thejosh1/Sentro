part of 'app_pages.dart';

abstract class Routes {
  // onboarding screens
  static const initial = '/splash';
  static const getStarted = '/get-started';
  static const createAccount = '/create-account';
  static const confirmPhoneNumber = '/confirm-phone-number';
  static const confirmBvn = '/confirm-bvn';
  static const createPassword = '/create-password';
  static const chooseSentroTag = '/choose-sentro-tag';
  static const createPin = '/create-pin';
  static const welcome = '/welcome';
  static const verifyPhone = '/verify-phone';
  static const login = '/login';
  static const resetPassword = '/reset-password';
  static const confirmPin = '/confirm-pin';


  // dashboard screens
  static const mainView = '/screen';
  static const confirmation = '/confirmation';
  static const transactionHistory = '/transaction-history';

  //widgets
  static const confirmTransaction = '/confirm-transaction';
}
