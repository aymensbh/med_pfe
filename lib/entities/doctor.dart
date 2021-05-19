class Doctor {
  int id;
  String name;

  Doctor({this.id, this.name});

  Doctor.fromMap(Map<String, dynamic> map) {
    id = map["Doctor_id"];
    name = map["Doctor_name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "doctor_id": id,
      "doctor_name": name,
    };
  }
}
