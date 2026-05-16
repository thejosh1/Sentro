
import 'package:get/get.dart';
import 'package:sentro/core/widgets/confirm_pin.dart';
import 'package:sentro/core/widgets/confirm_transaction.dart';
import 'package:sentro/screen/main_view/Dashboard/views/academics.dart';
import 'package:sentro/screen/main_view/Dashboard/views/betting.dart';
import 'package:sentro/screen/main_view/Dashboard/views/cable_tv.dart';
import 'package:sentro/screen/main_view/Dashboard/views/electricity.dart';
import 'package:sentro/screen/main_view/Dashboard/views/internet_service_provider.dart';
import 'package:sentro/screen/main_view/Dashboard/views/transaction_history.dart';
import 'package:sentro/screen/main_view/Dashboard/views/waste_management.dart';
import 'package:sentro/screen/onboarding/view/confirmation_page.dart';
import 'package:sentro/core/widgets/welcome_page.dart';
import 'package:sentro/screen/main_view/main_view.dart';
import 'package:sentro/screen/onboarding/view/choose_sentro_tag.dart';
import 'package:sentro/screen/onboarding/view/confirm_bvn.dart';
import 'package:sentro/screen/onboarding/view/confirm_phone_number.dart';
import 'package:sentro/screen/onboarding/view/create_account.dart';
import 'package:sentro/screen/onboarding/view/create_password.dart';
import 'package:sentro/screen/onboarding/view/create_pin.dart';
import 'package:sentro/screen/onboarding/view/get_started.dart';
import 'package:sentro/screen/onboarding/view/login.dart';
import 'package:sentro/screen/onboarding/view/reset_password.dart';
import 'package:sentro/screen/onboarding/view/splash.dart';
import 'package:sentro/screen/onboarding/view/verify_phone.dart';

part 'app_routes.dart';

class AppPages {
  //onboarding
  static const splash = Routes.initial;
  static const getStarted = Routes.getStarted;
  static const createAccount = Routes.createAccount;
  static const confirmPhoneNumber = Routes.confirmPhoneNumber;
  static const confirmBvn = Routes.confirmBvn;
  static const createPassword = Routes.createPassword;
  static const chooseSentroTag = Routes.chooseSentroTag;
  static const createPin =Routes.createPin;
  static const welcome = Routes.welcome;
  static const verifyPhone = Routes.verifyPhone;
  static const login = Routes.login;
  static const resetPassword = Routes.resetPassword;
  static const confirmationScreen = Routes.confirmation;

  //dashboard
  static const mainview = Routes.mainView;
  static const transactionHistory = Routes.transactionHistory;
  static const electricity = Routes.electricity;
  static const cableTv = Routes.cableTV;
  static const betting = Routes.betting;
  static const internetService = Routes.internetService;
  static const wasteManagement = Routes.wastemanagent;
  static const academics = Routes.academics;

  //shared
  static const confirmPin = Routes. confirmPin;
  static const confirmTransaction = Routes.confirmTransaction;
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
    GetPage(
      name: confirmPhoneNumber,
      page: () => const ConfirmPhoneNumber(),
      arguments: {
        "fromConfirmBvn": true,
      },
    ),
    GetPage(
      name: confirmBvn,
      page: () => const ConfirmBvn(),
    ),
    GetPage(
      name: createPassword,
      page: () => const CreatePassword(),
    ),
    GetPage(
      name: chooseSentroTag,
      page: () => const ChooseSentroTag(),
    ),
    GetPage(
      name: createPin,
      page: () => const CreatePin(),
    ),
    GetPage(
      name: welcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: verifyPhone,
      page: () => const VerifyPhone(),
    ),
    GetPage(
      name: login,
      page: () => const Login(),
    ),
    GetPage(
      name: confirmPin,
      page: () => const ConfirmPin(),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ResetPassword(),
    ),
    GetPage(
      name: mainview,
      page: () => const MainView(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: confirmationScreen,
      page: () => const ConfirmationPage(),
    ),
    GetPage(
      name: confirmTransaction,
      page: () => const ConfirmTransaction(),
    ),
    GetPage(
      name: transactionHistory,
      page: () => const TransactionHistory(),
    ),
    GetPage(
      name: electricity,
      page: () => const Electricity(),
    ),
    GetPage(
      name: cableTv,
      page: () => const CableTv(),
    ),
    GetPage(
      name: betting,
      page: () => const Betting(),
    ),
    GetPage(
      name: internetService,
      page: () => const InternetServiceProvider(),
    ),
    GetPage(
      name: wasteManagement,
      page: () => const WasteManagement(),
    ),
    GetPage(
      name: academics,
      page: () => const Academics(),
    ),
  ];
}
