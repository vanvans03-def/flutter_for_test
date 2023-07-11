import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/person/screens/addPerson_screen.dart';
import 'features/person/screens/personList_screen.dart';
import 'providers/person_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonProvider(),
      child: MaterialApp(
        title: 'บันทึกข้อมูลบุคคล',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => PersonListPage(),
          '/add_person': (context) => const AddPersonPage(),
        },
      ),
    );
  }
}
