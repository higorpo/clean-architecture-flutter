import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

Widget makeSurveyResultPage() => SurveyResultPage(presenter: makeGetxSurveyResultPresenter(Get.parameters['survey_id'] ?? ''));
