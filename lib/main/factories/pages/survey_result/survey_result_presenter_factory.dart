import '../../../../presentation/presenters/presenters.dart';
import '../../factories.dart';

GetxSurveyResultPresenter makeGetxSurveyResultPresenter(String surveyId) => GetxSurveyResultPresenter(
      loadSurveyResult: makeRemoteLoadSurveyResult(surveyId),
      surveyId: surveyId,
    );
