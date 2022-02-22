import 'package:ForDev/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  String validate(String value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    final sut = EmailValidation();

    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    final sut = EmailValidation();

    expect(sut.validate(null), null);
  });
}
