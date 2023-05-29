import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_02/application/student_model_bloc/student_model_bloc.dart';
import 'package:project_02/domain/model/data_model.dart';
import 'package:project_02/presentation/Screens/editing_screen.dart';
import 'package:project_02/presentation/Screens/student_details.dart';
import 'package:project_02/infrastructure/functions/db_functions.dart';

TextEditingController searchControllorNew = TextEditingController();

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StudentModelBloc>().add(SearchStudent(query: ''));
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 226, 226),
      body: SafeArea(
        child: Column(
          children: [
            searchTextformFieldFunction(context),
            Expanded(
              child: searchFound(context),
            )
          ],
        ),
      ),
    );
  }

  Widget searchEmpty() {
    return const SizedBox(
      child: Center(
        child: Text(
          'Student Not Found',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget searchFound(BuildContext context) {
    return BlocBuilder<StudentModelBloc, StudentModelState>(
      builder: (context, state) {
        if (state.studentList.isEmpty) {
          return searchEmpty();
        }
        return ListView.separated(
            itemBuilder: ((ctx, index) {
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
                                passValue: state.studentList[index],
                                passId: index)));
                  },
                  title: Text(
                    state.studentList[index].name,
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
                                imagePath: state.studentList[index].image,
                                passValueProfile: state.studentList[index],
                              );
                            }));
                          }),
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: ((() {
                            deleteAlert(context, state.studentList[index]);
                          })),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      showprofile(context, state.studentList[index]);
                    },
                    child: CircleAvatar(
                      backgroundImage: state.studentList[index].image == 'x'
                          ? const AssetImage('assets/pp3.jpg') as ImageProvider
                          : FileImage(File(state.studentList[index].image)),
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
    );
  }

  searchTextformFieldFunction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: TextFormField(
          autofocus: true,
          controller: searchControllorNew,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  clearText(context);
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
              filled: true,
              fillColor: Colors.green[300],
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)),
              hintText: 'Search'),
          onChanged: (value) {
            context.read<StudentModelBloc>().add(SearchStudent(query: value));
          },
        ),
      ),
    );
  }

  void clearText(context) {
    if (searchControllorNew.text.isNotEmpty) {
      searchControllorNew.clear();
    } else {
      Navigator.of(context).pop();
    }
  }

  deleteAlert(BuildContext context, StudentModel studentModel) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Text('Are you sure you want to delete'),
              actions: [
                TextButton(
                    onPressed: () {
                      deleteStudent(studentModel, context);

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
}
