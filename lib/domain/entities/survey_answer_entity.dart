import 'package:meta/meta.dart';

class SurveyAnswerEntity {
  final String image;
  final String answer;
  final bool isCurrentAnswered;
  final int percent;

  SurveyAnswerEntity({
    this.image,
    @required this.answer,
    @required this.isCurrentAnswered,
    @required this.percent,
  });
}
