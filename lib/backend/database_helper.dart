import 'package:sqflite/sqflite.dart';

import '../entities/doctor.dart';
import '../entities/drug.dart';
import '../entities/patient.dart';
import '../entities/billon.dart';

class DatabaseHelper {
  static Database _db;
  static init() async {
    await openDB();
  }

  static openDB() async {
    _db = await openDatabase("pahrm.db", version: 1,
        onCreate: (db, version) async {
      await db.execute('PRAGMA foreign_keys = ON');
      await db.execute(createDoctorTable);
      await db.execute(createDrugTable);
      await db.execute(createPatientTable);
      await db.execute(createBillonTable);
    });
  }

  //doctor
  static Future<int> insertDoctor(Doctor doctor) async {
    return await _db.insert("doctor", doctor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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

  static Future<int> updatePatient(Patient patient) async {
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

  //billon
  static Future<int> insertBillon(Billon billon) async {
    return await _db.insert("billon", billon.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static String createDoctorTable = """
  CREATE TABLE IF NOT EXISTS doctor(
    "doctor_id"	INTEGER PRIMARY KEY AUTOINCREMENT,
    "doctor_name"	TEXT UNIQUE
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
