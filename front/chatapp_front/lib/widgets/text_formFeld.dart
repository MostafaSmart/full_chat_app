import 'package:flutter/material.dart';

class MyTextFormFilde extends StatelessWidget {
  final String hint;
  final Icon prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final VoidCallback? togglePasswordView;
  final bool obscureText;

  const MyTextFormFilde(
      {super.key,
      required this.hint,
      required this.prefixIcon,
      this.obscureText = false,
      this.togglePasswordView,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        boxShadow: [
          // ظل سفلي داكن لإعطاء إحساس الارتفاع
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(4, 4), // ظل سفلي يمين
          ),
          // ظل علوي فاتح لإضافة تأثير 3D
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            spreadRadius: -2,
            blurRadius: 10,
            offset: Offset(-4, -4), // ظل علوي يسار
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => validator!(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hint,
          filled: true, // تفعيل الخلفية الملونة
          fillColor: Colors.white, // تعيين لون الخلفية إلى الأبيض
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),

          suffixIcon: togglePasswordView != null
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: togglePasswordView,
                )
              : null,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
      ),
    );
  }
}
