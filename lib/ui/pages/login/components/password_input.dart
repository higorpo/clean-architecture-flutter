import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/errors/errors.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<UIError>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.hasData ? snapshot.data.description : null,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      },
    );
  }
}
