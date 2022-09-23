import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fordev/data/cache/cache.dart';
import 'package:fordev/data/http/http.dart';

import 'package:fordev/main/decorators/decorators.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

class DeleteSecureCacheStorageSpy extends Mock implements DeleteSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late AuthorizeHttpClientDecorator sut;
  late FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  late DeleteSecureCacheStorageSpy deleteSecureCacheStorage;
  late HttpClient httpClient;
  late String url;
  late String method;
  late Map body;
  late String token;
  late String httpResponse;

  When mockTokenCall() => when(() => fetchSecureCacheStorage.fetch('token'));

  void mockToken() {
    token = faker.guid.guid();
    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() {
    mockTokenCall().thenThrow(Exception);
  }

  When mockHttpResponseCall() => when(() => httpClient.request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ));

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);

    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    deleteSecureCacheStorage = DeleteSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
      decoratee: httpClient,
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
    );

    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};

    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(() => fetchSecureCacheStorage.fetch('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);
    verify(() => httpClient.request(url: url, method: method, body: body, headers: {'x-access-token': token})).called(1);

    await sut.request(url: url, method: method, body: body, headers: {'any_header': 'any_value'});
    verify(() => httpClient.request(url: url, method: method, body: body, headers: {'any_header': 'any_value', 'x-access-token': token})).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws', () async {
    mockTokenError();

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(() => deleteSecureCacheStorage.delete('token')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if request throws ForbiddenError', () async {
    mockHttpResponseError(HttpError.forbidden);

    final future = sut.request(url: url, method: method, body: body);
    await untilCalled(() => deleteSecureCacheStorage.delete('token'));

    expect(future, throwsA(HttpError.forbidden));
    verify(() => deleteSecureCacheStorage.delete('token')).called(1);
  });
}
