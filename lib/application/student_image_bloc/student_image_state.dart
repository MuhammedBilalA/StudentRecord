part of 'student_image_bloc.dart';

class StudentImageState {
  String imagePath;
  StudentImageState({required this.imagePath});
}

class StudentImageInitial extends StudentImageState {
  StudentImageInitial() : super(imagePath: 'x');
}
