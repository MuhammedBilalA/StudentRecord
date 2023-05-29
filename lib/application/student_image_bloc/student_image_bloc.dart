import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'student_image_event.dart';
part 'student_image_state.dart';

class StudentImageBloc extends Bloc<StudentImageEvent, StudentImageState> {
  StudentImageBloc() : super(StudentImageInitial()) {
    on<GetImagePath>((event, emit) async {
      try {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        String newPath;
        if (pickedFile != null) {
          newPath = pickedFile.path;
        } else {
          newPath = 'x';
        }

        return emit(StudentImageState(imagePath: newPath));
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
