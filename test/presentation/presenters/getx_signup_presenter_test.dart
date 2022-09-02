import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:ForDev/ui/helpers/errors/errors.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/usecases/usecases.dart';

import 'package:ForDev/presentation/presenters/presenters.dart';
import 'package:ForDev/presentation/protocols/protocols.dart';

import '../../mocks/mocks.dart';

class ValidationSpy extends Mock implements Validation {}

class AddAccountSpy extends Mock implements AddAccount {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

void main() {
  GetxSignUpPresenter sut;
  ValidationSpy validation;
  AddAccountSpy addAccount;
  SaveCurrentAccountSpy saveCurrentAccount;
  String email;
  String name;
  String password;
  AccountEntity account;

  PostExpectation mockValidationCall(String field) =>
      when(validation.validate(field: field == null ? anyNamed('field') : field, input: anyNamed('input')));

  void mockValidation({String field, ValidationError value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAddAccountCall() => when(addAccount.add(any));

  void mockAddAccount(AccountEntity data) {
    account = data;
    mockAddAccountCall().thenAnswer((_) async => data);
  }

  void mockAddAccountError(DomainError error) {
    mockAddAccountCall().thenThrow(error);
  }

  PostExpectation mockSaveCurrentAccountCall() => when(saveCurrentAccount.save(any));

  void mockSaveCurrentAccountError() {
    mockSaveCurrentAccountCall().thenThrow(DomainError.unexpected);
  }

  setUp(() {
    validation = ValidationSpy();
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();
    sut = GetxSignUpPresenter(
      validation: validation,
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );
    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    mockValidation();
    mockAddAccount(FakeAccountFactory.makeEntity());
  });

  test('Should call Validation with correct email', () {
    final formData = {'email': email, 'name': null, 'password': null, 'passwordConfirmation': null};

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if email validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct name', () {
    final formData = {'email': null, 'name': name, 'password': null, 'passwordConfirmation': null};

    sut.validateName(name);

    verify(validation.validate(field: 'name', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if name is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit requiredFieldError if name is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if name validation succeeds', () {
    sut.nameErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should call Validation with correct password', () {
    final formData = {'email': null, 'name': null, 'password': password, 'passwordConfirmation': null};

    sut.validatePassword(password);

    verify(validation.validate(field: 'password', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if password is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit requiredFieldError if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if password validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct passwordConfirmation', () {
    final formData = {'email': null, 'name': null, 'password': null, 'passwordConfirmation': password};

    sut.validatePasswordConfirmation(password);

    verify(validation.validate(field: 'passwordConfirmation', input: formData)).called(1);
  });

  test('Should emit invalidFieldError if passwordConfirmation is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(password);
    sut.validatePasswordConfirmation(password);
  });

  test('Should emit requiredFieldError if passwordConfirmation is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(password);
    sut.validatePasswordConfirmation(password);
  });

  test('Should emit null if passwordConfirmation validation succeeds', () {
    sut.passwordConfirmationErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(password);
    sut.validatePasswordConfirmation(password);
  });

  test('Should emit form valid event if form is valid', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(password);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddAccount if correct values', () async {
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    await sut.signUp();

    verify(addAccount.add(AddAccountParams(
      email: email,
      name: name,
      password: password,
      passwordConfirmation: password,
    ))).called(1);
  });

  test('Should call SaveCurrentAccount if correct value', () async {
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    await sut.signUp();

    verify(saveCurrentAccount.save(account)).called(1);
  });

  test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
    mockSaveCurrentAccountError();
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should emit correct events on AddAccount success', () async {
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));

    await sut.signUp();
  });

  test('Should emit correct events on EmailInUseError', () async {
    mockAddAccountError(DomainError.emailInUse);
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.emailInUse]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAddAccountError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.signUp();
  });

  test('Should change page on success', () async {
    sut.validateEmail(email);
    sut.validateName(name);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(password);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.signUp();
  });

  test('Should go to LoginPage on link click', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    sut.goToLogin();
  });
}
