import 'package:meta/meta.dart';

class SurveyAnswerViewModel {
  final String image;
  final String answer;
  final bool isCurrentAnswered;
  final String percent;

  SurveyAnswerViewModel({
    this.image,
    @required this.answer,
    @required this.isCurrentAnswered,
    @required this.percent,
  });
}
