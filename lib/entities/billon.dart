class Billon {
  int id, doctorid, drugid, patientid, type;
  String creationdate;

  Billon(
      {this.id,
      this.doctorid,
      this.drugid,
      this.patientid,
      this.type,
      this.creationdate});

  Billon.formMap(Map<String, dynamic> map) {
    id = map['billon_id'];
    doctorid = map['doctor_id'];
    drugid = map['drug_id'];
    patientid = map['patient_id'];
    type = map['billon_type'];
    creationdate = map['billon_creationdate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'billon_id': id,
      'doctor_id': doctorid,
      'drug_id': drugid,
      'patient_id': patientid,
      'billon_type': type,
      'billon_creationdate': creationdate
    };
  }
}
