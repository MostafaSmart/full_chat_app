import 'package:chatapp_front/widgets/CustomContainer.dart';
import 'package:chatapp_front/widgets/ScaleDownTransitionWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatapp_front/core/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppUtil {

  
  static void showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          message.tr,
          textAlign: TextAlign.center,
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor:
            isError ? Colors.redAccent : Color(AppColor.primaryColor),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 8,
      ),
    );
  }
  // static Future displayErrorDialog(String message) {
  //   final size = Get.mediaQuery.size;
  //   return confirmDialog(
  //     title: AppLocalization.error.tr,
  //     onSubmit: () => Get.back(),
  //     submitText: AppLocalization.ok.tr,
  //     isShowCancelButton: false,
  //     content: Container(
  //       width: size.width,
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       child: Text(message),
  //     ),
  //   );
  // }

  static Future<void> progressIndecatorDialog({
    String? status = "يرجى الانتظار",
    Color? color,
    double size = 60,
  }) async {
    await Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
            corner: 13,
            radius: 15,
            width: status != null ? 180 : 150,
            height: status != null ? 150 : 125,
            color: Get.theme.dialogBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitCircle(color: Get.theme.primaryColor, size: size),
                
                const SizedBox(height: 20),
                if (status != null)
                  Text(status.tr, style: Get.textTheme.bodyMedium)
              ],
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // static Future<void> successDialog({
  //   String? message,
  //   bool barrierDismissible = true,
  // }) async {
  //   return await Get.dialog(
  //     Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         CustomContainer(
  //           color: Get.theme.dialogBackgroundColor,
  //           width: 350,
  //           padding: const EdgeInsets.symmetric(horizontal: 30),
  //           child: Column(
  //             children: [
  //               const SizedBox(height: 20),
  //               // SvgPicture.asset(AppIcons.done),
  //               const SizedBox(height: 15),
  //               Text(
  //                 AppLocalization.congratulations.tr,
  //                 style: Get.textTheme.titleLarge?.copyWith(
  //                   color: Get.theme.primaryColor,
  //                 ),
  //               ),
  //               if (message != null)
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Text(
  //                     message.tr,
  //                     textAlign: TextAlign.center,
  //                     style: Get.textTheme.bodyMedium,
  //                   ),
  //                 ),
  //               TextButton(
  //                 onPressed: () {
  //                   Get.back();
  //                 },
  //                 child: Text(AppLocalization.ok.tr),
  //               ),
  //               const SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //     barrierDismissible: barrierDismissible,
  //   );
  // }

  
  // static confirmDialog({
  //   String? title,
  //   String? message,
  //   void Function()? onSubmit,
  //   Widget? content,
  //   bool isShowCancelButton = true,
  //   String? cancelButtonText,
  //   String? submitText,
  // }) {
  //   return Get.defaultDialog(
  //     backgroundColor: Colors.white,
  //     title: title ?? "",
  //     titlePadding: title == null ? EdgeInsets.zero : null,
  //     titleStyle:
  //         TextStyle(color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
  //     middleText: message ?? "",
  //     content: content,
  //     actions: [
  //       Container(
  //         width: !isShowCancelButton ? Get.width : null,
  //         padding: !isShowCancelButton
  //             ? const EdgeInsets.symmetric(horizontal: 20)
  //             : null,
  //         child: ScaleDownTransitionWidget(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Get.theme.primaryColor,
  //             ),
  //             onPressed: onSubmit,
  //             child: Text(
  //               submitText ?? AppLocalization.submit.tr,
  //               style: Get.theme.primaryTextTheme.labelSmall,
  //             ),
  //           ),
  //         ),
  //       ),
  //       if (isShowCancelButton)
  //         ScaleDownTransitionWidget(
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Get.theme.primaryColor,
  //             ),
  //             onPressed: () => Get.back(),
  //             child: Text(
  //               cancelButtonText ?? AppLocalization.cancel.tr,
  //               style: Get.theme.primaryTextTheme.labelSmall,
  //             ),
  //           ),
  //         )
  //     ],
  //   );
  // }

 
}
