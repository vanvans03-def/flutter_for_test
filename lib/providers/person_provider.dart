import 'package:flutter/material.dart';

import '../models/person.dart';

class PersonProvider extends ChangeNotifier {
  List<Person> _allPersons = [];

  List<Person> get allPersons => _allPersons;

  void addPerson({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String address,
    required String building,
    required String street,
    required String province,
  }) {
    final person = Person(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      address: address,
      building: building,
      street: street,
      province: province,
    );
    _allPersons.add(person);
    notifyListeners();
  }

  void updatePerson({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String address,
    required String building,
    required String street,
    required String province,
  }) {
    final person = Person(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      address: address,
      building: building,
      street: street,
      province: province,
    );
    _allPersons.add(person);
    notifyListeners();
  }

  void deletePerson(int index) {
    if (index >= 0 && index < _allPersons.length) {
      _allPersons.removeAt(index);
      notifyListeners();
    }
  }
}
