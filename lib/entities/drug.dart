class Drug {
  int id;
  String name, lab;

  Drug({this.id, this.name, this.lab});

  Drug.fromMap(Map<String, dynamic> map) {
    id = map["drug_id"];
    name = map["drug_name"];
    lab = map["drug_lab"];
  }

  Map<String, dynamic> toMap() {
    return {
      "drug_id": id,
      "drug_name": name,
      "drug_lab": lab,
    };
  }
}
