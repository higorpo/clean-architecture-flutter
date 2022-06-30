import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerViewModel extends Equatable {
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

  List get props => [image, answer, isCurrentAnswered, percent];
}
