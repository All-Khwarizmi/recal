import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../services/authentication/fire_auth.dart';
import 'login_button.dart';

final List<String> list = ["One", "Two", 'Three'];

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? dropdownValue;
  String? userName;
  @override
  Widget build(BuildContext context) {
    var recalTheme = RecalTheme();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            autofocus: true,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 20),
            initialValue: "Name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else {
                setState(() {
                  userName = value;
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              style: TextStyle(color: Theme.of(context).primaryColor),
              value: list.first,
              items: list.map<DropdownMenuItem>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value;
                  print(dropdownValue);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.

                if (_formKey.currentState!.validate() &&
                    userName != null &&
                    dropdownValue != null) {
                  print({dropdownValue, userName});
                  AuthService().anonymousLogin(
                      userName: userName, classId: dropdownValue);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all the fields")));
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

String? formFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }

  return null;
}
