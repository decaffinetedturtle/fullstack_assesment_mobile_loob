import '../models/application_model.dart';
import '../../../../shared_widgets/status_card.dart';

class MockApplicationService {
  static final List<JobApplication> _mockApplications = [
    JobApplication(
      id: 'APP-2024-001',
      fullName: 'Ahmad Rahman',
      phoneNumber: '+60123456789',
      email: 'ahmad.rahman@email.com',
      position: 'Barista',
      workExperience:
          'I have 2 years of experience working as a barista at Starbucks. I am skilled in making various coffee drinks, handling cash transactions, and providing excellent customer service. I am passionate about coffee and enjoy creating the perfect cup for customers.',
      status: ApplicationStatus.screening,
      createdAt: DateTime(2024, 1, 15, 10, 30),
      updatedAt: DateTime(2024, 1, 18, 14, 45),
      notes:
          'Strong customer service background. Available for immediate start.',
    ),
    JobApplication(
      id: 'APP-2024-002',
      fullName: 'Siti Nurhaliza',
      phoneNumber: '+60198765432',
      email: null,
      position: 'Store Manager',
      workExperience:
          'I have 5 years of retail management experience, including 3 years as assistant manager at a busy shopping mall outlet. I have experience in staff training, inventory management, sales targets, and customer relationship management.',
      status: ApplicationStatus.interview,
      createdAt: DateTime(2024, 1, 12, 9, 15),
      updatedAt: DateTime(2024, 1, 20, 11, 20),
      notes: 'Interview scheduled for next week. Strong leadership skills.',
    ),
    JobApplication(
      id: 'APP-2024-003',
      fullName: 'Muhammad Ali',
      phoneNumber: '+60134567890',
      email: 'muhammad.ali@email.com',
      position: 'Marketing Assistant',
      workExperience:
          'Fresh graduate with degree in Marketing. Completed internship at a digital marketing agency where I learned social media management, content creation, and basic analytics. I am creative, detail-oriented, and eager to learn.',
      status: ApplicationStatus.applied,
      createdAt: DateTime(2024, 1, 22, 16, 45),
      updatedAt: DateTime(2024, 1, 22, 16, 45),
      notes: 'Recent graduate. Good potential for growth.',
    ),
  ];

  static Future<JobApplication?> getApplicationByPhone(
    String phoneNumber,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return _mockApplications.firstWhere(
        (app) => app.phoneNumber == phoneNumber,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<JobApplication?> getApplicationById(
    String applicationId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _mockApplications.firstWhere((app) => app.id == applicationId);
    } catch (e) {
      return null;
    }
  }

  static Future<List<JobApplication>> getAllApplications() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_mockApplications);
  }

  static Future<List<JobApplication>> searchApplications(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (query.isEmpty) return List.from(_mockApplications);

    final normalizedQuery = query.toLowerCase();
    return _mockApplications.where((app) {
      final name = app.fullName.toLowerCase();
      final phone = app.phoneNumber.toLowerCase();
      return name.contains(normalizedQuery) || phone.contains(normalizedQuery);
    }).toList();
  }
}
