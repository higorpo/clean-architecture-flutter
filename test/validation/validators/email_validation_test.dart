import 'package:ForDev/validation/protocols/protocols.dart';
import 'package:test/test.dart';

class EmailValidation implements FieldValidation {
  String validate(String value) {
    return null;
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
}
