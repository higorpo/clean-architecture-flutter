import 'package:flutter/material.dart';

import '../../components/components.dart';

import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Headline1(text: 'Login'),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: [
                    StreamBuilder<String>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: presenter.validateEmail,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                      ),
                      obscureText: true,
                      onChanged: presenter.validatePassword,
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      child: Text('Entrar'.toUpperCase()),
                      onPressed: null,
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar conta'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
