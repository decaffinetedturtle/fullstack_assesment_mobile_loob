import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/base_api_service.dart';
import '../../features/job_application/data/services/application_api_service.dart';

final baseApiServiceProvider = Provider<BaseApiService>((ref) {
  return BaseApiService();
});

final applicationApiServiceProvider = Provider<ApplicationApiService>((ref) {
  return ApplicationApiService();
});
