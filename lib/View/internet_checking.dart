import 'package:quiz_app/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InternetChecking extends StatelessWidget {
  const InternetChecking({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset(internet,
              width: width,
              height: height,
              fit: BoxFit.fitWidth,
              frameRate: FrameRate.max),
        ],
      ),
    );
  }
}
