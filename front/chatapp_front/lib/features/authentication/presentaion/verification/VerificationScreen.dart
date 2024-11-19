import 'dart:math';

import 'package:chatapp_front/features/authentication/presentaion/verification/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {

  const VerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());

    final otpFieldWidth = max(30.0, Get.width * 1 / 8);
    return Scaffold(
      appBar: AppBar(forceMaterialTransparency: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(height: Get.height * 0.02),
          Text(
            'التحقق من البريد الالكتروني',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 30),
          const Text("ادخل رقم الكود", textAlign: TextAlign.center),
          // token fields
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: OtpTextField(
                          clearText: true,
                          focusedBorderColor: Theme.of(context).primaryColor,
                          fieldWidth: min(50, otpFieldWidth),
                          cursorColor: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          numberOfFields: 6,
                          borderColor: Theme.of(context).primaryColor,
                          showFieldAsBox: true,
                          autoFocus: true,
                          onSubmit: (value) {
                            controller.sendVerifiCodeEmail(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // resend code button
          const SizedBox(height: 20),
          Obx(
            () {
              RxInt remainingSeconds = controller.remainingSeconds;
              if (remainingSeconds.value <= 0) {
                return TextButton(
                  onPressed: () => controller.reGetCode(),
                  child: Text(' ارسال الرمز'),
                );
              } else {
                return Text(
                  "اعادة الارسال بعد ${remainingSeconds.value} ثانية",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}





// import 'package:provider/widget/gradient_button.dart';
// import 'verification_controller.dart';

// class VerificationScreen extends StatelessWidget {
//   const VerificationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final VerificationController controller = Get.put(VerificationController());

//     return Scaffold(
//         backgroundColor: AppColor.backgroundScreenColors,
//         body: SingleChildScrollView(
//             child: Column(children: [
//           SizedBox(
//             height: 130,
//             child: const AuthHeaderWidget(130),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           Obx(() {
//             return Text(
//               controller.sended.value == false
//                   ? 'التحقق من صحة البريد الالكتروني .. '
//                   : 'يرجى مراجعة بريدك الالكتروني لاكمال عملية التحقق',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineLarge,
//             );
//           }),
//           const SizedBox(height: 30),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Obx(() => Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10)),
//                     gradient: LinearGradient(
//                       colors: [AppColor.primaryColor2, Colors.red],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 10,
//                         blurRadius: 20,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: GradientButton(
//                     text: controller.sended.value == false && controller.isButtonEnabled == true
//                         ? 'ارسال الى البريد الالكتروني'
                        
//                         : controller.sended.value == false && controller.isButtonEnabled ==false ? "يرجى الانتظار .."
                       
//                         : 'تم الارسال.. حاول بعد(${controller.timerValue.value})', // عرض العداد
//                     onPressed: controller.isButtonEnabled.value
//                         ? () {
//                             controller.sendEmailVerification(); // بدء العداد عند الضغط
//                             // هنا يمكنك إضافة عملية الإرسال
//                           }
//                         : null, // تعطيل الزر أثناء العد
//                   ),
//                 )),
//           ),
//         ])));
//   }
// }

// // class VerificationScreen extends StatelessWidget {
// //   const VerificationScreen({super.key});
// //   @override
// //   Widget build(BuildContext context) {
// //     final VerificationController controller = Get.put(VerificationController());

// //     return Scaffold(
// //         backgroundColor: AppColor.backgroundScreenColors,
// //         body: SingleChildScrollView(
// //             child: Column(children: [
// //           SizedBox(
// //             height: 130,
// //             child: const AuthHeaderWidget(130),
// //           ),
// //           SizedBox(height: Get.height * 0.02),
// //           Text(
// //             'التحقق من صحة البريد الالكتروني .. ',
// //             textAlign: TextAlign.center,
// //             style: Theme.of(context).textTheme.headlineLarge,
// //           ),
// //           const SizedBox(height: 30),
      
               
// //             Padding(
// //             padding: EdgeInsets.symmetric(vertical: 10),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.only(
// //                     bottomLeft: Radius.circular(10),
// //                     bottomRight: Radius.circular(10)),
// //                 gradient: LinearGradient(
// //                   colors:[AppColor.primaryColor2, Colors.red] ,
// //                   begin: Alignment.centerLeft,
// //                   end: Alignment.centerRight,
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.3),
// //                     spreadRadius: 10,
// //                     blurRadius: 20,
// //                     offset: Offset(0, 3),
// //                   ),
// //                 ],
// //               ),
// //               child: GradientButton(
// //                 text: 'ارسال الى البريد الالكتروني',
// //                 onPressed: () {

                  
// //                 },
// //               ),
// //             ),
// //           ),
// //         ])));
// //   }


// // }

