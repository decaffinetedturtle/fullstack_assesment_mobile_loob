import '../../../../shared_widgets/status_card.dart';

class JobApplication {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String position;
  final String workExperience;
  final ApplicationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;

  const JobApplication({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    required this.position,
    required this.workExperience,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String?,
      position: json['position'] as String,
      workExperience: json['work_experience'] as String,
      status: _parseStatus(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'position': position,
      'work_experience': workExperience,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'notes': notes,
    };
  }

  JobApplication copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? position,
    String? workExperience,
    ApplicationStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return JobApplication(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      position: position ?? this.position,
      workExperience: workExperience ?? this.workExperience,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }

  static ApplicationStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'applied':
        return ApplicationStatus.applied;
      case 'screening':
        return ApplicationStatus.screening;
      case 'interview':
        return ApplicationStatus.interview;
      case 'offer':
        return ApplicationStatus.offer;
      case 'rejected':
        return ApplicationStatus.rejected;
      default:
        return ApplicationStatus.applied;
    }
  }
}

class ApplicationForm {
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String position;
  final String workExperience;

  const ApplicationForm({
    required this.fullName,
    required this.phoneNumber,
    this.email,
    required this.position,
    required this.workExperience,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'position': position,
      'work_experience': workExperience,
    };

    if (email != null && email!.isNotEmpty) {
      json['email'] = email!;
    }

    return json;
  }

  ApplicationForm copyWith({
    String? fullName,
    String? phoneNumber,
    String? email,
    String? position,
    String? workExperience,
  }) {
    return ApplicationForm(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email,
      position: position ?? this.position,
      workExperience: workExperience ?? this.workExperience,
    );
  }
}
