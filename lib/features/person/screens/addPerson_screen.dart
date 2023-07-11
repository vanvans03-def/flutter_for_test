import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/person_provider.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final GlobalKey<FormState> _formKeyStep1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyStep2 = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;
  String? _dateOfBirth;
  String? _address;
  String? _building;
  String? _street;
  String? _province;

  int currentStep = 0;
  void changeStep() {
    setState(() {
      currentStep += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มรายชื่อ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stepper(
          currentStep: currentStep,
          onStepCancel: () => currentStep == 0
              ? null
              : setState(() {
                  currentStep -= 1;
                }),
          onStepContinue: () {
            bool isLastStep = (currentStep == getSteps().length - 1);
            if (isLastStep) {
              if (_formKeyStep2.currentState!.validate()) {
                _saveForm();
              }
            } else {
              setState(() {
                if (_formKeyStep1.currentState!.validate()) {
                  currentStep += 1;
                }
              });
            }
          },
          steps: getSteps(),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        title: const Text('ข้อมูลส่วนตัว'),
        isActive: currentStep == 0,
        content: Form(
          key: _formKeyStep1,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ชื่อ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ชื่อ';
                  }
                  return null;
                },
                onSaved: (value) => _firstName = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'นามสกุล'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่นามสกุล';
                  }
                  return null;
                },
                onSaved: (value) => _lastName = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'วันเกิด(วว/ดด/ปป)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่วันเกิด';
                  }
                  return null;
                },
                onSaved: (value) => _dateOfBirth = value,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('ข้อมูลที่อยู่ตามบัตรประชาชน'),
        isActive: currentStep == 1,
        content: Form(
          key: _formKeyStep2,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ที่อยู่'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ที่อยู่';
                  }
                  return null;
                },
                onSaved: (value) => _address = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'อาคาร'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่อาคารหรือกรอก " - "';
                  }
                  return null;
                },
                onSaved: (value) => _building = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ถนน'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่ถนน';
                  }
                  return null;
                },
                onSaved: (value) => _street = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'จังหวัด'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาใส่จังหวัด';
                  }
                  return null;
                },
                onSaved: (value) => _province = value,
              ),
            ],
          ),
        ),
      )
    ];
  }

  void _saveForm() {
    if (_formKeyStep1.currentState!.validate() &&
        _formKeyStep2.currentState!.validate()) {
      _formKeyStep1.currentState!.save();
      _formKeyStep2.currentState!.save();
      final personProvider =
          Provider.of<PersonProvider>(context, listen: false);

      personProvider.updatePerson(
        firstName: _firstName ?? "",
        lastName: _lastName ?? "",
        dateOfBirth: _dateOfBirth ?? "",
        address: _address ?? "",
        building: _building ?? "",
        street: _street ?? "",
        province: _province ?? "",
      );
      Navigator.pop(context);
    }
  }
}
