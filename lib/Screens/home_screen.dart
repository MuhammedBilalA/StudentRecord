import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_02/Screens/editing_screen.dart';
import 'package:project_02/Screens/person_add.dart';
import 'package:project_02/Screens/search_screen.dart';
import 'package:project_02/Screens/student_details.dart';
import 'package:project_02/db/functions/db_functions.dart';
import 'package:project_02/db/model/data_model.dart';
import 'package:project_02/student_model/student_model_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StudentModelBloc>().add(GetAllStudent());
    // getAllStudent();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getAllStudent();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: (() {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const SearchScreen()));
              }),
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      body: BlocBuilder<StudentModelBloc, StudentModelState>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: ((ctx, index) {
                StudentModel student = state.studentList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.all(15),
                    tileColor: const Color.fromARGB(255, 168, 234, 132),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentDetails(
                                  passValue: student, passId: index)));
                    },
                    title: Text(
                      student.name,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (() {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return EditProfile(
                                  imagePath: student.image,
                                  passValueProfile: student,
                                );
                              }));
                            }),
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: ((() {
                              deleteAlert(context, student);
                            })),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        showprofile(context, student);
                      },
                      child: CircleAvatar(
                        backgroundImage: student.image == 'x'
                            ? const AssetImage('assets/pp3.jpg')
                                as ImageProvider
                            : FileImage(File(student.image)),
                        backgroundColor: Colors.green,
                        radius: 33,
                      ),
                    ),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: 0,
                );
              }),
              itemCount: state.studentList.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((ctx) => PersonAdd())));
        }),
        tooltip: "AddStudent",
        child: const Icon(Icons.person_add),
      ),
    );
  }

  showprofile(BuildContext context, StudentModel data) {
    showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            content: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: data.image == 'x'
                      ? const AssetImage('assets/pp3.jpg') as ImageProvider
                      : FileImage(
                          File(data.image),
                        ),
                ),
              ),
            ),
          );
        }));
  }

  deleteAlert(BuildContext context, StudentModel studentModel) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Text('Are you sure you want to delete'),
              actions: [
                TextButton(
                    onPressed: () {
                      deleteStudent(studentModel);
                      Navigator.of(context).pop(ctx);
                    },
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(ctx);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }
}
