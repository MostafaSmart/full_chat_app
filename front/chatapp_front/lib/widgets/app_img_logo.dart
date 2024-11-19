import 'package:flutter/material.dart';

class AppImageLogo extends StatelessWidget {
  const AppImageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.13,
      width: 270,
      child: Image.asset(
        "assets/images/app_logo1.png",
      ),
    );
  }
}
