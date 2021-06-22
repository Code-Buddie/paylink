class Validators {
  static String isValidIdNumber(String idNumber) {
    if (idNumber == null || idNumber.isEmpty) {
      return 'Please enter a valid iD Number';
    }
    RegExp regExp = new RegExp(
      r"^[0-9]{6,8}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(idNumber)) {
      return null;
    }
    return 'Please enter a valid iD Number';
  }

  static String isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a valid Phone Number';
    }
    RegExp regExp = new RegExp(
      r"^(\+254|0)([7][0-9]|[1][0-1]){1}[0-9]{1}[0-9]{6}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(phoneNumber)) {
      return null;
    }
    return 'Please enter a valid Phone Number';
  }

  static String isValidEmail(String email) {
    if (email == null || email.isEmpty) {
      return 'Please enter a valid email';
    }
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(email)) {
      return null;
    }
    return 'Please enter a valid email';
  }

  static String isValidEmailOrId(String emailOrId){
    String value = 'Please enter a valid email or ID Number';
    if(isValidIdNumber(emailOrId)== null){
      value = null;
    }else if (isValidEmail(emailOrId)== null){
      value = null;
    }

    return value;
  }
}
