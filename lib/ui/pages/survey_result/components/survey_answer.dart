import 'package:flutter/material.dart';

import '../survey_result.dart';
import 'components.dart';

class SurveyAnswer extends StatelessWidget {
  final SurveyAnswerViewModel viewModel;

  const SurveyAnswer({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (viewModel.image != null)
                Image.network(
                  viewModel.image,
                  width: 40,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    viewModel.answer,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Text(
                viewModel.percent,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              viewModel.isCurrentAnswered ? ActiveIcon() : DisabledIcon(),
            ],
          ),
        ),
        Divider(height: 1),
      ],
    );
  }
}
