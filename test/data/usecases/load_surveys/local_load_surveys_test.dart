import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'package:ForDev/domain/entities/entities.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/data/models/models.dart';

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({@required this.fetchCacheStorage});

  Future<List<SurveyEntity>> load() async {
    final data = await fetchCacheStorage.fetch('surveys');

    try {
      if (data?.isEmpty != false) {
        throw Exception();
      }

      return data.map<SurveyEntity>((json) => LocalSurveyModel.fromJson(json).toEntity()).toList();
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}

abstract class FetchCacheStorage {
  Future<dynamic> fetch(String key);
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

void main() {
  LocalLoadSurveys sut;
  FetchCacheStorageSpy fetchCacheStorage;
  List<Map> data;

  List<Map> mockValidData() => [
        {'id': faker.guid.guid(), 'question': faker.randomGenerator.string(10), 'date': '2020-07-20T00:00:00Z', 'didAnswer': 'false'},
        {'id': faker.guid.guid(), 'question': faker.randomGenerator.string(10), 'date': '2019-02-02T00:00:00Z', 'didAnswer': 'true'}
      ];

  void mockFetch(List<Map> list) {
    data = list;
    when(fetchCacheStorage.fetch(any)).thenAnswer((_) async => list);
  }

  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);

    mockFetch(mockValidData());
  });

  test('Should call FetchCacheStorage with correct key', () async {
    sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });

  test('Should return a list of surveys on success', () async {
    final surveys = await sut.load();

    expect(surveys, [
      SurveyEntity(id: data[0]['id'], question: data[0]['question'], dateTime: DateTime.utc(2020, 7, 20), didAnswer: false),
      SurveyEntity(id: data[1]['id'], question: data[1]['question'], dateTime: DateTime.utc(2019, 2, 2), didAnswer: true),
    ]);
  });

  test('Should throw UnexpectedError if cache is empty', () async {
    mockFetch([]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is invalid', () async {
    mockFetch([
      {'id': faker.guid.guid(), 'question': faker.randomGenerator.string(10), 'date': 'invalid date', 'didAnswer': 'false'}
    ]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if cache is incomplete', () async {
    mockFetch([
      {'date': '2020-07-20T00:00:00Z', 'didAnswer': 'false'}
    ]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
