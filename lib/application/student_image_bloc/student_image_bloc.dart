
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'student_image_event.dart';
part 'student_image_state.dart';

class StudentImageBloc extends Bloc<StudentImageEvent, StudentImageState> {
  StudentImageBloc() : super(StudentImageInitial()) {
    on<GetImagePath>((event, emit) async {
      String newPath = event.imgPath;
      // try {
      //   final pickedFile =
      //       await ImagePicker().pickImage(source: ImageSource.gallery);
      //   String newPath;
      //   if (pickedFile != null) {
      //     newPath = pickedFile.path;
      //   } else {
      //     newPath = 'x';
      //   }

      // } catch (e) {
      //   log(e.toString());
      // }
      return emit(StudentImageState(imagePath: newPath));
    });
  }
}
