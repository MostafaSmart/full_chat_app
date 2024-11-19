import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chatapp_front/widgets/ScaleDownTransitionWidget.dart';

class ContinueWithWidget extends StatelessWidget {
  final String text;
  final Function  onPressed;
  const ContinueWithWidget(
      {super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(),
        dividerAndTextCenterWidget(text),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    onPressed();
                  },
                  child: SocialIcons(
                    widget: SvgPicture.asset(
                      "assets/icons/google.svg",
                    ),
                  ),
                ),
                SocialIcons(
                  widget: Image.asset(
                    "assets/icons/fac.png",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Padding dividerAndTextCenterWidget(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xFF3B6875))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(text),
            ),
            const Expanded(child: Divider(color: Color(0xFF3B6875))),
          ],
        ),
      ],
    ),
  );
}

class SocialIcons extends StatelessWidget {
  final Widget widget;

  const SocialIcons({
    super.key,
    required this.widget,
  });
  @override
  Widget build(BuildContext context) {
    return ScaleDownTransitionWidget(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.0,
              color: Color(0xff4CB9C0),
            ),
            BoxShadow(
              blurRadius: 1.0,
              color: Color(0xff4CB9C0),
            ),
          ],
        ),
        child: SizedBox(
          width: 50,
          height: 30,
          child: widget,
        ),
      ),
    );
  }
}
