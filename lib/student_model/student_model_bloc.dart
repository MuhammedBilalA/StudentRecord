import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_02/db/functions/db_functions.dart';
import 'package:project_02/db/model/data_model.dart';

part 'student_model_event.dart';
part 'student_model_state.dart';

class StudentModelBloc extends Bloc<StudentModelEvent, StudentModelState> {
  StudentModelBloc() : super(StudentModelInitial()) {
    on<GetAllStudent>((event, emit) async {
      List<StudentModel> studentList = await getAllStudent();

      return emit(StudentModelState(studentList: studentList));
    });
  }
}
