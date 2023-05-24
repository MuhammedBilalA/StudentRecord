import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_02/Screens/home_screen.dart';
import 'package:project_02/db/functions/db_functions.dart';
import 'package:project_02/db/model/data_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key, required this.passValueProfile, required this.imagePath})
      : super(key: key);

  StudentModel passValueProfile;
  String imagePath;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formkey = GlobalKey<FormState>();
  late final _ageControllor =
      TextEditingController(text: widget.passValueProfile.age);
  late final _nameControllor =
      TextEditingController(text: widget.passValueProfile.name);
  late final _numberControllor =
      TextEditingController(text: widget.passValueProfile.phone);
  late final _emailControllor =
      TextEditingController(text: widget.passValueProfile.email);

  Future<void> studentAddBTN() async {
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
      image: widget.imagePath,
    );

    final studentDB = await Hive.openBox<StudentModel>('student_db');
    int? newKey;
    for (var element in studentDB.values) {
      if (widget.passValueProfile == element) {
        newKey = element.key;
      }
    }
    studentDB.put(newKey, student);

    getAllStudent();
  }

  Future takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      widget.imagePath = pickedFile.path;
      print(
          '------------------------------------------------------------------------$widget.imagePath');
      // widget.passValueProfile.image = widget.imagePath;
    }
    setState(() {});
  }

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
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: (widget.imagePath == 'x')
                      ? const AssetImage('assets/pp3.jpg')
                          as ImageProvider<Object>
                      : FileImage(File(widget.imagePath)),
                  child: IconButton(
                      onPressed: () {
                        takePhoto();
                      },
                      icon: const Icon(Icons.add_a_photo_outlined, size: 50)),
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
                                  studentAddBTN();
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
