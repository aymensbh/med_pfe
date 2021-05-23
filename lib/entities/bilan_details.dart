class BilanDetail {
  String creationdate, dose, type, patientFullname, drugName;

  BilanDetail({this.dose, this.type, this.creationdate});

  BilanDetail.fromMap(Map<String, dynamic> map) {
    patientFullname = map['patient_fullname'];
    drugName = map['drug_name'];
    type = map['bilan_type'];
    dose = map['bilan_dose'];
    creationdate = map['bilan_creationdate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'patient_fullname': patientFullname,
      'drug_name': drugName,
      'bilan_type': type,
      'bilan_dose': dose,
      'bilan_creationdate': creationdate
    };
  }
}
