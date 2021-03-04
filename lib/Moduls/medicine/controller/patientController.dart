
import 'dart:async';

import '../model/Patient.dart';
import '../service/patientService.dart';

class PatientController {

  final PatientService _patientService =  PatientService();

  Future<List<Patient>> getPatientNameList() async {
    return await this._patientService.getPatientList();
  }
    Future<int> insertPatient( patient) async {
      return await this._patientService.insertPatient(patient);
    }
      Future<int> updatePatient(Patient patient) async {
        return await this._patientService.updatePatient(patient);
      }
        Future<int> deletePatient(int id) async {
          return await this._patientService.deletePatient(id);
        }

  Future<List<Map<String, dynamic>>> getPatientMapList() async {
    return await this._patientService.getPatientMapList();

  }
  Future<List<Patient>> getPatientList() async {
    return await this._patientService.getPatientList();

  }
  }