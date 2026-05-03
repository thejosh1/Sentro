const String imageAssetRoot = "assets/";

final String splash = _getImagePath('images/svg/splash.svg');
final String logo = _getImagePath('images/svg/logo.svg');

String _getImagePath(String imageName) => imageAssetRoot + imageName;