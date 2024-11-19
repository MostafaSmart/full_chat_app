// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:chatapp_front/core/constants/colors.dart';
// import 'package:chatapp_front/features/authentication/presentaion/login2/login_signup_controller.dart';
// import 'package:chatapp_front/widgets/gradient_button.dart';
// import 'package:chatapp_front/widgets/text_formFeld.dart';

// class SignPhone extends StatelessWidget {
//   const SignPhone({super.key});


//   @override
//   Widget build(BuildContext context) {
//     final LoginSignupController controller = Get.find();
//     return Form(
//       key: controller.loginInKey,
//       child: Column(
//         children: [
//           MyTextFormFilde(
//             controller: controller.login_phoneController,
//             hint: 'رقم الهاتف',
//             prefixIcon: Icon(Icons.phone),
          
//           ),
         
//           // Obx(() {
//           //   return MyTextFormFilde(
//           //     hint: 'كلمة المرور',
//           //     prefixIcon: Icon(Icons.lock),
//           //     controller: controller.login_passwordController,
//           //     togglePasswordView: controller.login_togglePasswordVisibility,
//           //     obscureText: controller.login_obscurePassword.value,
//           //   );
//           // }),
//           SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               // Add your terms and conditions functionality
//             },
//             child: Text(
//               "By pressing 'submit' you agree to our terms & conditions",
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 12,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 5),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10),
//                     bottomRight: Radius.circular(10)),
//                 gradient: LinearGradient(
//                   colors: [AppColor.primaryColor2, Colors.red],
//                   begin: Alignment.centerLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 10,
//                     blurRadius: 20,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: GradientButton(
//                 text: 'تسجيل الدخول',
//                 onPressed: () {
//                   controller.sendPhone();
//                 },
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           GestureDetector(
//             onTap: () {
//               // Add your terms and conditions functionality
//             },
//             child: Text(
//               "هل نسيت كلمة المرور",
//               style: TextStyle(
//                 color: AppColor.primaryColor2,
//                 fontSize: 15,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }


// }