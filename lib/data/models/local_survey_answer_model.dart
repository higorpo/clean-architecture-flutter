import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

class LocalSurveyAnswerModel {
  final String image;
  final String answer;
  final bool isCurrentAnswer;
  final int percent;

  LocalSurveyAnswerModel({this.image, @required this.answer, @required this.isCurrentAnswer, @required this.percent});

  factory LocalSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['answer', 'isCurrentAnswer', 'percent'])) {
      throw Exception();
    }

    return LocalSurveyAnswerModel(
      image: json['image'],
      answer: json['answer'],
      isCurrentAnswer: json['isCurrentAnswer'] == 'true',
      percent: int.parse(json['percent']),
    );
  }

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
        image: image,
        answer: answer,
        isCurrentAnswered: isCurrentAnswer,
        percent: percent,
      );

  factory LocalSurveyAnswerModel.fromEntity(SurveyAnswerEntity entity) => LocalSurveyAnswerModel(
        image: entity.image,
        answer: entity.answer,
        isCurrentAnswer: entity.isCurrentAnswered,
        percent: entity.percent,
      );

  Map<String, String> toJson() => {
        'image': image,
        'answer': answer,
        'isCurrentAnswer': isCurrentAnswer.toString(),
        'percent': percent.toString(),
      };
}
