import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  ValidationError validate({@required String field, @required String value}) {
    for (final validation in validations.where((element) => element.field == field)) {
      final error = validation.validate(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
