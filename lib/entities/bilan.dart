class Bilan {
  int id, doctorid, drugid, patientid;
  String creationdate, dose, cr, br, tgoTgp;

  Bilan(
      {this.id,
      this.doctorid,
      this.drugid,
      this.patientid,
      this.dose,
      this.cr,
      this.br,
      this.tgoTgp,
      this.creationdate});

  Bilan.fromMap(Map<String, dynamic> map) {
    id = map['bilan_id'];
    doctorid = map['doctor_id'];
    drugid = map['drug_id'];
    patientid = map['patient_id'];
    cr = map['bilan_cr'];
    br = map['bilan_br'];
    tgoTgp = map['bilan_tgo_tgp'];
    dose = map['bilan_dose'];
    creationdate = map['bilan_creationdate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'bilan_id': id,
      'doctor_id': doctorid,
      'drug_id': drugid,
      'bilan_cr': cr,
      'bilan_br': br,
      'patient_id': patientid,
      'bilan_tgo_tgp': tgoTgp,
      'bilan_dose': dose,
      'bilan_creationdate': creationdate
    };
  }
}
