import 'package:ForDev/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  String validate(String value) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : "Campo inválido";
  }
}

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation();
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('higor@gmail.com'), null);
  });

  test('Should return error if email is invalid', () {
    expect(sut.validate('higor'), 'Campo inválido');
  });
}
