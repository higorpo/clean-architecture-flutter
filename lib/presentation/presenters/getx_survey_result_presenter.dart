import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/usecases/usecases.dart';

import 'package:ForDev/ui/helpers/helpers.dart';
import 'package:ForDev/ui/pages/pages.dart';

class GetxSurveyResultPresenter implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel>();

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel> get surveyResultStream => _surveyResult.stream;

  GetxSurveyResultPresenter({@required this.loadSurveyResult, @required this.surveyId});

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
    } on DomainError {
      _surveyResult.subject.addError(UIError.unexpected.description);
    } finally {
      _isLoading.value = false;
    }
  }
}
