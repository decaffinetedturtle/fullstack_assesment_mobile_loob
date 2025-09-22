import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/application_model.dart';
import '../data/repositories/application_repository.dart';
import '../data/services/mock_application_service.dart';

class ApplicationFormNotifier extends StateNotifier<ApplicationForm> {
  ApplicationFormNotifier()
    : super(
        const ApplicationForm(
          fullName: '',
          phoneNumber: '',
          email: '',
          position: '',
          workExperience: '',
        ),
      );

  void updateFullName(String value) {
    state = state.copyWith(fullName: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePosition(String value) {
    state = state.copyWith(position: value);
  }

  void updateWorkExperience(String value) {
    state = state.copyWith(workExperience: value);
  }

  void reset() {
    state = const ApplicationForm(
      fullName: '',
      phoneNumber: '',
      email: '',
      position: '',
      workExperience: '',
    );
  }
}

final applicationFormProvider =
    StateNotifierProvider.autoDispose<ApplicationFormNotifier, ApplicationForm>(
      (ref) {
        return ApplicationFormNotifier();
      },
    );

class ApplicationSubmissionNotifier
    extends StateNotifier<AsyncValue<JobApplication?>> {
  final ApplicationRepository _repository;

  ApplicationSubmissionNotifier(this._repository)
    : super(const AsyncValue.data(null));

  Future<void> submitApplication(ApplicationForm form) async {
    state = const AsyncValue.loading();

    try {
      final application = await _repository.submitApplication(form);
      state = AsyncValue.data(application);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final applicationSubmissionProvider =
    StateNotifierProvider<
      ApplicationSubmissionNotifier,
      AsyncValue<JobApplication?>
    >((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return ApplicationSubmissionNotifier(repository);
    });

class ApplicationStatusNotifier
    extends StateNotifier<AsyncValue<JobApplication?>> {
  final ApplicationRepository _repository;

  ApplicationStatusNotifier(this._repository)
    : super(const AsyncValue.data(null));

  Future<void> checkApplicationStatus(String phoneNumber) async {
    state = const AsyncValue.loading();

    try {
      final application = await _repository.getApplicationByPhone(phoneNumber);
      state = AsyncValue.data(application);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshApplication(String applicationId) async {
    try {
      final application = await _repository.getApplicationStatus(applicationId);
      if (application != null) {
        state = AsyncValue.data(application);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final applicationStatusProvider =
    StateNotifierProvider<
      ApplicationStatusNotifier,
      AsyncValue<JobApplication?>
    >((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return ApplicationStatusNotifier(repository);
    });

class ApplicationSearchNotifier
    extends StateNotifier<AsyncValue<List<JobApplication>>> {
  final ApplicationRepository _repository;

  ApplicationSearchNotifier(this._repository)
    : super(const AsyncValue.data([]));

  Future<void> searchApplications(
    String query, {
    bool useMockData = false,
  }) async {
    state = const AsyncValue.loading();

    try {
      List<JobApplication> applications;

      if (useMockData) {
        applications = await MockApplicationService.searchApplications(query);
      } else {
        applications = await _repository.searchApplications(query);
      }

      state = AsyncValue.data(applications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data([]);
  }
}

final applicationSearchProvider =
    StateNotifierProvider<
      ApplicationSearchNotifier,
      AsyncValue<List<JobApplication>>
    >((ref) {
      final repository = ref.watch(applicationRepositoryProvider);
      return ApplicationSearchNotifier(repository);
    });
