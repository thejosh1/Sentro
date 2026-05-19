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
  static const electricity = '/electricity';
  static const cableTV = '/cable-tv';
  static const betting = '/betting';
  static const internetService = '/internet-service';
  static const wastemanagent = '/waste-management';
  static const academics = '/academics';

  //transfers
  static const transfer = '/transfer';
  static const transferDetails = '/transfer-details';
  static const confirmTransfer = '/confirm-transfer';
  static const requestFromSentro = '/request-from-sentro';

  //savings % investmens
  static const activeGoals = '/active-goals';
  static const startSaving = '/start-saving';
  static const goalsDetails = '/goals-details';
  static const savingsType = '/savings-type';
  static const savingsSummary = '/savings-summary';

  //loans
  static const loanCalculator = '/loan-calculator';
  static const eligibilityTest = '/eligibility-test';
  static const decision = '/decision';
  static const activeLoans = '/active-loans';
  static const repayment = '/repayment';
  static const takeLoan = '/take-loan';
  static const loanSummary = '/loan-summary';

  //widgets
  static const confirmTransaction = '/confirm-transaction';
}
