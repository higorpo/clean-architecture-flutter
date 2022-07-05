import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../components/components.dart';
import '../../mixins/mixins.dart';

import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget with KeyboardManager, LoadingManager, UiErrorManager, NavigationManager {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          handleMainError(context, presenter.mainErrorStream);
          handleNavigation(presenter.navigateToStream, clearStack: true);

          return GestureDetector(
            onTap: () => hideKeyboard(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text: R.strings.login),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Provider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            SizedBox(height: 20),
                            PasswordInput(),
                            SizedBox(height: 40),
                            LoginButton(),
                            FlatButton.icon(
                              onPressed: presenter.goToSignUp,
                              icon: Icon(Icons.person),
                              label: Text(R.strings.addAccount),
                            )
                          ],
                        ),
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
