import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/presentation/Screens/editing_screen.dart';

class StudentDetails extends StatelessWidget {
 const StudentDetails({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);
 final StudentModel passValue;
  final int passId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  showProfile(context, passValue);
                },
                child: CircleAvatar(
                  radius: 80,
                  child: CircleAvatar(
                    backgroundImage: passValue.image == 'x'
                        ? const AssetImage('assets/pp3.jpg') as ImageProvider
                        : FileImage(File(passValue.image)),
                    radius: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    passValue.name,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Age',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    passValue.age,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'Phone',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    passValue.phone,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    'email',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  width: 50,
                  child: Text(
                    ':',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    passValue.email,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(height: 230, width: 100),
                ElevatedButton.icon(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    icon: const Icon(Icons.arrow_circle_left),
                    label: const Text('Back')),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton.icon(
                    onPressed: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => EditProfile(
                            imagePath: passValue.image,

                               passValueProfile: passValue)));
                    }),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit   ')),
              ],
            )
          ],
        ),
      ),
    );
  }

  showProfile(BuildContext context, StudentModel passvalue) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: passvalue.image == 'x'
                      ? const AssetImage('assets/pp3.jpg') as ImageProvider
                      : FileImage(
                          File(passvalue.image),
                        ),
                ),
              ),
            ),
          );
        });
  }
}
