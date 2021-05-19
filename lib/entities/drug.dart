class Drug {
  int id;
  String name;

  Drug({
    this.id,
    this.name,
  });

  Drug.fromMap(Map<String, dynamic> map) {
    id = map["drug_id"];
    name = map["drug_name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "drug_id": id,
      "drug_name": name,
    };
  }
}
