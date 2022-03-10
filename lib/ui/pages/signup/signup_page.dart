import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../components/components.dart';

import 'components/components.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text: R.strings.addAccount),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      child: Column(
                        children: [
                          NameInput(),
                          SizedBox(height: 20),
                          EmailInput(),
                          SizedBox(height: 20),
                          PasswordInput(),
                          SizedBox(height: 20),
                          PasswordConfirmationInput(),
                          SizedBox(height: 40),
                          SignUpButton(),
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.exit_to_app),
                            label: Text(R.strings.login),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
