import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/models/transfer.dart';
import 'package:sentro/core/router/app_pages.dart';
import 'package:sentro/core/utils/action_button.dart';
import 'package:sentro/core/utils/text.dart';
import 'package:sentro/core/widgets/text_field.dart';

class RequestFromSentro extends StatefulWidget {
  const RequestFromSentro({super.key});

  @override
  State<RequestFromSentro> createState() => _RequestFromSentroState();
}

class _RequestFromSentroState extends State<RequestFromSentro> {
  final TextEditingController tagController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _obscured = false;

  bool _tagResolved = false;
  TransferRecipient? _selectedUser;

  final List<TransferRecipient> _dummyUsers= [
    TransferRecipient.sentro(image: user1, name: 'Richmond Uche', tag: '@richmond'),
    TransferRecipient.sentro(image: user2, name: 'Richmond Speed', tag: '@richmondspeed'),
    TransferRecipient.sentro(image: user3, name: 'Richmond Tech', tag: '@richmondtech'),
  ];

  List<TransferRecipient> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    tagController.addListener(() {
      final query = tagController.text.toLowerCase();
      setState(() {
        if (_selectedUser == null) {
          _tagResolved = query.isNotEmpty;
          _filteredUsers = _dummyUsers.where((user) {
            return user.tag!.toLowerCase().contains(query) ||
                user.name.toLowerCase().contains(query);
          }).toList();
        }
      });
    });
  }

  @override
  void dispose() {
    tagController.dispose();
    amountController.dispose();
    super.dispose();
  }

  String _shortenTag(String tag) {
    if (tag.length <= 6) return tag;
    return '${tag.substring(0, 5)}...';
  }

  void _selectUser(TransferRecipient user) {
    setState(() {
      _selectedUser = user;
      _tagResolved = false;
      _filteredUsers.clear();
      tagController.text = user.tag!.replaceFirst('@', '');
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedUser = null;
      _tagResolved = false;
      _filteredUsers.clear();
      tagController.clear();
    });
  }

  Widget _resolvedChip(bool isDark, ColorScheme colorScheme) {
    return Container(
      width: widthSize(191.58),
      height: heightSize(30),
      padding: EdgeInsets.symmetric(vertical: heightSize(3.42)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(110.65),
        // Light: soft green tint; Dark: original sTierColor
        color: isDark ? sTierColor : colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: widthSize(7.09)),
          SvgPicture.asset(
            tick,
            width: widthSize(21.26),
            height: heightSize(21.26),
            // Tint tick green in both modes
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
          SizedBox(width: widthSize(3.32)),
          CText(
            text: _selectedUser!.name,
            fontWeight: CFONT.wRegular,
            fontFamily: CFONT.FAMILY,
            size: 15.49,
            color: colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _saveBeneficiaryButton(bool isDark, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: widthSize(167.01),
          height: heightSize(33.86),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(124.89),
            // Light: primary green; Dark: original sBeneficiaryColor
            color: isDark ? sBeneficiaryColor : colorScheme.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                addSquare,
                width: widthSize(24),
                height: heightSize(24),
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: widthSize(3.75)),
              CText(
                text: 'Save Beneficiary',
                size: 17.48,
                fontFamily: CFONT.FAMILY,
                fontWeight: CFONT.wRegular,
                color: isDark ? Colors.white : colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    // Semantic surface colors derived from theme
    final cardColor = isDark ? sDescriptionColor : colorScheme.surface;
    final pillActiveColor = sActiveColor;
    final pillActiveTextColor = isDark ? sNavContainer : colorScheme.onPrimary;
    final labelColor = isDark ? Colors.white : colorScheme.onSurface;
    final subtleTextColor = isDark ? sGrey2 : const Color(0xFF999999);
    final dropdownBorderColor = isDark ? sDarkBorder : const Color(0xFFE0E0E0);
    final dropdownDividerColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.06);

    // Action button (bottom CTA)
    final ctaBgColor = isDark ? sNavContainer : colorScheme.primary;
    final ctaTextColor = isDark ? sActionButton : colorScheme.onPrimary;

    // Suffix container inside amount field
    final suffixContainerColor = isDark ? sContainerColor : colorScheme.surface;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: widthSize(25)),
            child: Column(
              children: [
                SizedBox(height: heightSize(64)),

                // ── Header ────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        isDark?arrowBackWhite:arrowBack,
                        width: widthSize(42),
                        height: heightSize(42),
                      ),
                    ),
                    Container(
                      height: heightSize(34.18),
                      padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(113.27),
                        color: isDark ? sButtonFillDark
                            : sLightFill,
                        border: Border.all(color: isDark ? sDarkBorder
                            : sLightFill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            wallet,
                            width:  widthSize(18),
                            height: heightSize(18),
                            colorFilter: ColorFilter.mode(
                              isDark ? sNavContainer : sActionButton,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: widthSize(4)),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _obscured
                                ? Text(
                              '••••••',
                              key: const ValueKey('hidden'),
                              style: TextStyle(
                                fontSize: fontSize(13),
                                fontFamily: CFONT.FAMILY,
                                fontWeight: CFONT.wRegular,
                                color: isDark? Colors.white
                                    : sActionButton,
                                letterSpacing: 2,
                              ),
                            )
                                : RichText(
                              key: const ValueKey('shown'),
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₦50,000',
                                    style: TextStyle(
                                      inherit: false, // break font inheritance → ₦ renders
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: isDark? Colors.white
                                          : sActionButton,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '.00',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: CFONT.wRegular,
                                      fontFamily: CFONT.FAMILY,
                                      color: isDark? Colors.white
                                          : sActionButton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize(4)),
                          GestureDetector(
                            onTap: () => setState(() => _obscured = !_obscured),
                            child: SvgPicture.asset(
                              _obscured ? visibilityOff : hide,
                              width: widthSize(18),
                              height: heightSize(18),
                              colorFilter: ColorFilter.mode(
                                isDark ? Colors.white54 : Colors.black45,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: heightSize(26.46)),
                CText(
                  text: 'Request Money',
                  size: 19.85,
                  fontWeight: CFONT.wMedium,
                  fontFamily: CFONT.FAMILY,
                  height: 22.05 / 19.85,
                  color: colorScheme.onSurface,
                ),
                SizedBox(height: heightSize(10)),

                // ── Sentro Tag pill ───────────────────────────
                Container(
                  width: widthSize(151),
                  height: heightSize(62),
                  padding: EdgeInsets.symmetric(
                    horizontal: widthSize(9.5),
                    vertical: 6.32,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44.7),
                    color: cardColor,
                  ),
                  child: Container(
                    width: widthSize(132),
                    height: heightSize(49),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44.7),
                      color: pillActiveColor,
                    ),
                    child: Center(
                      child: CText(
                        text: 'Sentro Tag',
                        size: 15.64,
                        fontFamily: CFONT.FAMILY,
                        fontWeight: CFONT.wRegular,
                        color: pillActiveTextColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: heightSize(40)),

                // ── Beneficiary button ────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: widthSize(126),
                      height: heightSize(30.8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(124.89),
                        color: cardColor,
                      ),
                      child: Center(
                        child: CText(
                          text: 'Beneficiary',
                          size: 17.48,
                          fontWeight: CFONT.wRegular,
                          fontFamily: CFONT.FAMILY,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: heightSize(10)),

                // ── Tag input ─────────────────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      hasBottomMargin: false,
                      height: heightSize(55),
                      hint: 'richmond',
                      controller: tagController,
                      inputType: TextInputType.text,
                      error: '',
                      hintColor: subtleTextColor,
                      prefixWidget: CText(
                        text: '@',
                        color: colorScheme.onSurface,
                        size: 18,
                        fontWeight: CFONT.wMedium,
                      ),
                      validFunction: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Input a Sentro tag.";
                        }
                        return null;
                      },
                    ),

                    // ── Dropdown suggestions ──────────────────
                    if (_tagResolved && _filteredUsers.isNotEmpty && _selectedUser == null) ...[
                      SizedBox(height: heightSize(4)),
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: dropdownBorderColor),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _filteredUsers.length,
                          separatorBuilder: (_, __) =>
                              Divider(height: 1, color: dropdownDividerColor),
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return InkWell(
                              onTap: () => _selectUser(user),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widthSize(16),
                                  vertical: heightSize(14),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundImage: AssetImage(user.image),
                                    ),
                                    SizedBox(width: widthSize(12)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CText(
                                          text: user.tag!,
                                          size: 15,
                                          fontWeight: CFONT.wMedium,
                                          fontFamily: CFONT.FAMILY,
                                          color: colorScheme.onSurface,
                                        ),
                                        SizedBox(height: heightSize(2)),
                                        CText(
                                          text: user.name,
                                          size: 13,
                                          color: subtleTextColor,
                                          fontWeight: CFONT.wRegular,
                                          fontFamily: CFONT.FAMILY,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    // ── Resolved: chip + amount + save beneficiary ─
                    if (_selectedUser != null) ...[
                      SizedBox(height: heightSize(10)),
                      _resolvedChip(isDark, colorScheme),
                      SizedBox(height: heightSize(15)),
                      AppTextField(
                        showNairaPrefix: true,
                        hasBottomMargin: false,
                        height: heightSize(55),
                        hint: '0.00',
                        controller: amountController,
                        inputType: TextInputType.number,
                        error: '',
                        validFunction: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Input an amount.";
                          }
                          return null;
                        },
                        suffixWidth: 87,
                        suffixWidget: Container(
                          height: heightSize(25.86),
                          padding: EdgeInsets.symmetric(horizontal: widthSize(10)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(124.89),
                            color: suffixContainerColor,
                          ),
                          child: Center(
                            child: CText(
                              text: 'Min: N500',
                              size: 14,
                              fontWeight: CFONT.wRegular,
                              fontFamily: CFONT.FAMILY,
                              color: subtleTextColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: heightSize(10)),
                      _saveBeneficiaryButton(isDark, colorScheme),
                      SizedBox(height: heightSize(20)),
                    ],

                    // ── Recently label ────────────────────────
                    if (_selectedUser == null) ...[
                      SizedBox(height: heightSize(20)),
                      CText(
                        text: 'Recently',
                        size: 16,
                        fontWeight: CFONT.wRegular,
                        fontFamily: CFONT.FAMILY,
                        color: labelColor,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ── Recent horizontal list ────────────────────────
          if (_selectedUser == null) ...[
            SizedBox(height: heightSize(15)),
            SizedBox(
              height: heightSize(98),
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _dummyUsers.length,
                padding: EdgeInsets.only(left: widthSize(25)),
                separatorBuilder: (_, __) => SizedBox(width: widthSize(15)),
                itemBuilder: (context, index) {
                  final user = _dummyUsers[index];
                  return GestureDetector(
                    onTap: () => _selectUser(user),
                    child: SizedBox(
                      width: widthSize(64),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widthSize(55),
                            height: heightSize(55),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(user.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: heightSize(5)),
                          Text(
                            _shortenTag(user.tag ?? ''),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: CFONT.wMedium,
                              // Adapts to theme
                              color: labelColor,
                              fontFamily: CFONT.FAMILY,
                            ),
                          ),
                          Text(
                            user.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: CFONT.wRegular,
                              color: subtleTextColor,
                              fontFamily: CFONT.FAMILY,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          const Spacer(),

          Padding(
            padding: EdgeInsets.only(
              bottom: heightSize(50),
              left: widthSize(25),
              right: widthSize(25),
            ),
            child: ActionButton(
              text: 'Receive Money',
              color: ctaBgColor,
              textColor: ctaTextColor,
              callback: () => Get.toNamed(
                Routes.confirmTransfer,
                arguments: {
                  'isSentroTag': true,
                  'isRequest': true,
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}