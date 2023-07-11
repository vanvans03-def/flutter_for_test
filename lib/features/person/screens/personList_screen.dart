// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_for_test/features/person/screens/personDetail_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/person.dart';
import '../../../providers/person_provider.dart';

class PersonListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อทั้งหมด'),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'ทั้งหมด',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'แยกตามจังหวัด',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: Colors.blue,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildPersonList(personProvider.allPersons),
                        _buildPersonsByProvince(personProvider.allPersons),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_person');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPersonList(List<Person> persons) {
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        final personProvider = Provider.of<PersonProvider>(context);
        final person = persons[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            radius: 15,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(
            '${person.firstName} ${person.lastName}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            '${person.address}, ${person.building}, ${person.street}, ${person.province}',
            maxLines: 2,
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailPage(person: person),
              ),
            );
          },
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade400,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('ลบข้อมูล'),
                    content: Text('คุณต้องการลบข้อมูลนี้หรือไม่?'),
                    actions: [
                      TextButton(
                        child: Text('ยกเลิก'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('ลบ'),
                        onPressed: () {
                          personProvider.deletePerson(index);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPersonsByProvince(List<Person> persons) {
    Map<String, List<Person>> personsByProvince = {};

    for (var person in persons) {
      if (personsByProvince.containsKey(person.province)) {
        personsByProvince[person.province]!.add(person);
      } else {
        personsByProvince[person.province] = [person];
      }
    }

    return ListView.builder(
      itemCount: personsByProvince.length,
      itemBuilder: (context, index) {
        String province = personsByProvince.keys.elementAt(index);
        List<Person> personsInProvince = personsByProvince[province]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                province,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: personsInProvince.length,
              itemBuilder: (context, index) {
                final person = personsInProvince[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 15,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    '${person.firstName} ${person.lastName}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    '${person.address}, ${person.building}, ${person.street}, ${person.province}',
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonDetailPage(person: person),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
