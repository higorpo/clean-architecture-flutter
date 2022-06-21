import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SurveyAnswerEntity extends Equatable {
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

  @override
  List<Object> get props => [image, answer, isCurrentAnswered, percent];
}
