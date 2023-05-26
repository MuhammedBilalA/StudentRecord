part of 'student_model_bloc.dart';

class StudentModelState {
  final List<StudentModel> studentList;

  StudentModelState({required this.studentList});
}

class StudentModelInitial extends StudentModelState {
  StudentModelInitial() : super(studentList: []);
}
