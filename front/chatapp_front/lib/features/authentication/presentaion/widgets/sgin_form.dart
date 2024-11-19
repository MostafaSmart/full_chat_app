import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp_front/core/constants/colors.dart';
import 'package:chatapp_front/features/authentication/presentaion/login2/login_signup_controller.dart';
import 'package:chatapp_front/widgets/gradient_button.dart';
import 'package:chatapp_front/widgets/text_formFeld.dart';
import 'package:chatapp_front/core/helper/Validations.dart';

class SignUpForm2 extends StatelessWidget {
  const SignUpForm2({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginSignupController controller = Get.find();

    return Form(
    
      key: controller.signUpKey,
      child: Column(
        children: [
          MyTextFormFilde(
            controller: controller.sign_nameController,
            hint: 'الاسم الكامل',
            prefixIcon: Icon(Icons.person),
            validator: (value) {
              return Validations.emptyValidator(value?.trim());
            },
          ),
      MyTextFormFilde(
            controller: controller.sign_userNameController,
            hint: 'اليوزر',
            prefixIcon: Icon(Icons.emoji_emotions_outlined),
            validator: (value) {
              return Validations.emptyValidator(value?.trim());
            },
          ),

          SizedBox(height: 15),
          MyTextFormFilde(
            controller: controller.sign_emailController,
            hint: 'البريد الالكتروني',
            prefixIcon: Icon(Icons.email),
            validator: (value) {
              return Validations.emailValidator(value?.trim());
            },
          ),
          SizedBox(height: 15),
          Obx(() {
            return MyTextFormFilde(
              obscureText: controller.obscurePassword.value,
              controller: controller.sign_passwordController,
              hint: 'كلمة المرور',
              prefixIcon: Icon(Icons.lock),
              togglePasswordView: controller.togglePasswordVisibility,
              validator: (value) {
                return Validations.passwordValidator(value?.trim());
              },
            );
          }),
          SizedBox(height: 15),
          Obx(() {
            return MyTextFormFilde(
              obscureText: controller.obscureConfirmPassword.value,
              controller: controller.sign_confirmPasswordController,
              togglePasswordView: controller.toggleConfirmPasswordVisibility,
              hint: 'تأكيد كلمة المرور',
              prefixIcon: Icon(Icons.lock),
              validator: (value) {
                return Validations.passwordValidator(value?.trim(),
                    confirmPass: controller.sign_passwordController.text);
              },
            );
          }),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Add your terms and conditions functionality
            },
            child: Text(
              "By pressing 'submit' you agree to our terms & conditions",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor2, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 10,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: GradientButton(
                text: 'انشاء حساب',
                onPressed: () {
                  controller.register();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
