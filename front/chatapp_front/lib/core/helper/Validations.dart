import 'package:get/get.dart';

class Validations {
  static String? emptyValidator(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'حقل مطلوب !';
    }
    return null;
  }

  static bool isEmptyValidator(String? value) {
    return value == null || value.isEmpty;
  }

  static String? emailValidator(String? value, {String? message}) {
    if (isEmptyValidator(value)) {
      return 'حقل مطلوب !';
      
    }
    if (!GetUtils.isEmail(value!)) {
      return message ?? 'بريد الكتروني غير صالح';
    }
    return null;
  }

  static String? passwordValidator(String? value,
      {int min = 6, max = 30, String? confirmPass}) {
    if (isEmptyValidator(value)) {
      return 'كلمة المرور مطلوبة';
    }
    if (GetUtils.isLengthLessThan(value!, min)) {
      return 'كلمة مرور قصيرة';
    }
    if (GetUtils.isLengthGreaterThan(value, max)) {
      return 'كلمة مرور طويلة';
    }
    if (confirmPass != null && value != confirmPass) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    if (isEmptyValidator(value)) {
      return 'رقم الهاتف مطلوب';
    }
    if (GetUtils.isLengthLessThan(value!, 8)) {
      return 'رقم الهاتف قصير';
    }
    if (GetUtils.isLengthGreaterThan(value, 15)) {
      return 'رقم هاتف طويل' ;
    }
    return null;
  }
}
