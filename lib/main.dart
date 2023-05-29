import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_02/application/student_image_bloc/student_image_bloc.dart';
import 'package:project_02/application/student_model_bloc/student_model_bloc.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/presentation/Screens/home_screen.dart';




Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const StudentRecord());
}

class StudentRecord extends StatelessWidget {
  const StudentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider(
          create: (context) => StudentModelBloc(),
        ),
        BlocProvider(
          create: (context) => StudentImageBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Record',
        theme: ThemeData(primarySwatch: Colors.green),
        home: const HomeScreen(),
      ),
    );
  }
}
