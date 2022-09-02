import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

GetxSurveyResultPresenter makeGetxSurveyResultPresenter(String surveyId) => GetxSurveyResultPresenter(
      loadSurveyResult: makeRemoteLoadSurveyResultWithLocalFallback(surveyId),
      saveSurveyResult: makeRemoteSaveSurveyResult(surveyId),
      surveyId: surveyId,
    );
