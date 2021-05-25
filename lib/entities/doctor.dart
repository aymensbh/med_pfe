class Doctor {
  int id;
  String name, spec;

  Doctor({this.id, this.spec, this.name});

  Doctor.fromMap(Map<String, dynamic> map) {
    id = map["doctor_id"];
    name = map["doctor_name"];
    spec = map["doctor_spec"];
  }

  Map<String, dynamic> toMap() {
    return {
      "doctor_id": id,
      "doctor_name": name,
      "doctor_spec": spec,
    };
  }
}
