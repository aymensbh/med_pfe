class Patient {
  int id;
  String fullname, age, phone, address;
  Patient({this.id, this.fullname, this.age, this.phone, this.address});

  Patient.fromMap(Map<String, dynamic> map) {
    id = map["patient_id"];
    fullname = map["patient_fullname"];
    age = map["patient_age"];
    phone = map["patient_phone"];
    address = map["patient_address"];
  }

  Map<String, dynamic> toMap() {
    return {
      "patient_id": id,
      "patient_fullname": fullname,
      "patient_age": age,
      "patient_phone": phone,
      "patient_address": address,
    };
  }
}
