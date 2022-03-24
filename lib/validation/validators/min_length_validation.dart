import 'package:meta/meta.dart';

import '../../presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  final String field;
  final int size;

  MinLengthValidation({@required this.field, @required this.size});

  @override
  ValidationError validate(String value) {
    if (value == null || value.length < size) return ValidationError.invalidField;
    return null;
  }
}
