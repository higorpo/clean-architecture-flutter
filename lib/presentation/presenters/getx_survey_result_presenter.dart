import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

class GetxSurveyResultPresenter extends GetxController implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel>();
  final _isSessionExpired = RxBool();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;
  Stream<bool> get isSessionExpiredStream => _isSessionExpired.stream;

  GetxSurveyResultPresenter({@required this.loadSurveyResult, @required this.saveSurveyResult, @required this.surveyId});

  Future<void> loadData() async {
    _isLoading.value = true;

    try {
      final surveyResult = await loadSurveyResult.loadBySurvey(surveyId: surveyId);

      _surveyResult.value = SurveyResultViewModel(
        surveyId: surveyResult.surveyId,
        question: surveyResult.question,
        answers: surveyResult.answers
            .map(
              (answer) => SurveyAnswerViewModel(
                image: answer.image,
                answer: answer.answer,
                isCurrentAnswered: answer.isCurrentAnswered,
                percent: '${answer.percent}%',
              ),
            )
            .toList(),
      );
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        _isSessionExpired.value = true;
      } else {
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> save({@required String answer}) async {
    _isLoading.value = true;

    final surveyResult = await saveSurveyResult.save(answer: answer);

    _surveyResult.value = SurveyResultViewModel(
      surveyId: surveyResult.surveyId,
      question: surveyResult.question,
      answers: surveyResult.answers
          .map(
            (answer) => SurveyAnswerViewModel(
              image: answer.image,
              answer: answer.answer,
              isCurrentAnswered: answer.isCurrentAnswered,
              percent: '${answer.percent}%',
            ),
          )
          .toList(),
    );

    _isLoading.value = false;
  }
}
