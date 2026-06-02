import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/utils/text.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isRecentSelected = false;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          widthSize(25),
          heightSize(64),
          widthSize(25),
          heightSize(46),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    isDark?arrowBackWhite:arrowBack,
                    width: widthSize(42),
                    height: heightSize(42),
                  ),
                ),
                const Spacer(),
                CText(
                  text: 'Terms & Conditions',
                  size: 18,
                  fontFamily: CFONT.FAMILY,
                  fontWeight: CFONT.wMedium,
                  height: 20 / 18,
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: heightSize(28),),
            /// TAB SWITCHER
            Container(
              height: heightSize(62),
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
                      onTap: () {
                        setState(() {
                          isRecentSelected = false;
                        });
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
                            text: 'Terms & Conditions',
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
                      onTap: () {
                        setState(() {
                          isRecentSelected = true;
                        });
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
                            text: 'About Sentro',
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
            SizedBox(height: heightSize(33),),
            if (!isRecentSelected) ...[
              Container(
                //height: heightSize(692),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: widthSize(25),
                  top: heightSize(20),
                  right: widthSize(25),
                  bottom: heightSize(20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDark?sDarkFill:sLightFill,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text:
                      'Lorem ipsum dolor sit amet consectetur. Egestas justo consectetur aliquam orci malesuada adipiscing. Quis posuere dictum lectus nunc. Iaculis accumsan mattis accumsan viverra ut risus in. Aliquet cras elit dui duis arcu sed. Tellus et eros etiam posuere magna interdum. Phasellus semper turpis magnis nisl nibh. Porttitor vitae pulvinar purus vitae. Volutpat nunc tincidunt fermentum odio. Euismod amet mattis amet tempus duis ultricies sit. Morbi morbi et pretium elit ut mollis nullam diam.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Pharetra ornare vitae viverra maecenas at. Orci quisque viverra pharetra rhoncus eleifend felis. Aenean arcu dolor donec id sit turpis aliquet. Id fermentum blandit mauris magna pretium curabitur. Auctor morbi cras nisl volutpat dictumst. Semper vitae feugiat nec sed blandit eget. Hendrerit ornare ac vitae elit.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Diam purus erat vulputate viverra consequat leo massa volutpat lectus. Lacus at scelerisque egestas ac sit nisl nulla at et. Lectus enim sapien ullamcorper non velit nibh enim at. Sed dui facilisi potenti risus sollicitudin consequat sagittis sed nec. Sed nunc viverra quam nunc vitae tincidunt phasellus. Sit aliquet egestas quisque commodo pharetra venenatis in ultrices.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Volutpat eu libero et nisl. Proin consequat vestibulum libero tellus donec. Mi est integer quis nisi sit dolor condimentum arcu. Quis sollicitudin vulputate dignissim cursus suspendisse eget dictum vel. Augue ante ante neque quis lobortis in habitant suscipit. Suspendisse a quis semper pharetra et mattis vivamus ut.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Lacus in fusce nunc neque at. Amet non odio etiam venenatis blandit quis arcu a enim. Ipsum sit ac cras condimentum nulla euismod sit rhoncus. Neque id vulputate arcu est velit consectetur interdum. Aliquam tristique id non libero facilisis vel. Gravida vel fermentum nulla lorem.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Ut porta fames semper nulla facilisis velit vulputate pellentesque. Maecenas hendrerit curabitur vulputate eu arcu nibh est id. Congue sodales nunc risus orci nullam. Lorem lectus arcu dui facilisi est parturient sagittis penatibus sit.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Pellentesque at amet viverra diam turpis pellentesque aliquet. Ultrices commodo nec pellentesque tortor enim. Amet nibh quam justo egestas bibendum lectus. Phasellus et potenti lorem mi egestas. Gravida eget nullam sed placerat orci in.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Diam ante et viverra in odio integer at.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                //height: heightSize(692),
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: widthSize(25),
                  top: heightSize(20),
                  right: widthSize(25),
                  bottom: heightSize(20),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDark?sDarkFill:sLightFill,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: SvgPicture.asset(isDark?logoWhite:logoLight, width: widthSize(110.93), height: heightSize(26),)),
                    SizedBox(height: heightSize(22),),
                    CText(
                      text:
                      'Lorem ipsum dolor sit amet consectetur. Egestas justo consectetur aliquam orci malesuada adipiscing. Quis posuere dictum lectus nunc. Iaculis accumsan mattis accumsan viverra ut risus in. Aliquet cras elit dui duis arcu sed. Tellus et eros etiam posuere magna interdum. Phasellus semper turpis magnis nisl nibh. Porttitor vitae pulvinar purus vitae. Volutpat nunc tincidunt fermentum odio. Euismod amet mattis amet tempus duis ultricies sit. Morbi morbi et pretium elit ut mollis nullam diam.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Pharetra ornare vitae viverra maecenas at. Orci quisque viverra pharetra rhoncus eleifend felis. Aenean arcu dolor donec id sit turpis aliquet. Id fermentum blandit mauris magna pretium curabitur. Auctor morbi cras nisl volutpat dictumst. Semper vitae feugiat nec sed blandit eget. Hendrerit ornare ac vitae elit.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Diam purus erat vulputate viverra consequat leo massa volutpat lectus. Lacus at scelerisque egestas ac sit nisl nulla at et. Lectus enim sapien ullamcorper non velit nibh enim at. Sed dui facilisi potenti risus sollicitudin consequat sagittis sed nec. Sed nunc viverra quam nunc vitae tincidunt phasellus. Sit aliquet egestas quisque commodo pharetra venenatis in ultrices.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Volutpat eu libero et nisl. Proin consequat vestibulum libero tellus donec. Mi est integer quis nisi sit dolor condimentum arcu. Quis sollicitudin vulputate dignissim cursus suspendisse eget dictum vel. Augue ante ante neque quis lobortis in habitant suscipit. Suspendisse a quis semper pharetra et mattis vivamus ut.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Lacus in fusce nunc neque at. Amet non odio etiam venenatis blandit quis arcu a enim. Ipsum sit ac cras condimentum nulla euismod sit rhoncus. Neque id vulputate arcu est velit consectetur interdum. Aliquam tristique id non libero facilisis vel. Gravida vel fermentum nulla lorem.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Ut porta fames semper nulla facilisis velit vulputate pellentesque. Maecenas hendrerit curabitur vulputate eu arcu nibh est id. Congue sodales nunc risus orci nullam. Lorem lectus arcu dui facilisi est parturient sagittis penatibus sit.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Pellentesque at amet viverra diam turpis pellentesque aliquet. Ultrices commodo nec pellentesque tortor enim. Amet nibh quam justo egestas bibendum lectus. Phasellus et potenti lorem mi egestas. Gravida eget nullam sed placerat orci in.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),

                    SizedBox(height: heightSize(24)),

                    CText(
                      text:
                      'Diam ante et viverra in odio integer at.',
                      size: 11,
                      fontFamily: CFONT.FAMILY,
                      fontWeight: CFONT.wRegular,
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
