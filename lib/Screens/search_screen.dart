import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_02/Screens/student_details.dart';
import 'package:project_02/db/model/data_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();
  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

  Widget expanded() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                File img = File(studentDisplay[index].image);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                    radius: 22,
                  ),
                  title: Text(studentDisplay[index].name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentDetails(
                                passValue: studentDisplay[index],
                                passId: index)));
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'No Match Found',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget searchTextField() {
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            onPressed: () => clearText(),
            icon: Icon(
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
        _searchStudent(value);
      },
    );
  }

  void _searchStudent(String value) {
    setState(() {
      studentDisplay = studentList
          .where((element) => element.name.contains(value.trim()))
          .toList();
    });
  }

  void clearText() {
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            searchTextField(),
            expanded(),
          ],
        ),
      )),
    );
  }
}
