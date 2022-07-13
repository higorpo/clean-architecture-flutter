import 'package:flutter/material.dart';

import '../survey_result_viewmodel.dart';

import 'components.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;
  final void Function({@required String answer}) onSave;

  const SurveyResult({
    Key key,
    @required this.viewModel,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(question: viewModel.question);
        }

        return GestureDetector(
          onTap: () => onSave(answer: viewModel.answers[index - 1].answer),
          child: SurveyAnswer(viewModel: viewModel.answers[index - 1]),
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
