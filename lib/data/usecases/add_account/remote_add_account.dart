import 'package:meta/meta.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteAddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({@required this.httpClient, @required this.url});

  Future<void> add(AddAccountParams params) async {
    await httpClient.request(
      url: url,
      method: 'post',
      body: RemoteAddAccountParams.fromDomain(params).toJson(),
    );
  }
}

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RemoteAddAccountParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation,
  });

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) {
    return RemoteAddAccountParams(
      name: params.name,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }

  Map toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }
}