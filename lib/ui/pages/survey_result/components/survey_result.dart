import 'package:flutter/material.dart';

import '../survey_result_viewmodel.dart';

import 'components.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;

  const SurveyResult(
    this.viewModel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(question: viewModel.question);
        }

        return SurveyAnswer(viewModel: viewModel.answers[index - 1]);
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
