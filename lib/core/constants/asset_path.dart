const String imageAssetRoot = "assets/";

final String splash = _getImagePath('images/svg/splash.svg');
final String logo = _getImagePath('images/svg/logo.svg');
final String logo1x = _getImagePath('images/svg/sentro-logo.svg');
final String fingerScan = _getImagePath('images/svg/finger-scan.svg');
final String check = _getImagePath('images/svg/check.svg');
final String nigeria = _getImagePath('images/svg/nigeria.svg');
final String goldMedal = _getImagePath('images/svg/gold-medal.svg');
final String notification = _getImagePath('images/svg/notification.svg');
final String sendMoney = _getImagePath('images/svg/send-money.svg');
final String receiveMoney = _getImagePath('images/svg/receive-money.svg');

//icons
final String arrowBack = _getImagePath('icon/svg/arrow_back.svg');
final String call = _getImagePath('icon/svg/call.svg');
final String headPhone = _getImagePath('icon/svg/headphone.svg');
final String hide = _getImagePath('icon/svg/hide.svg');
final String cancel = _getImagePath('icon/svg/cancel.svg');
final String home = _getImagePath('icon/svg/home.svg');
final String qrPay = _getImagePath('icon/svg/qrpay.svg');
final String ai = _getImagePath('icon/svg/ai.svg');
final String card = _getImagePath('icon/svg/card.svg');
final String history = _getImagePath('icon/svg/document.svg');
final String arrowDown = _getImagePath('icon/svg/arrow-down.svg');
final String token = _getImagePath('icon/svg/token.svg');

//png icons
final String aiIcon = _getImagePath('icon/png/ai.png');
final String avatar = _getImagePath('icon/png/avatar.png');

String _getImagePath(String imageName) => imageAssetRoot + imageName;