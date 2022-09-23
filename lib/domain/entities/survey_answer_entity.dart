import 'package:equatable/equatable.dart';

class SurveyAnswerEntity extends Equatable {
  final String? image;
  final String answer;
  final bool isCurrentAnswered;
  final int percent;

  SurveyAnswerEntity({
    this.image,
    required this.answer,
    required this.isCurrentAnswered,
    required this.percent,
  });

  @override
  List get props => [image, answer, isCurrentAnswered, percent];
}
