// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_02/db/functions/db_functions.dart';
import 'package:project_02/db/model/data_model.dart';

class PersonAdd extends StatefulWidget {
  PersonAdd({super.key});

  @override
  State<PersonAdd> createState() => _PersonAddState();
}

class _PersonAddState extends State<PersonAdd> {
  final formkey = GlobalKey<FormState>();
  final _ageControllor = TextEditingController();
  final _nameControllor = TextEditingController();
  final _numberControllor = TextEditingController();
  final _emailControllor = TextEditingController();
  String imagePath = 'x';

  Future<void> onAddStudentButtonClick(BuildContext ctx) async {
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
      image: imagePath,
    );

    addStudent(_student);
  }

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
              width: double.infinity,
              child: CircleAvatar(
                radius: 80,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: imagePath == 'x'
                      ? AssetImage('assets/pp3.jpg') as ImageProvider
                      : FileImage(File(imagePath)),
                  child: IconButton(
                      onPressed: () {
                        takePhoto();
                      },
                      icon: Icon(Icons.add_a_photo_outlined, size: 50)),
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
                          fillColor: Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: Icon(Icons.person),
                          label: Text('Name'),
                          border: OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter a valid username';
                        }
                      },
                    ),
                    SizedBox(
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
                          fillColor: Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: Icon(Icons.calendar_month_outlined),
                          label: Text('Age'),
                          border: OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Age'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Your Age';
                        }
                      },
                    ),
                    SizedBox(
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
                          fillColor: Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: Icon(Icons.phone),
                          label: Text('PhoneNumber'),
                          border: OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your PhoneNumber'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your number';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailControllor,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Color.fromARGB(255, 234, 247, 239),
                          filled: true,
                          counterText: "",
                          prefixIcon: Icon(Icons.email_outlined),
                          label: Text('email'),
                          border: OutlineInputBorder(),
                          helperText: '',
                          hintText: 'Enter Your Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Your email';
                        }
                      },
                    ),
                    SizedBox(
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
                                child: Text('Cancel')),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: (() {
                                if (formkey.currentState!.validate()) {
                                  onAddStudentButtonClick(context);
                                  Navigator.of(context).pop();
                                } else {}
                              }),
                              child: Text('Save'),
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
