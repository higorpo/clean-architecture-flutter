import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

import '../factories.dart';

AddAccount makeAddAccountAuthentication() {
  return RemoteAddAccount(httpClient: makeHttpAdapter(), url: makeApiUrl('signup'));
}
