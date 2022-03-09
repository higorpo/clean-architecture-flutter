import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List<Object> get props => [field];

  RequiredFieldValidation(this.field);

  ValidationError validate(String value) {
    return value?.isNotEmpty == true ? null : ValidationError.requiredField;
  }
}
