import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/sizes.dart';
import 'package:sentro/core/constants/values.dart';
import 'package:sentro/core/utils/text.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const NumericKeyboard(
      {Key? key,
        required this.onKeyboardTap,
        this.textColor = Colors.black,
        this.rightButtonFn,
        this.rightIcon,
        this.leftButtonFn,
        this.leftIcon,
        this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 2, right: 2),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            // buttonPadding:
            //     EdgeInsets.only(left: widthSize(10), right: widthSize(10)),
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.rightButtonFn,
                child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(fingerScan)),
              ),
              _calcButton('0'),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.leftButtonFn,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: kBlack,
                        borderRadius: BorderRadius.circular(Values().circle)),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: widget.leftIcon,
                  )
                // child: widget.rightIcon),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: widthSize(100),
        height: heightSize(80),
        child: CText(
            text: value,
            size: 26,
            fontWeight: FontWeight.w600,
            fontFamily: CFONT.SEMIBOLD,
            color: widget.textColor),
      ),
    );
  }
}
