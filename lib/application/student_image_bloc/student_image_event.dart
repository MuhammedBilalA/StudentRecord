part of 'student_image_bloc.dart';

@immutable
abstract class StudentImageEvent {}

class GetImagePath extends StudentImageEvent {
  final String imgPath;

  GetImagePath(this.imgPath);
}
