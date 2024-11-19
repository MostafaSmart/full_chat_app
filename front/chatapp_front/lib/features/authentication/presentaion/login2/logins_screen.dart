import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:chatapp_front/core/constants/colors.dart';
import 'package:chatapp_front/features/authentication/presentaion/login2/login_signup_controller.dart';
import 'package:chatapp_front/features/authentication/presentaion/widgets/ContinueWithWidget.dart';
import 'package:chatapp_front/features/authentication/presentaion/widgets/header_auth.dart';

import 'package:chatapp_front/features/authentication/presentaion/widgets/login_form.dart';
import 'package:get/get.dart';
import 'package:chatapp_front/features/authentication/presentaion/widgets/sgin_form.dart';
// import 'package:chatapp_front/features/authentication/presentaion/widgets/sign_phone.dart';
// import 'material_design_indicator.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final LoginSignupController controller = Get.put(LoginSignupController());

    return Scaffold(
      backgroundColor: AppColor.backgroundScreenColors,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: const AuthHeaderWidget(130),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                child: TabBar(
                  controller: controller.tabController,
                  tabs: controller.tabs,
                  labelColor: AppColor.primaryColor2,
                  indicatorColor: AppColor.primaryColor2,
                  unselectedLabelColor: AppColor.unselectedColor,
                  labelStyle: TextStyle(
                    fontSize: 18,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 400, // يمكنك تغيير هذا الطول حسب الحاجة
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TabBarView(
                  controller: controller.tabController,
                  children: [LoginForm2(), SignUpForm2()],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ContinueWithWidget(
                text: "المتابعة باستخدام",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  
  
  }
}
