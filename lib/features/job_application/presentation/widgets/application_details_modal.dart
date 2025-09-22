import 'package:flutter/material.dart';
import '../../data/models/application_model.dart';
import '../../../../shared_widgets/status_card.dart';

class ApplicationDetailsModal extends StatelessWidget {
  final JobApplication application;
  final bool isMockData;

  const ApplicationDetailsModal({
    super.key,
    required this.application,
    this.isMockData = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isMockData
                      ? Colors.orange.withValues(alpha: 0.1)
                      : Colors.blue.withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      isMockData ? 'Mock Data' : 'Application Details',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isMockData
                            ? Colors.orange.shade700
                            : Colors.blue.shade700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('ID', application.id),
                              _buildDetailRow('Name', application.fullName),
                              _buildDetailRow('Phone', application.phoneNumber),
                              if (application.email != null)
                                _buildDetailRow('Email', application.email!),
                              _buildDetailRow('Position', application.position),
                              _buildDetailRow(
                                'Applied Date',
                                _formatDate(application.createdAt),
                              ),
                              _buildDetailRow(
                                'Last Updated',
                                _formatDate(application.updatedAt),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Work Experience',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            application.workExperience,
                            style: const TextStyle(height: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      StatusCard(
                        status: application.status,
                        updatedAt: application.updatedAt,
                        notes: application.notes,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static void show(
    BuildContext context, {
    required JobApplication application,
    bool isMockData = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => ApplicationDetailsModal(
        application: application,
        isMockData: isMockData,
      ),
    );
  }
}
