import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String token;

  AccountEntity(this.token);

  @override
  List get props => [token];
}
