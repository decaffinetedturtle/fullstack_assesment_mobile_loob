import '../../../../core/api/base_api_service.dart';
import '../../../../config/api_config.dart';
import '../models/application_model.dart';

class ApplicationApiService extends BaseApiService {
  Future<JobApplication> submitApplication(ApplicationForm form) async {
    final response = await post(
      endpoint: ApiConfig.applicationsEndpoint,
      body: form.toJson(),
    );

    return JobApplication.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<JobApplication?> getApplicationStatus(String applicationId) async {
    try {
      final response = await get(
        endpoint: '${ApiConfig.applicationStatusEndpoint}/$applicationId',
      );

      return JobApplication.fromJson(response['data'] as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  Future<JobApplication?> getApplicationByPhone(String phoneNumber) async {
    try {
      final response = await get(
        endpoint: ApiConfig.applicationSearchEndpoint,
        queryParameters: {'phone': phoneNumber},
      );

      if (response['data'] != null) {
        return JobApplication.fromJson(
          response['data'] as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<JobApplication>> searchApplications(String query) async {
    try {
      final response = await get(
        endpoint: ApiConfig.applicationsEndpoint,
        queryParameters: {'search': query},
      );

      if (response['data'] is List) {
        return (response['data'] as List)
            .map(
              (json) => JobApplication.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
