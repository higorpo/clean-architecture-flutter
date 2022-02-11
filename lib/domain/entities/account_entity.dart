class AccountEntity {
  final String token;

  AccountEntity(this.token);

  factory AccountEntity.fromJson(Map json) {
    return AccountEntity(json['accessToken']);
  }
}
