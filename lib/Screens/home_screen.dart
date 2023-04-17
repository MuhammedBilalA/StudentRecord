import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_02/Screens/editing_screen.dart';
import 'package:project_02/Screens/person_add.dart';
import 'package:project_02/Screens/search_screen.dart';
import 'package:project_02/Screens/student_details.dart';
import 'package:project_02/db/functions/db_functions.dart';
import 'package:project_02/db/model/data_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              }),
              icon: Icon(
                Icons.search,
              ))
        ],
        
      ),
      body: ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
              itemBuilder: ((ctx, index) {
                final data = studentList[index];
                data.key;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.all(15),
                    tileColor: Color.fromARGB(255, 168, 234, 132),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentDetails(
                                  passValue: data, passId: index)));
                    },
                    title: Text(
                      data.name,
                    ),
                    // subtitle: Text(data.age),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (() {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return EditProfile(
                                  passValueProfile: data,
                                  index: index,
                                );
                              }));
                            }),
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: ((() {
                              deleteAlert(context, index);
                            })),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        showprofile(context, data);
                      },
                      child: CircleAvatar(
                        backgroundImage: data.image == 'x'
                            ? AssetImage('assets/pp3.jpg') as ImageProvider
                            : FileImage(File(data.image)),
                        backgroundColor: Colors.green,
                        radius: 33,
                      ),
                    ),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return SizedBox(
                  height: 0,
                );
              }),
              itemCount: studentList.length);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((ctx) => PersonAdd())));
        }),
        tooltip: "AddStudent",
        child: Icon(Icons.person_add),
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
                      ? AssetImage('assets/pp3.jpg') as ImageProvider
                      : FileImage(
                          File(data.image),
                        ),
                ),
              ),
            ),
            // title: Icon(
            //   Icons.person,
            //   size: 250,

            // ),
          );
        }));
  }

  deleteAlert(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Text('Are you sure you want to delete'),
              actions: [
                TextButton(
                    onPressed: () {
                      deleteStudent(index);
                      Navigator.of(context).pop(ctx);
                    },
                    child: Text('Delete', style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(ctx);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }
}
