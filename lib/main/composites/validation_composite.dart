import '../../presentation/protocols/protocols.dart';

import '../../validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  ValidationError? validate({required String field, required Map input}) {
    for (final validation in validations.where((element) => element.field == field)) {
      final error = validation.validate(input);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
