import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    loadSurveys.load();
  }
}

class LoadSurveysSpy extends Mock implements LoadSurveys {}

void main() {
  GetxSurveysPresenter sut;
  LoadSurveysSpy loadSurveys;

  setUp(() {
    loadSurveys = LoadSurveysSpy();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}
