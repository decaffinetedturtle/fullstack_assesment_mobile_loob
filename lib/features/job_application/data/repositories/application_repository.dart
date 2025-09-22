import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/global_providers.dart';
import '../models/application_model.dart';
import '../services/application_api_service.dart';

class ApplicationRepository {
  final ApplicationApiService _apiService;

  ApplicationRepository(this._apiService);

  Future<JobApplication> submitApplication(ApplicationForm form) async {
    return await _apiService.submitApplication(form);
  }

  Future<JobApplication?> getApplicationStatus(String applicationId) async {
    return await _apiService.getApplicationStatus(applicationId);
  }

  Future<JobApplication?> getApplicationByPhone(String phoneNumber) async {
    return await _apiService.getApplicationByPhone(phoneNumber);
  }

  Future<List<JobApplication>> searchApplications(String query) async {
    return await _apiService.searchApplications(query);
  }
}

final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  final apiService = ref.watch(applicationApiServiceProvider);
  return ApplicationRepository(apiService);
});
