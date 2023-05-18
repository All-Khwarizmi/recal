import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/providers/firestore_state/fire_state.dart';

import '../providers/hive/main_provider.dart';

final _formKey = GlobalKey<FormState>();

class FormInModal extends StatelessWidget {
  const FormInModal({super.key});

  @override
  Widget build(BuildContext context) {
   
    var fireState = context.watch<FireState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Something please";
                } else {
                  // appState.createTopicSync(value);
                  fireState.addTopicFire(value);
                  Navigator.pop(context);
                  return null;
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //  box.add("Waiting...");
                    print(_formKey.currentState);
                  }
                },
                child: Text("Validate"))
          ],
        ),
      ),
    );
  }
}
