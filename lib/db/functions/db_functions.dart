
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_02/db/model/data_model.dart';

List<StudentModel> studentListNotifier = [];

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  await studentDB.add(value);
  getAllStudent();
}

Future<List<StudentModel>> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.clear();
  List<StudentModel> studentList = [];
  studentList.addAll(studentDB.values);
  return studentList;

  // studentListNotifier.value.addAll(studentDB.values);
  // studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(StudentModel studentModel) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentDB.delete(studentModel.key);

  getAllStudent();
}
