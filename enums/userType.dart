enum UserType { TAILOR, DESIGNER, BOTH, USER, UNKNOWN }

class UserTypeHelper {
  static String getValue(UserType userType) {
    switch (userType) {
      case UserType.TAILOR:
        return "Terzi";
      case UserType.DESIGNER:
        return "Tasarimci";
      case UserType.BOTH:
        return "Hem Terzi Hem Tasarimci";
      case UserType.USER:
        return "Kullanici";
      default:
        return 'UNKNOWN';
    }
  }

  static UserType getEnum(String userType) {
    if (userType == getValue(UserType.TAILOR)) {
      return UserType.TAILOR;
    } else if (userType == getValue(UserType.DESIGNER)) {
      return UserType.DESIGNER;
    } else if (userType == getValue(UserType.BOTH)) {
      return UserType.BOTH;
    } else if (userType == getValue(UserType.USER)) {
      return UserType.USER;
    }
    return UserType.UNKNOWN;
  }
}
