import 'package:faker/faker.dart';
import 'package:fordev/domain/entities/entities.dart';

class FakeAccountFactory {
  static Map makeApiJson() => {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  static AccountEntity makeEntity() => AccountEntity(faker.guid.guid());
}
