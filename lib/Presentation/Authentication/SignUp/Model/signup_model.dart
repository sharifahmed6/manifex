class signupModel {
  String firstName;
  String lastName;
  String ageGroup;
  String hobbies;
  String email;
  String password;
  String confirmPassword;

  //<editor-fold desc="Data Methods">
  signupModel({
    required this.firstName,
    required this.lastName,
    required this.ageGroup,
    required this.hobbies,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is signupModel &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          ageGroup == other.ageGroup &&
          hobbies == other.hobbies &&
          email == other.email &&
          password == other.password &&
          confirmPassword == other.confirmPassword);

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      ageGroup.hashCode ^
      hobbies.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode;

  @override
  String toString() {
    return 'signupModel{' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' ageGroup: $ageGroup,' +
        ' hobbies: $hobbies,' +
        ' email: $email,' +
        ' password: $password,' +
        ' confirmPassword: $confirmPassword,' +
        '}';
  }

  signupModel copyWith({
    String? firstName,
    String? lastName,
    String? ageGroup,
    String? hobbies,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return signupModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      ageGroup: ageGroup ?? this.ageGroup,
      hobbies: hobbies ?? this.hobbies,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'ageGroup': this.ageGroup,
      'hobbies': this.hobbies,
      'email': this.email,
      'password': this.password,
      'confirmPassword': this.confirmPassword,
    };
  }

  factory signupModel.fromMap(Map<String, dynamic> map) {
    return signupModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      ageGroup: map['ageGroup'] as String,
      hobbies: map['hobbies'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  //</editor-fold>
}