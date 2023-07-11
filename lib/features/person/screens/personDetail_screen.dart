// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import '../../../models/person.dart';

class PersonDetailPage extends StatelessWidget {
  final Person person;

  const PersonDetailPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('ชื่อ'),
              subtitle: Text(
                '${person.firstName} ${person.lastName}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('วันเกิด'),
              subtitle: Text(
                '${person.dateOfBirth}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('ที่อยู่'),
              subtitle: Text(
                '${person.address}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('ตึก/อาคาร'),
              subtitle: Text(
                '${person.building}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('ถนน'),
              subtitle: Text(
                '${person.street}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('จังหวัด'),
              subtitle: Text(
                '${person.province}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 0,
            ),
          ],
        ),
      ),
    );
  }
}
