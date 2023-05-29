import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_02/application/student_image_bloc/student_image_bloc.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/infrastructure/functions/db_functions.dart';

class PersonAdd extends StatelessWidget {
  PersonAdd({super.key});

  final formkey = GlobalKey<FormState>();

  final _ageControllor = TextEditingController();

  final _nameControllor = TextEditingController();

  final _numberControllor = TextEditingController();

  final _emailControllor = TextEditingController();

  String imagePath = 'x';

  Future<void> onAddStudentButtonClick(BuildContext ctx, newPath1) async {
    final _name = _nameControllor.text.trim();
    final _age = _ageControllor.text.trim();
    final _num = _numberControllor.text.trim();
    final _email = _emailControllor.text.trim();

    if (_name.isEmpty || _age.isEmpty || _num.isEmpty || _email.isEmpty) {
      return;
    }

    final _student = StudentModel(
      name: _name,
      age: _age,
      phone: _num,
      email: _email,
      image: newPath1,
    );

    addStudent(_student, ctx);
  }

  String newPath = 'x';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: double.infinity,
              child: CircleAvatar(
                radius: 80,
                child: BlocBuilder<StudentImageBloc, StudentImageState>(
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: 80,
                      backgroundImage: fun(state.imagePath),
                      child: IconButton(
                          onPressed: () {
                            log(state.imagePath.toString());
                            context
                                .read<StudentImageBloc>()
                                .add(GetImagePath());
                            newPath = state.imagePath;
                            log(newPath.toString());
                          },
                          icon: state.imagePath == 'x'
                              ? Icon(Icons.add_a_photo_outlined, size: 50)
                              : SizedBox()),
                    );
                  },
                ),
              ),
            ),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameControllor,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: const Icon(Icons.person),
                          label: const Text('Name'),
                          border: const OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter a valid username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _ageControllor,
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: const Icon(Icons.calendar_month_outlined),
                          label: const Text('Age'),
                          border: const OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Your Age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _numberControllor,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: const Icon(Icons.phone),
                          label: const Text('PhoneNumber'),
                          border: const OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your PhoneNumber'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailControllor,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: const Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: const Icon(Icons.email_outlined),
                          label: const Text('email'),
                          border: const OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70, top: 40),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text('Cancel')),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: (() {
                                if (formkey.currentState!.validate()) {
                                  // imagePath = newPath;
                                  onAddStudentButtonClick(context, newPath);
                                  Navigator.of(context).pop();
                                } else {}
                              }),
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  fun(String path) {
    if (path == 'x') {
      return AssetImage('assets/pp3.jpg');
    } else {
      return FileImage(File(path));
    }
  }
}
