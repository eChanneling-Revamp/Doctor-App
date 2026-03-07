class SignUpData {
  String? fullName;
  String? medicalSpec;
  String? hospital;
  String? slmcNumber;
  String? phone;
  String? email;
  String? password;

  SignUpData({
    this.fullName,
    this.medicalSpec,
    this.hospital,
    this.slmcNumber,
    this.phone,
    this.email,
    this.password,
  });

  bool isStep1Complete() {
    return fullName != null &&
        fullName!.isNotEmpty &&
        medicalSpec != null &&
        medicalSpec != 'Select your specialty' &&
        hospital != null &&
        hospital!.isNotEmpty &&
        slmcNumber != null &&
        slmcNumber!.isNotEmpty;
  }

  bool isComplete() {
    return isStep1Complete() &&
        phone != null &&
        phone!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty;
  }
}
