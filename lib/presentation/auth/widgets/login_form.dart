import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/application/auth/bloc/auth_bloc.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/presentation/shared/loading_snack.dart';
import 'package:recal_mobile2/presentation/shared/theme.dart';
import '../../../Legacy/services/authentication/fire_auth.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key, required this.list});
  final List<Category> list;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String dropdownValue = widget.list.first.categoryName;
  String? userName;

  @override
  Widget build(BuildContext context) {
    var recalTheme = RecalTheme();
    var repo = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recal',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: recalTheme.primaryColor,
                fontSize: 124,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              autofocus: true,
              style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
              decoration: InputDecoration(
                  hintText: "Enter a name",
                  hintStyle: TextStyle(color: Colors.white)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  userName = value;
                  return null;
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton(
                value: dropdownValue,
                dropdownColor: recalTheme.backGroundColor,
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                items: widget.list.map<DropdownMenuItem>((Category value) {
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
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ElevatedButton.icon(
                icon: Icon(FontAwesomeIcons.userNinja),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    backgroundColor: Colors.white,
                    iconColor: recalTheme.primaryColor),
                label: Text(
                  "Signin",
                  style:
                      TextStyle(color: recalTheme.primaryColor, fontSize: 20),
                ),
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.

                  if (_formKey.currentState!.validate() && userName != null) {
                    print({dropdownValue, userName});
                    repo.add(SignUpRequested(dropdownValue, userName!));
                    
                    showSnack(context: context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please fill all the fields")));
                  }
                },
              ),
            ),
          ],
        ),
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
