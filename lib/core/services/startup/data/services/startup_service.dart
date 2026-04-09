// import 'package:caesar_cipher/core/services/api_client/service/base_service.dart';
// import 'package:caesar_cipher/core/services/startup/data/apis/startup_api.dart';
// import 'package:caesar_cipher/core/services/startup/data/models/startup_model.dart';
// import 'package:dio/dio.dart';

// class StartupService extends BaseService {
//   final StartupApi _startupApi;
//   StartupService({required StartupApi startupApi, required Dio dio})
//     : _startupApi = startupApi,
//       super(dio);
//   Future<StartupModel> fetchStartupApi(Map<String, dynamic> body) async {
//     return safeRequest(
//       () => _startupApi.fetchStartup(body),
//       fromJson: StartupModel.fromJson,
//     );
//   }
// }
