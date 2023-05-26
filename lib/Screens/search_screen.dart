// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:project_02/Screens/editing_screen.dart';
// import 'package:project_02/Screens/student_details.dart';
// import 'package:project_02/db/functions/db_functions.dart';
// import 'package:project_02/db/model/data_model.dart';

// TextEditingController searchControllorNew = TextEditingController();
// ValueNotifier<List<StudentModel>> searchNotifier = ValueNotifier([]);

// class SearchScreen extends StatelessWidget   {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ValueListenableBuilder(
//           valueListenable: searchNotifier,
//           builder: (context, value, child) => Column(
//             children: [
//               searchTextformFieldFunction(context),
//               Expanded(
//                 child: searchControllorNew.text.isEmpty ||
//                         searchControllorNew.text.trim().isEmpty
//                     ? searchFunction(context)
//                     : searchNotifier.value.isEmpty
//                         ? searchEmpty()
//                         : searchFound(context),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   search(String searchtext) {
//     searchNotifier.value = studentListNotifier.value
//         .where((element) => element.name
//             .toLowerCase()
//             .contains(searchtext.toLowerCase().trim()))
//         .toList();
//   }

//   Widget searchEmpty() {
//     return const SizedBox(
//       child: Center(
//         child: Text(
//           'Name Not Found',
//           style: TextStyle(
//             fontSize: 25,
//             color: Colors.red,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   ListView searchFunction(BuildContext context) {
//     return ListView.separated(
//         itemBuilder: ((ctx, index) {
//           // final data = studentListNotifier.value[index];
//           // data.key;
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               contentPadding: const EdgeInsets.all(15),
//               tileColor: const Color.fromARGB(255, 168, 234, 132),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StudentDetails(
//                             passValue: studentListNotifier.value[index],
//                             passId: index)));
//               },
//               title: Text(
//                 studentListNotifier.value[index].name,
//               ),
//               // subtitle: Text(data.age),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                       onPressed: (() {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (ctx) {
//                           return EditProfile(
//                             imagePath: studentListNotifier.value[index].image,
//                             passValueProfile: studentListNotifier.value[index],
//                           );
//                         }));
//                       }),
//                       icon: const Icon(Icons.edit)),
//                   IconButton(
//                       onPressed: ((() {
//                         deleteAlert(context, studentListNotifier.value[index]);
//                       })),
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       )),
//                 ],
//               ),
//               leading: GestureDetector(
//                 onTap: () {
//                   showprofile(context, studentListNotifier.value[index]);
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: studentListNotifier.value[index].image == 'x'
//                       ? const AssetImage('assets/pp3.jpg') as ImageProvider
//                       : FileImage(File(studentListNotifier.value[index].image)),
//                   backgroundColor: Colors.green,
//                   radius: 33,
//                 ),
//               ),
//             ),
//           );
//         }),
//         separatorBuilder: ((context, index) {
//           return const SizedBox(
//             height: 0,
//           );
//         }),
//         itemCount: studentListNotifier.value.length);
//   }

//   ListView searchFound(BuildContext context) {
//     return ListView.separated(
//         itemBuilder: ((ctx, index) {
//           // final data = studentListNotifier.value[index];
//           // data.key;
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               contentPadding: const EdgeInsets.all(15),
//               tileColor: const Color.fromARGB(255, 168, 234, 132),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => StudentDetails(
//                             passValue: searchNotifier.value[index],
//                             passId: index)));
//               },
//               title: Text(
//                 searchNotifier.value[index].name,
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                       onPressed: (() {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (ctx) {
//                           return EditProfile(
//                             imagePath: searchNotifier.value[index].image,
//                             passValueProfile: searchNotifier.value[index],
//                           );
//                         }));
//                       }),
//                       icon: const Icon(Icons.edit)),
//                   IconButton(
//                       onPressed: ((() {
//                         deleteAlert(context, searchNotifier.value[index]);
//                         searchNotifier.notifyListeners();
//                         studentListNotifier.notifyListeners();
//                       })),
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       )),
//                 ],
//               ),
//               leading: GestureDetector(
//                 onTap: () {
//                   showprofile(context, searchNotifier.value[index]);
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: searchNotifier.value[index].image == 'x'
//                       ? const AssetImage('assets/pp3.jpg') as ImageProvider
//                       : FileImage(File(searchNotifier.value[index].image)),
//                   backgroundColor: Colors.green,
//                   radius: 33,
//                 ),
//               ),
//             ),
//           );
//         }),
//         separatorBuilder: ((context, index) {
//           return const SizedBox(
//             height: 0,
//           );
//         }),
//         itemCount: searchNotifier.value.length);
//   }

//   TextFormField searchTextformFieldFunction(BuildContext context) {
//     return TextFormField(
//       autofocus: true,
//       controller: searchControllorNew,
//       cursorColor: Colors.black,
//       decoration: InputDecoration(
//           prefixIcon: const Icon(
//             Icons.search,
//             color: Colors.white,
//           ),
//           suffixIcon: IconButton(
//             onPressed: () {
//               clearText(context);
//             },
//             icon: const Icon(
//               Icons.clear,
//               color: Colors.white,
//             ),
//           ),
//           filled: true,
//           fillColor: Colors.green[300],
//           border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(30)),
//           hintText: 'Search'),
//       onChanged: (value) {
//         search(value);
//         searchNotifier.notifyListeners();
//       },
//     );
//   }

//   void clearText(context) {
//     if (searchControllorNew.text.isNotEmpty) {
//       searchControllorNew.clear();
//       searchNotifier.notifyListeners();
//     } else {
//       Navigator.of(context).pop();
//     }
//   }

//   deleteAlert(BuildContext context, StudentModel studentModel) {
//     showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//               content: const Text('Are you sure you want to delete'),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       deleteStudent(studentModel);
//                       searchNotifier.notifyListeners();
//                       studentListNotifier.notifyListeners();
//                       searchNotifier.value.remove(studentModel);
//                       Navigator.of(context).pop(ctx);
//                     },
//                     child: const Text('Delete', style: TextStyle(color: Colors.red))),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(ctx);
//                       searchNotifier.notifyListeners();
//                     },
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.black),
//                     ))
//               ],
//             ));
//   }

//   showprofile(BuildContext context, StudentModel data) {
//     showDialog(
//         context: context,
//         builder: ((ctx) {
//           return AlertDialog(
//             content: Container(
//               height: 300,
//               width: 300,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: data.image == 'x'
//                       ? const AssetImage('assets/pp3.jpg') as ImageProvider
//                       : FileImage(
//                           File(data.image),
//                         ),
//                 ),
//               ),
//             ),
            
//           );
//         }));
//   }
// }
