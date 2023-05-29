import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/infrastructure/functions/db_functions.dart';
import 'package:project_02/presentation/Screens/home_screen.dart';

import '../../application/student_image_bloc/student_image_bloc.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile(
      {Key? key, required this.passValueProfile, required this.imagePath})
      : super(key: key);

  final StudentModel passValueProfile;
  String imagePath;

  final formkey = GlobalKey<FormState>();

  late final _ageControllor = TextEditingController(text: passValueProfile.age);

  late final _nameControllor =
      TextEditingController(text: passValueProfile.name);

  late final _numberControllor =
      TextEditingController(text: passValueProfile.phone);

  late final _emailControllor =
      TextEditingController(text: passValueProfile.email);

  Future<void> studentAddBTN(BuildContext context, String newpathUpdate) async {
    final name = _nameControllor.text.trim();
    final age = _ageControllor.text.trim();
    final num = _numberControllor.text.trim();
    final email = _emailControllor.text.trim();

    if (name.isEmpty || age.isEmpty || num.isEmpty || email.isEmpty) {
      return;
    }
    final student = StudentModel(
      name: name,
      age: age,
      phone: num,
      email: email,
      image: newpathUpdate,
    );

    final studentDB = await Hive.openBox<StudentModel>('student_db');
    int? newKey;
    for (var element in studentDB.values) {
      if (passValueProfile == element) {
        newKey = element.key;
      }
    }

    await studentDB.put(newKey, student);
    context.read<StudentImageBloc>().add(GetImagePath('x'));
  }

  bool update = true;
  String newpath = 'x';
  String Kpath='x';

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
                    newpath = state.imagePath;

                    return CircleAvatar(
                      radius: 80,
                      backgroundImage: (imagePath == 'x')
                          ? AssetImage('assets/pp3.jpg')
                              as ImageProvider<Object>
                          : update == true
                              ? FileImage(File(imagePath))
                              : FileImage(File(state.imagePath)),
                      child: IconButton(
                          onPressed: () async {
                            Kpath = await takePhoto(context);

                            if (Kpath != 'x') {
                              update = false;
                            }

                            // update = true;
                            // context
                            //     .read<StudentImageBloc>()
                            //     .add(GetImagePath());
                          },
                          icon:
                              const Icon(Icons.add_a_photo_outlined, size: 50)),
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
                              onPressed: (() async {
                                if (formkey.currentState!.validate()) {
                                  // imagePath = newpath;
                                  if(Kpath!='x'){
                                  await studentAddBTN(context, newpath);


                                  }else{
                                  await studentAddBTN(context, imagePath);

                                    
                                  }

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (ctx) => const HomeScreen()),
                                      (route) => false);
                                } else {}
                              }),
                              child: const Text('Update'),
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
}
