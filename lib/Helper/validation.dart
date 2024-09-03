import 'package:get/get.dart';

class VALIDATIONS {
  static String? validateEmail(String? value) {
    RegExp regex =
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
            r"{0,253}[a-zA-Z0-9])?)*$");
    if (value!.isEmpty) return "Email is Required".tr;
    if (!regex.hasMatch(value)) {
      return 'Please Enter a Valid Email.'.tr;
    } else {
      return null;
    }
  }

  static String? validatePasswordReq(String? value) {
    RegExp regex =
        RegExp(r"^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).*$");
    if (value!.isEmpty) {
      return "Password is Required".tr;
    }
    if (!regex.hasMatch(value)) {
      return "Please Enter a Valid Password.".tr;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required".tr;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Confirm Password is Required".tr;
    } else {
      return null;
    }
  }

  static String? validateRequired(String? value) {
    if (value!.isEmpty) {
      return "Required".tr;
    } else {
      return null;
    }
  }

  static String? validateYear(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (value.length == 4) {
      return null;
    } else {
      return "enter_valid_year".tr;
    }
  }

  static String? validateIBAN(String? value) {
    if (value!.isEmpty) {
      return "Required".tr;
    } else if (value.length < 22) {
      return "enter_valid_iban".tr;
    } else {
      return null;
    }
  }

  static String? validateCard(String? value) {
    if (value!.isEmpty) {
      return "Required".tr;
    } else if (value.length > 16) {
      return "enter_valid_card".tr;
    } else {
      return null;
    }
  }

  static String? validateOptional(String? value) {
    if (value!.isEmpty) {
      return null;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Name is Required.';
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return 'Address is Required.';
    } else {
      return null;
    }
  }

  static String? validateMobilePhone(String? value) {
    if (value!.isEmpty) {
      return 'Phone number is Required'.tr;
    } else {
      return null;
    }
  }
}
