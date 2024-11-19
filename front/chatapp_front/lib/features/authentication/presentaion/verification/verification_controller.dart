

import 'dart:async';

import 'package:chatapp_front/core/uitls/app_util.dart';
import 'package:chatapp_front/features/authentication/domain/request/sign_request.dart';
import 'package:chatapp_front/features/authentication/domain/usecase/VerificationEmail.dart';
import 'package:chatapp_front/main.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {


   var isButtonEnabled = true.obs; // حالة الزر

  var sended = false.obs;

  RxInt remainingSeconds = 0.obs;
  Timer? _timer;


  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds.value--;

      if (remainingSeconds.value <= 0) {
        _timer?.cancel();
        update();
      }
    });
  }






    void reGetCode() async {

    AppUtil.progressIndecatorDialog();

    GetVerificationEmailUseCase getVerificationEmailUseCase = GetVerificationEmailUseCase();

    (await getVerificationEmailUseCase.call()).fold(
      (failure) {
        Get.back();
        AppUtil.showMessage(failure.message);
      },
      (user) {
        Get.back();

        AppUtil.showMessage('تم الارسال بنجاح');

      remainingSeconds.value = 60;
      startTimer();
      update();
    });

  }



  


  

  void sendVerifiCodeEmail(String value) async{
    AppUtil.progressIndecatorDialog();


    SendVerificationEmailUseCase sendVerificationEmailUseCase = SendVerificationEmailUseCase();

    OTPRequest request = OTPRequest.withs(verification_code: value);
    (await sendVerificationEmailUseCase.call(request)).fold(

      (failure) {
  Get.back();
        AppUtil.showMessage(failure.message);

      },
      (scsess){
         Get.back();
              Get.off(() => MyHomePage(title: 'Flutter Demo Home Page'));


      }
    );
  }


  
}
//   AuthRepositorImpl authRepositorImpl = AuthRepositorImpl();

//    var isButtonEnabled = true.obs; // حالة الزر
//   var timerValue = 60.obs; // قيمة العداد
//   var sended = false.obs;




//   @override
//  Future <void> onInit() async{
//     super.onInit();


//   }


//   @override
//  onClose() {
//     FirebaseAuth.instance.signOut();
//   }

// Future <void> sendEmailVerification()async{

//   isButtonEnabled.value = false;
//   SendVerificationEmailUseCase sendVerificationEmailUseCase = SendVerificationEmailUseCase();



//   (await sendVerificationEmailUseCase.call(false)).fold(
//       (failure) {
//         AppUtil.showMessage(failure.message);
//       isButtonEnabled.value = true;
//  sended.value = false;
//       },
//       (user) {
        
//        startTimer();
//       },
//     );

// }

//    void startTimer() {
//     sended.value =true;
//     isButtonEnabled.value = false; // جعل الزر غير قابل للنقر
//     timerValue.value = 60; // تعيين قيمة العداد إلى 60

//     Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timerValue.value > 0) {
//         timerValue.value--;
//       } else {
//         timer.cancel();
//         isButtonEnabled.value = true;
//         sended.value = false; 
        

//       }
//     });
//   }

// }
