class Patient {
  int id;
  String fullname, birthdate, phone, address;
  Patient({this.id, this.fullname, this.birthdate, this.phone, this.address});

  Patient.fromMap(Map<String, dynamic> map) {
    id = map["patient_id"];
    fullname = map["patient_fullname"];
    birthdate = map["patient_birthdate"];
    phone = map["patient_phone"];
    address = map["patient_address"];
  }

  Map<String, dynamic> toMap() {
    return {
      "patient_id": id,
      "patient_fullname": fullname,
      "patient_birthdate": birthdate,
      "patient_phone": phone,
      "patient_address": address,
    };
  }
}
