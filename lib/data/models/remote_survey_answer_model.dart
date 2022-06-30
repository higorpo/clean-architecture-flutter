import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteSurveyAnswerModel {
  final String image;
  final String answer;
  final bool isCurrentAccountAnswered;
  final int percent;

  RemoteSurveyAnswerModel({this.image, @required this.answer, @required this.isCurrentAccountAnswered, @required this.percent});

  factory RemoteSurveyAnswerModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['answer', 'isCurrentAccountAnswer', 'percent'])) {
      throw HttpError.invalidData;
    }

    return RemoteSurveyAnswerModel(
      image: json['image'],
      answer: json['answer'],
      isCurrentAccountAnswered: json['isCurrentAccountAnswer'],
      percent: json['percent'],
    );
  }

  SurveyAnswerEntity toEntity() => SurveyAnswerEntity(
        image: image,
        answer: answer,
        isCurrentAnswered: isCurrentAccountAnswered,
        percent: percent,
      );
}
