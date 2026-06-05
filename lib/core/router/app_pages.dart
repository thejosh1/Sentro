
import 'package:get/get.dart';
import 'package:sentro/core/widgets/confirm_pin.dart';
import 'package:sentro/core/widgets/confirm_transaction.dart';
import 'package:sentro/screen/main_view/Dashboard/views/academics.dart';
import 'package:sentro/screen/main_view/Dashboard/views/betting.dart';
import 'package:sentro/screen/main_view/Dashboard/views/cable_tv.dart';
import 'package:sentro/screen/main_view/Dashboard/views/electricity.dart';
import 'package:sentro/screen/main_view/Dashboard/views/internet_service_provider.dart';
import 'package:sentro/screen/main_view/Dashboard/views/transaction_history.dart';
import 'package:sentro/screen/main_view/accounts/account_limit.dart';
import 'package:sentro/screen/main_view/accounts/account_statement.dart';
import 'package:sentro/screen/main_view/beneficiary/beneficiaries.dart';
import 'package:sentro/screen/main_view/cards/card_summary.dart';
import 'package:sentro/screen/main_view/cards/transaction_action.dart';
import 'package:sentro/screen/main_view/cards/virtual_card.dart';
import 'package:sentro/screen/main_view/global_pay/account_summary.dart';
import 'package:sentro/screen/main_view/global_pay/create_pay_account.dart';
import 'package:sentro/screen/main_view/global_pay/send_money.dart';
import 'package:sentro/screen/main_view/global_pay/send_summary.dart';
import 'package:sentro/screen/main_view/global_pay/swap_currency.dart';
import 'package:sentro/screen/main_view/notifications/notification_settings.dart';
import 'package:sentro/screen/main_view/profile/terms.dart';
import 'package:sentro/screen/main_view/security/face_verification.dart';
import 'package:sentro/screen/main_view/security/repeat_pin.dart';
import 'package:sentro/screen/main_view/verification/upgrade_account.dart';
import 'package:sentro/screen/main_view/Dashboard/views/waste_management.dart';
import 'package:sentro/screen/main_view/Saving&Investments/active_goals.dart';
import 'package:sentro/screen/main_view/Saving&Investments/goals_details.dart';
import 'package:sentro/screen/main_view/Saving&Investments/savings_summary.dart';
import 'package:sentro/screen/main_view/Saving&Investments/savings_type.dart';
import 'package:sentro/screen/main_view/Saving&Investments/start_saving.dart';
import 'package:sentro/screen/main_view/loans/active_loans.dart';
import 'package:sentro/screen/main_view/loans/decision.dart';
import 'package:sentro/screen/main_view/loans/eligibility_test.dart';
import 'package:sentro/screen/main_view/loans/loan_calculator.dart';
import 'package:sentro/screen/main_view/loans/loan_summary.dart';
import 'package:sentro/screen/main_view/loans/repayment.dart';
import 'package:sentro/screen/main_view/loans/take_loan.dart';
import 'package:sentro/screen/main_view/profile/my_qr_page.dart';
import 'package:sentro/screen/main_view/profile/profile_page.dart';
import 'package:sentro/screen/main_view/qr_pay/qr_pay.dart';
import 'package:sentro/screen/main_view/qr_pay/send_qr.dart';
import 'package:sentro/screen/main_view/security/app_lock.dart';
import 'package:sentro/screen/main_view/security/change_password.dart';
import 'package:sentro/screen/main_view/security/change_pin.dart';
import 'package:sentro/screen/main_view/security/enable_biometrics.dart';
import 'package:sentro/screen/main_view/security/linked_devices.dart';
import 'package:sentro/screen/main_view/security/permissions.dart';
import 'package:sentro/screen/main_view/security/security.dart';
import 'package:sentro/screen/main_view/transfers/confirm_transfer.dart';
import 'package:sentro/screen/main_view/transfers/request_from_sentro.dart';
import 'package:sentro/screen/main_view/transfers/transfer.dart';
import 'package:sentro/screen/main_view/transfers/transfer_detail.dart';
import 'package:sentro/screen/main_view/verification/verification.dart';
import 'package:sentro/screen/onboarding/view/confirmation_page.dart';
import 'package:sentro/core/widgets/welcome_page.dart';
import 'package:sentro/screen/main_view/main_view.dart';
import 'package:sentro/screen/onboarding/view/choose_sentro_tag.dart';
import 'package:sentro/screen/onboarding/view/confirm_bvn.dart';
import 'package:sentro/screen/onboarding/view/confirm_phone_number.dart';
import 'package:sentro/screen/onboarding/view/continuos_login.dart';
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
  static const linkedDevices = Routes.linkedDevices;
  static const continuosLogin = Routes.continuosLogin;

  //dashboard
  static const mainview = Routes.mainView;
  static const transactionHistory = Routes.transactionHistory;
  static const electricity = Routes.electricity;
  static const cableTv = Routes.cableTV;
  static const betting = Routes.betting;
  static const internetService = Routes.internetService;
  static const wasteManagement = Routes.wastemanagent;
  static const academics = Routes.academics;

  //transfer
  static const transfer = Routes.transfer;
  static const transferDetails = Routes.transferDetails;
  static const confirmTransfer = Routes.confirmTransfer;
  static const requestFromSentro = Routes.requestFromSentro;

  //savings & investment
  static const activeGoals = Routes.activeGoals;
  static const startSaving = Routes.startSaving;
  static const goalsDetails = Routes.goalsDetails;
  static const savingsType = Routes.savingsType;
  static const savingsSummary = Routes.savingsSummary;

  //loans
  static const loanCalculator = Routes.loanCalculator;
  static const eligibilityTest = Routes.eligibilityTest;
  static const decision = Routes.decision;
  static const activeLoan = Routes.activeLoans;
  static const repayment = Routes.repayment;
  static const takeLoan = Routes.takeLoan;
  static const loanSummary = Routes.loanSummary;

  //qrpay
  static const qrPay = Routes.qrPay;
  static const sendQr = Routes.sendQr;

  //profile page
  static const profilePage = Routes.profilePage;
  static const myQrPage = Routes.myQrPage;
  static const terms = Routes.terms;

  //accounts
  static const accountStatement = Routes.accountStatements;
  static const accountLimit = Routes.accountLimit;

  //security
  static const security = Routes.security;
  static const appLock = Routes.appLock;
  static const enableBiometrics = Routes.enableBiometrics;
  static const changePassword = Routes.changePassword;
  static const changePin = Routes.changePin;
  static const permissions = Routes.permissions;
  static const faceVerification = Routes.faceVerification;
  static const repeatPin = Routes.repeatPin;

  //verification
  static const verification = Routes.verification;
  static const upgradeAccount = Routes.upgradeAccount;

  //beneficiaries
  static const beneficiaries = Routes.beneficiaries;

  //notification
  static const notification = Routes.notification;

  //cards
  static const virtualCard = Routes.virtualCard;
  static const cardSummary = Routes.cardSummary;
  static const transactionAction = Routes.transactionAction;

  //global pay
  static const createPayAccount = Routes.createPayAccount;
  static const accountSummary = Routes.accountSummary;
  static const sendMoney = Routes.sendMoney;
  static const sendSummary = Routes.sendSummary;
  static const swapCurrency = Routes.swapCurrency;

  //shared
  static const confirmPin = Routes.confirmPin;
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
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: createAccount,
      page: () => const CreateAccount(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
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
      transitionDuration: const Duration(milliseconds: 200),
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
    GetPage(
      name: transfer,
      page: () => const Transfer(),
    ),
    GetPage(
      name: transferDetails,
      page: () => const TransferDetail(),
    ),
    GetPage(
      name: confirmTransfer,
      page: () => const ConfirmTransfer(),
    ),
    GetPage(
      name: requestFromSentro,
      page: () => const RequestFromSentro(),
    ),
    GetPage(
      name: activeGoals,
      page: () => const ActiveGoals(),
    ),
    GetPage(
      name: startSaving,
      page: () => const StartSaving(),
    ),
    GetPage(
      name: goalsDetails,
      page: () => const GoalsDetails(),
    ),
    GetPage(
      name: savingsType,
      page: () => const SavingsType(),
    ),
    GetPage(
      name: savingsSummary,
      page: () => const SavingsSummary(),
    ),
    GetPage(
      name: loanCalculator,
      page: () => const LoanCalculator(),
    ),
    GetPage(
      name: eligibilityTest,
      page: () => const EligibilityTest(),
    ),
    GetPage(
      name: decision,
      page: () => const Decision(),
    ),
    GetPage(
      name: activeLoan,
      page: () => const ActiveLoans(),
    ),
    GetPage(
      name: repayment,
      page: () => const Repayment(),
    ),
    GetPage(
      name: takeLoan,
      page: () => const TakeLoan(),
    ),
    GetPage(
      name: loanSummary,
      page: () => const LoanSummary(),
    ),
    GetPage(
      name: qrPay,
      page: () => const QrPay(),
    ),
    GetPage(
      name: sendQr,
      page: () => const SendQr(),
    ),
    GetPage(
      name: upgradeAccount,
      page: () => const UpgradeAccount(),
    ),
    GetPage(
      name: profilePage,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: myQrPage,
      page: () => const MyQrPage(),
    ),
    GetPage(
      name: security,
      page: () => const Security(),
    ),
    GetPage(
      name: appLock,
      page: () => const AppLock(),
    ),
    GetPage(
      name: enableBiometrics,
      page: () => const EnableBiometrics(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: changePin,
      page: () => const ChangePin(),
    ),
    GetPage(
      name: linkedDevices,
      page: () => const LinkedDevices(),
    ),
    GetPage(
      name: permissions,
      page: () => const Permissions(),
    ),
    GetPage(
      name: verification,
      page: () => const Verification(),
    ),
    GetPage(
      name: beneficiaries,
      page: () => const Beneficiaries(),
    ),
    GetPage(
      name: accountStatement,
      page: () => const AccountStatement(),
    ),
    GetPage(
      name: accountLimit,
      page: () => const AccountLimit(),
    ),
    GetPage(
      name: terms,
      page: () => const Terms(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationSettings(),
    ),
    GetPage(
      name: continuosLogin,
      page: () => const ContinuousLogin(),
    ),
    GetPage(
      name: virtualCard,
      page: () => const VirtualCard(),
    ),
    GetPage(
      name: cardSummary,
      page: () => const CardSummary(),
    ),
    GetPage(
      name: transactionAction,
      page: () => const TransactionAction(),
    ),
    GetPage(
      name: createPayAccount,
      page: () => const CreatePayAccount(),
    ),
    GetPage(
      name: accountSummary,
      page: () => const AccountSummary(),
    ),
    GetPage(
      name: sendMoney,
      page: () => const SendMoneyPage(),
    ),
    GetPage(
      name: sendSummary,
      page: () => const SendSummary(),
    ),
    GetPage(
      name: swapCurrency,
      page: () => const SwapCurrencyPage(),
    ),
    GetPage(
      name: faceVerification,
      page: () => const FaceVerification(),
    ),
    GetPage(
      name: repeatPin,
      page: () => const RepeatPin(),
    ),
  ];
}
