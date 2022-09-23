import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';

import '../helpers/helpers.dart';

class GetxSurveyResultPresenter extends GetxController implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;

  final _isLoading = true.obs;
  final _surveyResult = Rx<SurveyResultViewModel?>(null);
  final _isSessionExpired = Rx<bool?>(null);

  Stream<bool> get isLoadingStream => _isLoading.stream;
  Stream<SurveyResultViewModel?> get surveyResultStream => _surveyResult.stream;
  Stream<bool?> get isSessionExpiredStream => _isSessionExpired.stream;

  GetxSurveyResultPresenter({required this.loadSurveyResult, required this.saveSurveyResult, required this.surveyId});

  Future<void> loadData() async {
    _showResultOnAction(() => loadSurveyResult.loadBySurvey(surveyId: surveyId));
  }

  Future<void> save({required String answer}) async {
    _showResultOnAction(() => saveSurveyResult.save(answer: answer));
  }

  Future<void> _showResultOnAction(Future<SurveyResultEntity> action()) async {
    _isLoading.value = true;

    try {
      final surveyResult = await action();

      _surveyResult.value = surveyResult.toViewModel();
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
}
