class Bilan {
  int id, doctorid, drugid, patientid;
  String creationdate, dose, type;

  Bilan(
      {this.id,
      this.doctorid,
      this.drugid,
      this.patientid,
      this.dose,
      this.type,
      this.creationdate});

  Bilan.fromMap(Map<String, dynamic> map) {
    id = map['bilan_id'];
    doctorid = map['doctor_id'];
    drugid = map['drug_id'];
    patientid = map['patient_id'];
    type = map['bilan_type'];
    dose = map['bilan_dose'];
    creationdate = map['bilan_creationdate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'bilan_id': id,
      'doctor_id': doctorid,
      'drug_id': drugid,
      'patient_id': patientid,
      'bilan_type': type,
      'bilan_dose': dose,
      'bilan_creationdate': creationdate
    };
  }
}
