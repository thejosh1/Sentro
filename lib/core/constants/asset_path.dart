const String imageAssetRoot = "assets/";

final String splash = _getImagePath('images/svg/splash.svg');
final String logo = _getImagePath('images/svg/logo.svg');
final String logo1x = _getImagePath('images/svg/sentro-logo.svg');

//icons
final String arrowBack = _getImagePath('icon/svg/arrow_back.svg');

String _getImagePath(String imageName) => imageAssetRoot + imageName;