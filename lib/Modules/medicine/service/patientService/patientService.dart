import '../../model/Patient.dart';

abstract class PatientService {
  Future<List<Map<String, dynamic>>> getPatientMapList();
  Future<int> insertPatient(Patient patient);
  Future<int> updatePatient(Patient patient);
  Future<bool> testPatientNumber();
  // Delete Operation: Delete a Note object from database
  Future<int> deletePatient(int id);
  // Get number of Note objects in database
  Future<int> getCountPatient();
  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Patient>> getPatientList();
  Future<List<Patient>> getPatientNameList();
  Future<int> getIdPatient(String name);
}