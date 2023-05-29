import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_02/application/student_image_bloc/student_image_bloc.dart';
import 'package:project_02/application/student_model_bloc/student_model_bloc.dart';
import 'package:project_02/domain/model/data_model.dart';

Future<void> addStudent(StudentModel value, BuildContext context) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  await studentDB.add(value);

  context.read<StudentModelBloc>().add(GetAllStudent());
}

Future<List<StudentModel>> getAllStudent() async {
  try {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    List<StudentModel> studentList = [];
    studentList.addAll(studentDB.values);
    return studentList;
  } catch (e) {
    log(e.toString());
    return [];
  }
}

Future<void> deleteStudent(
    StudentModel studentModel, BuildContext context) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentDB.delete(studentModel.key);

  context.read<StudentModelBloc>().add(GetAllStudent());
}

Future<String> takePhoto(BuildContext context) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    String imagePath = pickedFile.path;

    context.read<StudentImageBloc>().add(GetImagePath(imagePath));
    String newPath = imagePath;
    return newPath;
  } else {
    context.read<StudentImageBloc>().add(GetImagePath('x'));
    String newPath = 'x';
    return newPath;
  }
}
