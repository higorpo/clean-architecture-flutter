import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSurveys({required this.url, required this.httpClient});

  Future<List<SurveyEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response.map<SurveyEntity>((map) => RemoteSurveyModel.fromJson(map).toEntity()).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden ? DomainError.accessDenied : DomainError.unexpected;
    }
  }
}
