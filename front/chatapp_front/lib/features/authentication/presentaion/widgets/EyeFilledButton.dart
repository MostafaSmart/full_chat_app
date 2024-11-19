import 'package:flutter/material.dart';
import 'package:chatapp_front/widgets/ScaleDownTransitionWidget.dart';

class EyeFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isShowLoading;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final Color? color;

  const EyeFilledButton({
    super.key,
    this.onPressed,
    this.width,
    this.isShowLoading = false,
    required this.child,
    this.margin = const EdgeInsets.only(top: 16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleDownTransitionWidget(
      child: Container(
        margin: margin,
        width: width,
        height: 42,
        child: FilledButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: color ?? Theme.of(context).primaryColor,
          ),
          onPressed: onPressed,
          child: isShowLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : child,
        ),
      ),
    );
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).primaryColor;

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: const Color.fromARGB(255, 52, 0, 143),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
