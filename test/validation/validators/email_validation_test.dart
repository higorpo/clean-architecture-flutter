import 'package:test/test.dart';

import 'package:ForDev/presentation/protocols/protocols.dart';

import 'package:ForDev/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
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
    expect(sut.validate('higor'), ValidationError.invalidField);
  });
}
