import 'package:meta/meta.dart';

import '../../presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String fieldToCompare;

  CompareFieldsValidation({@required this.field, @required this.fieldToCompare});

  @override
  ValidationError validate(Map input) {
    return input[field] == input[fieldToCompare] ? null : ValidationError.invalidField;
  }
}
