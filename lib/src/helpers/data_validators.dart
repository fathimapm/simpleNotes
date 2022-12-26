class DataValidator{

  static String? isNullOrEmpty(String? value){
    bool isNullOrEmpty = (value==null) || value.trim().isEmpty;
    if (isNullOrEmpty){
      return "Please enter a value";
    }
    return null;
  }


  static String? isValidEmail(String? value) {
    String? isEmptyEmail = isNullOrEmpty(value);
    if (isEmptyEmail != null) {
      return isEmptyEmail;
    }
    bool isEmailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (!isEmailValid) {
      return "invalid Email";
    }
    return null;
  }
  static String? isValidPassword(String? value) {
    String? isEmptyPassword= isNullOrEmpty(value);
    if (isEmptyPassword != null) {
      return isEmptyPassword;
    }
    bool isPasswordValid = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$' )
        .hasMatch(value!);
    if (!isPasswordValid) {
      return "Requires one capital,one lower,one number and one special character and min 5";
    }
    return null;
  }
  static String? isValidMobile(String? value){
    String? isEmptyMobile = isNullOrEmpty(value);
    if (isEmptyMobile != null) {
      return isEmptyMobile;
    }
    bool isValidMobile = value!.length==10;
    if (!isValidMobile) {
      return "mobile number should be 10 character";
    }
    return null;
  }

}