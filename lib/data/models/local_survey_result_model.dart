import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';
import 'models.dart';

class LocalSurveyResultModel {
  final String id;
  final String question;
  final List<LocalSurveyAnswerModel> answers;

  LocalSurveyResultModel({@required this.id, @required this.question, @required this.answers});

  factory LocalSurveyResultModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['surveyId', 'question', 'answers'])) {
      throw Exception();
    }

    return LocalSurveyResultModel(
      id: json['surveyId'],
      question: json['question'],
      answers: json['answers'].map<LocalSurveyAnswerModel>((answerJson) => LocalSurveyAnswerModel.fromJson(answerJson)).toList(),
    );
  }

  SurveyResultEntity toEntity() => SurveyResultEntity(
        surveyId: id,
        question: question,
        answers: answers.map<SurveyAnswerEntity>((answer) => answer.toEntity()).toList(),
      );
}
