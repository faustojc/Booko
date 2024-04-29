class RegistrationData {
  String? email;
  String? password;
  String? confirmPassword;
  String? firstname;
  String? lastname;
  DateTime? birthday;
  bool isEmailValid;
  bool isPasswordValid;
  bool isConfirmPasswordValid;

  RegistrationData({
    this.email,
    this.password,
    this.confirmPassword,
    this.firstname,
    this.lastname,
    this.birthday,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
  });

  RegistrationData copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? firstname,
    String? lastname,
    DateTime? birthday,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
  }) {
    return RegistrationData(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      birthday: birthday ?? this.birthday,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
    );
  }
}
