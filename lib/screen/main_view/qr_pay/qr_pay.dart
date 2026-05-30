import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/controllers/permission_controller.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/balance_pill.dart';

class QrPay extends StatefulWidget {
  final bool showBackButton;
  const QrPay({super.key,  this.showBackButton = true, });

  @override
  State<QrPay> createState() => _QrPayState();
}

class _QrPayState extends State<QrPay> {
  final ScrollController _scrollController = ScrollController();
  late final Worker _permissionWorker;
  bool _obscured = false;

  bool isRecentSelected = false;
  bool _scanned = false;
  bool _navigatedToPermissions = false;

  final MobileScannerController _cameraController =
  MobileScannerController(autoStart: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _permissionWorker = ever<bool>(
        PermissionController.to.cameraGranted,
            (granted) async {
          if (!granted && !_navigatedToPermissions) {
            _navigatedToPermissions = true;
            await _stopScanner();
            if (Get.currentRoute != Routes.permissions) {
              Get.toNamed(Routes.permissions);
            }
          }
        },
      );

      _initCamera();
    });
  }

  Future<void> _initCamera() async {
    final granted =
    await PermissionController.to.requestCameraPermission();

    if (!granted) return;

    await _startScanner();
  }

  Future<void> _startScanner() async {
    if (!PermissionController.to.cameraGranted.value) return;

    try {
      await _cameraController.start();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (_) {}
  }

  Future<void> _stopScanner() async {
    try {
      await _cameraController.stop();
    } catch (_) {}
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_scanned) return;

    final barcode = capture.barcodes.firstOrNull;

    if (barcode?.rawValue == null) return;

    _scanned = true;

    await _stopScanner();

    final scannedValue = barcode!.rawValue!;

    Get.snackbar('QR Scanned', scannedValue);
  }

  Widget _corner(Alignment alignment) {
    final isTop =
        alignment == Alignment.topLeft ||
            alignment == Alignment.topRight;

    final isLeft =
        alignment == Alignment.topLeft ||
            alignment == Alignment.bottomLeft;

    return Align(
      alignment: alignment,
      child: Container(
        width: widthSize(24),
        height: heightSize(24),
        decoration: BoxDecoration(
          border: Border(
            top: isTop
                ? BorderSide(
              color: sNavContainer,
              width: 3,
            )
                : BorderSide.none,
            bottom: !isTop
                ? BorderSide(
              color: sNavContainer,
              width: 3,
            )
                : BorderSide.none,
            left: isLeft
                ? BorderSide(
              color: sNavContainer,
              width: 3,
            )
                : BorderSide.none,
            right: !isLeft
                ? BorderSide(
              color: sNavContainer,
              width: 3,
            )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _permissionWorker.dispose();
    _cameraController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  bool _torchEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(
          widthSize(25),
          0,
          widthSize(25),
          heightSize(40),
        ),
        child: Column(
          children: [
            SizedBox(height: heightSize(64)),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showBackButton)
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      isDark ? arrowBackWhite : arrowBack,
                      width: widthSize(42),
                      height: heightSize(42),
                    ),
                  )
                else
                  SizedBox(width: widthSize(42)),
                BalancePill(isDark: isDark),
              ],
            ),

            SizedBox(height: heightSize(30.33)),

            /// TAB SWITCHER
            Container(
              width: widthSize(239.14),
              height: heightSize(61.46),
              padding: EdgeInsets.symmetric(
                horizontal: widthSize(9.57),
              ),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(44.7),
                color: sDescriptionColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isRecentSelected = false;
                          _scanned = false;
                        });

                        await _startScanner();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),
                        height: heightSize(48.05),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            44.7,
                          ),
                          color: !isRecentSelected
                              ? sActiveColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: CText(
                            text: 'Scan QR',
                            fontFamily:
                            CFONT.FAMILY,
                            fontWeight:
                            CFONT.wRegular,
                            size: 15.64,
                            color:
                            !isRecentSelected
                                ? sNavContainer
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isRecentSelected = true;
                        });

                        await _stopScanner();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 180,
                        ),
                        height: heightSize(48.05),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(
                            44.7,
                          ),
                          color: isRecentSelected
                              ? sActiveColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: CText(
                            text: 'My QR',
                            fontFamily:
                            CFONT.FAMILY,
                            fontWeight:
                            CFONT.wRegular,
                            size: 15.64,
                            color:
                            isRecentSelected
                                ? sNavContainer
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: heightSize(20)),

            if (!isRecentSelected) ...[
              CText(
                text: 'Scan QR',
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                size: 19.85,
              ),

              SizedBox(height: heightSize(2.76)),

              CText(
                text:
                'Send money faster using QR Code',
                size: 16,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: isDark?sConfirmTextColor:sGrey2,
              ),

              SizedBox(height: heightSize(22.73)),

              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: heightSize(402),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Obx(() {
                      final granted =
                          PermissionController
                              .to
                              .cameraGranted
                              .value;

                      if (!granted) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return MobileScanner(
                        controller: _cameraController,
                        onDetect: _onDetect,
                        overlayBuilder: (context, constraints) {
                          return Stack(
                            children: [
                              Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: widthSize(180),
                                      height: widthSize(220),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: sNavContainer,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      child: Stack(
                                        children: [
                                          _corner(Alignment.topLeft),
                                          _corner(Alignment.topRight),
                                          _corner(
                                              Alignment.bottomLeft),
                                          _corner(
                                              Alignment.bottomRight),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(height: heightSize(38),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Flashlight
                  GestureDetector(
                    onTap: () async {
                      await _cameraController.toggleTorch();

                      setState(() {
                        _torchEnabled = !_torchEnabled;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _torchEnabled
                            ? sNavContainer.withOpacity(0.15)
                            : Colors.transparent,
                      ),
                      child: SvgPicture.asset(
                        electricity,
                        width: widthSize(65),
                        height: heightSize(65),
                        colorFilter: isDark?_torchEnabled?ColorFilter.mode(
                          sNavContainer,
                          BlendMode.srcIn,
                        ):null:ColorFilter.mode(
                          sTextGreen,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  // Gallery / Camera
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.sendQr),
                    child: SvgPicture.asset(
                      picture,
                      width: widthSize(65),
                      height: heightSize(65),
                      colorFilter: isDark?null:ColorFilter.mode(
                        sActionButton,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: heightSize(61),),
            ] else ...[
              CText(
                text: 'My QR Code',
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wMedium,
                size: 19.85,
              ),

              SizedBox(height: heightSize(2.76)),

              CText(
                text: 'Instantly receive money using QR Code',
                size: 16,
                fontWeight: CFONT.wRegular,
                fontFamily: CFONT.FAMILY,
                color: isDark ? sConfirmTextColor : sGrey2,
              ),

              SizedBox(height: heightSize(22.73)),

              /// USER INFO CARD
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: widthSize(16),
                  vertical: heightSize(14),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDark ? sButtonFillDark : sLightFill,
                  border: Border.all(
                    color: isDark ? sDarkBorder : sLightFill,
                  ),
                ),
                child: Row(
                  children: [
                    /// Avatar
                    CircleAvatar(
                      radius: widthSize(22),
                      backgroundImage: AssetImage(sentroTag), // replace with your avatar asset
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                    ),
                    SizedBox(width: widthSize(12)),

                    /// Name & handle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            text: 'Richmond Uche',   // replace with dynamic user name
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wMedium,
                            size: 15,
                          ),
                          SizedBox(height: heightSize(2)),
                          CText(
                            text: '@richmonduche',   // replace with dynamic handle
                            fontFamily: CFONT.FAMILY,
                            fontWeight: CFONT.wRegular,
                            size: 13,
                            color: isDark ? sConfirmTextColor : sGrey2,
                          ),
                        ],
                      ),
                    ),

                    /// Copy button
                    GestureDetector(
                      onTap: () {
                        // TODO: copy QR link / user ID to clipboard
                      },
                      child: Container(
                        width: widthSize(36),
                        height: heightSize(36),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                        ),
                        child: SvgPicture.asset(
                          copy,   // replace with your copy SVG asset path
                          width: widthSize(18),
                          height: heightSize(18),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),

                    SizedBox(width: widthSize(8)),

                    /// Share button
                    GestureDetector(
                      onTap: () {
                        // TODO: trigger native share sheet
                      },
                      child: Container(
                        width: widthSize(36),
                        height: heightSize(36),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                        ),
                        child: SvgPicture.asset(
                          share,   // replace with your share SVG asset path
                          width: widthSize(18),
                          height: heightSize(18),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: heightSize(16)),

              /// QR CODE CARD
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(widthSize(20)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isDark ? sButtonFillDark : sLightFill,
                  border: Border.all(
                    color: isDark ? sDarkBorder : sLightFill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,            // QR always white bg regardless of mode
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(widthSize(16)),
                  child: Image.asset(
                    qrCode,                         // your asset path constant
                    width: double.maxFinite,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}