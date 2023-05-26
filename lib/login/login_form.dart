import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../services/authentication/fire_auth.dart';
import 'login_button.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Category> list = [];
  Category category =
      Category(categoryId: "no category", categoryName: "No category just yet");

  void setList() async {
    list = await FirestoreService().getCategories();
  }

  @override
  void initState() {
    super.initState();

    setList();
    setState(() {});
  }

  String? dropdownValue;
  String? userName;
  @override
  Widget build(BuildContext context) {
    var recalTheme = RecalTheme();
    return FutureBuilder(
      future: FirestoreService().getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var list = snapshot.data;

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
                    value: list!.first.categoryName,
                    items: list.map<DropdownMenuItem>((Category value) {
                      return DropdownMenuItem<String>(
                        value: value.categoryName,
                        child: Text(value.categoryName),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please fill all the fields")));
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}

String? formFieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }

  return null;
}
