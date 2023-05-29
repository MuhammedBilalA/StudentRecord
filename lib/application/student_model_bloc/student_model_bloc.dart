import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/infrastructure/functions/db_functions.dart';
part 'student_model_event.dart';
part 'student_model_state.dart';

class StudentModelBloc extends Bloc<StudentModelEvent, StudentModelState> {
  StudentModelBloc() : super(StudentModelInitial()) {
    on<GetAllStudent>((event, emit) async {
      try {
        List<StudentModel> studentList = await getAllStudent();

        return emit(StudentModelState(studentList: studentList));
      } catch (e) {
        log(e.toString());
      }
    });
    on<SearchStudent>((event, emit) async {
      List<StudentModel> studentList = await getAllStudent();
      List<StudentModel> searchList = [];
      searchList = studentList
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      return emit(StudentModelState(studentList: searchList));
    });
  }
}
