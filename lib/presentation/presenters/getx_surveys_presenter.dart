import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

import '../mixins/mixins.dart';

class GetxSurveysPresenter extends GetxController with LoadingManager, SessionManager implements SurveysPresenter {
  final LoadSurveys loadSurveys;

  final _surveys = Rx<List<SurveyViewModel>>();
  var _navigateTo = RxString();

  Stream<List<SurveyViewModel>> get surveysStream => _surveys.stream;
  Stream<String> get navigateToStream => _navigateTo.stream;

  GetxSurveysPresenter({@required this.loadSurveys});

  Future<void> loadData() async {
    isLoading = true;

    try {
      final surveys = await loadSurveys.load();

      _surveys.value = surveys
          .map(
            (survey) => SurveyViewModel(
              id: survey.id,
              question: survey.question,
              date: DateFormat('dd MMM yyyy').format(survey.dateTime),
              didAnswer: survey.didAnswer,
            ),
          )
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveys.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }

  void goToSurveyResult(String surveyId) {
    _navigateTo.subject.add('/survey_result/$surveyId');
  }
}
