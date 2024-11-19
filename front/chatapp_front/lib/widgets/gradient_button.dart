import 'package:flutter/material.dart';
import 'package:chatapp_front/core/constants/colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
 final List<Color>? colors;

  const GradientButton({required this.text, this.onPressed, this.colors});

  @override
  Widget build(BuildContext context) {
    
        final gradientColors = colors ?? [AppColor.primaryColor2, Colors.red];

    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white.withOpacity(0.2), // لون تأثير الضغط
      borderRadius: BorderRadius.circular(8), // إضافة حدود دائرية لتأثير الضغط
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:gradientColors, // التدرج من الأحمر إلى الأزرق
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8), // حدود دائرية للزر
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // حجم الزر
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
