import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../ui/helpers/errors/errors.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;

  var _emailError = Rx<UIError>();
  var _nameError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _passwordConfirmationError = Rx<UIError>();
  var _isFormValid = false.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  GetxSignUpPresenter({@required this.validation});

  @deprecated
  void dispose() {}

  void validateEmail(String email) {
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = false;
  }

  UIError _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }
}
