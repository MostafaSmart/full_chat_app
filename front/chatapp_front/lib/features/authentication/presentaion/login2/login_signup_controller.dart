// import 'dart:math';

import 'package:chatapp_front/core/hive/auth_hive.dart';
import 'package:chatapp_front/features/authentication/presentaion/verification/VerificationScreen.dart';
import 'package:chatapp_front/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp_front/core/uitls/app_util.dart';
import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';
import 'package:chatapp_front/features/authentication/domain/usecase/login_with_email.dart';
import 'package:chatapp_front/features/authentication/domain/usecase/sign_with_email_usecase.dart';
// import 'package:chatapp_front/features/authentication/presentaion/verification/VerificationScreen.dart';

class LoginSignupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginInKey = GlobalKey<FormState>();

  //  phoneInKey = GlobalKey<FormState>();

  final sign_nameController = TextEditingController();
  final sign_userNameController = TextEditingController();

  final sign_emailController = TextEditingController();
  final sign_passwordController = TextEditingController();
  final sign_confirmPasswordController = TextEditingController();

  final login_emailController = TextEditingController();
  final login_passwordController = TextEditingController();

  final login_phoneController = TextEditingController();

  var obscurePassword = true.obs;

  var login_obscurePassword = true.obs;

  var obscureConfirmPassword = true.obs;

  final tabs = [
    Tab(text: 'تسجيل الدخول'),
    Tab(text: 'انشاء حساب'),
  ];

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  Future<bool> register() async {
    if (!(signUpKey.currentState?.validate() ?? true)) return false;

    print(sign_emailController.text);
    print(sign_nameController.text);
    print(sign_userNameController.text);

    RegisterWithEmailUseCase registerWithEmailUseCase =
        RegisterWithEmailUseCase();
    SignRequest request = SignRequest.withEmail(
      email: sign_emailController.text,
      name: sign_nameController.text,
      user_name: sign_userNameController.text,
      phone: null,
      password: sign_passwordController.text,
    );

    (await registerWithEmailUseCase.call(request)).fold(
      (failure) {
        AppUtil.showMessage(failure.message);
      },
      (user) {

        if(AuthBox.isUserEmailValid()){
        Get.off(() => MyHomePage(title: 'Flutter Demo Home Page'));

        }
        else{
        Get.to(() => VerificationScreen());

        }

        // AppUtil.showMessage(AppLocalization.successLogin);
        // goToVerfiy(false);
      },
    );

    return true;
  }

  Future<bool> login() async {
    if (!(loginInKey.currentState?.validate() ?? true)) return false;

    LoginRequest loginRequest = LoginRequest.withEmail(
        email: login_emailController.text,
        password: login_passwordController.text);

    LoginWithEmailUseCase loginWithEmailUseCase = LoginWithEmailUseCase();
    (await loginWithEmailUseCase.call(loginRequest)).fold(
      (failure) {
        AppUtil.showMessage(failure.message);
      },
      (success) {
      
        if(AuthBox.isUserEmailValid()){
        Get.off(() => MyHomePage(title: 'Flutter Demo Home Page'));

        }
        else{
        Get.to(() => VerificationScreen());

        }
        // }
      },
    );

    return true;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // void goToVerfiy(bool isForget) {
  //   Get.to(() => VerificationScreen());
  // }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login_togglePasswordVisibility() {
    login_obscurePassword.value = !login_obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }
}
