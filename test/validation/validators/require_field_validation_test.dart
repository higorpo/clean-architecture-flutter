import 'package:test/test.dart';

abstract class FieldValidation {
  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

void main() {
  test('Should return null if value is not empty', () {
    final sut = RequiredFieldValidation('any_field');

    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    final sut = RequiredFieldValidation('any_field');

    expect(sut.validate(''), 'Campo obrigatório');
  });
}
