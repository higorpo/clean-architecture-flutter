import 'translations.dart';

class PtBr implements Translations {
  String get msgRequiredField => 'Campo obrigatório';
  String get msgInvalidField => 'Campo inválido';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgUnexpectedError => 'Algo errado aconteceu. Tente novamente em breve.';
  String get msgEmailInUse => 'O email já está em uso.';

  String get addAccount => 'Criar conta';
  String get name => 'Nome';
  String get email => 'Email';
  String get enter => 'Entrar';
  String get login => 'Login';
  String get password => 'Senha';
  String get surveys => 'Enquetes';
  String get confirmPassword => 'Confirmar senha';
  String get wait => 'Aguarde...';
  String get reload => 'Recarregar';
}
