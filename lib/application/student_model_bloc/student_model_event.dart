part of 'student_model_bloc.dart';

@immutable
abstract class StudentModelEvent {}

class GetAllStudent extends StudentModelEvent {}

class SearchStudent extends StudentModelEvent {
  final String query;
  SearchStudent({required this.query});
}
