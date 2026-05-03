import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sentro/core/constants/asset_path.dart';
import 'package:sentro/core/constants/sizes.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          SizedBox(height: heightSize(68),),
          SvgPicture.asset(
            logo,
            width: widthSize(204.79),
            height: heightSize(48),
          ),
        ],
      ),
    );
  }
}
