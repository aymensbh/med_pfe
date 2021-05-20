import 'package:sqflite/sqflite.dart';

import '../entities/doctor.dart';
import '../entities/drug.dart';
import '../entities/patient.dart';
import '../entities/billon.dart';

class DatabaseHelper {
  static Database _db;
  static Future init() async {
    await openDB();
  }

  static openDB() async {
    _db = await openDatabase("pahrm.db", version: 1,
        onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');
      await db
          .execute(createDoctorTable)
          .then((value) => print('Doctors table created!'))
          .catchError((onError) => print(onError));
      await db
          .execute(createDrugTable)
          .then((value) => print('Drugs table created!'))
          .catchError((onError) => print(onError));
      ;
      await db
          .execute(createPatientTable)
          .then((value) => print('Patient table created!'))
          .catchError((onError) => print(onError));
      ;
      await db
          .execute(createBillonTable)
          .then((value) => print('Billon table created!'))
          .catchError((onError) => print(onError));
      ;
    });
  }

  //doctor
  static Future<int> insertDoctor(Doctor doctor) async {
    return await _db.insert("doctor", doctor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> selectDoctors() async {
    return await _db.query(
      "doctor",
      distinct: true,
    );
  }

  static Future<int> updateDoctor(Doctor doctor) async {
    return await _db.update(
      "doctor",
      doctor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'doctor_id = ?',
      whereArgs: [doctor.id],
    );
  }

  static Future<int> deleteDoctor(int id) async {
    return await _db.delete("doctor", where: "doctor_id = ?", whereArgs: [id]);
  }

  //Patient
  static Future<int> insertPatient(Patient patient) async {
    return await _db.insert("patient", patient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> selectPatient() async {
    return await _db.query(
      "patient",
      distinct: true,
    );
  }

  static Future<int> updatePatients(Patient patient) async {
    return await _db.update(
      "patient",
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'patient_id = ?',
      whereArgs: [patient.id],
    );
  }

  static Future<int> deletePatient(int id) async {
    return await _db
        .delete("patient", where: "patient_id = ?", whereArgs: [id]);
  }

  //drug
  static Future<int> insertDrug(Drug drug) async {
    return await _db.insert("drug", drug.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> selectDrugs() async {
    return await _db.query(
      "drug",
      distinct: true,
    );
  }

  static Future<int> updateDrug(Drug drug) async {
    return await _db.update(
      "drug",
      drug.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'drug_id = ?',
      whereArgs: [drug.id],
    );
  }

  static Future<int> deleteDrug(int id) async {
    return await _db.delete("drug", where: "drug_id = ?", whereArgs: [id]);
  }

  //billon
  static Future<int> insertBillon(Billon billon) async {
    return await _db.insert("billon", billon.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static String createDoctorTable = """
  CREATE TABLE IF NOT EXISTS doctor(
    "doctor_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "doctor_name"	TEXT
    );
  """;

  static String createPatientTable = """
  CREATE TABLE IF NOT EXISTS patient(
    "patient_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "patient_fullname"	TEXT,
    "patient_birthdate"	TEXT,
    "patient_address" TEXT,
    "patient_phone" TEXT
  );
  """;

  static String createDrugTable = """ 
  CREATE TABLE IF NOT EXISTS drug(
    "drug_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "drug_name"	TEXT
    );
  """;

  static String createBillonTable = """
  CREATE TABLE IF NOT EXISTS billon(
    "billon_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "billon_creationdate" TEXT,
    "billon_type" INTEGER,
    "drug_id" INTEGER,
    "patient_id" INTEGER,
    "doctor_id" INTEGER,
    FOREIGN KEY("drug_id") REFERENCES "drug"("drug_id") ON DELETE CASCADE,
    FOREIGN KEY("doctor_id") REFERENCES "doctor"("doctor_id") ON DELETE CASCADE,
    FOREIGN KEY("patient_id") REFERENCES "patient"("patient_id") ON DELETE CASCADE
  );
  """;
}
