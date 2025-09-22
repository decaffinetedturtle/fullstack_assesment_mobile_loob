import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared_widgets/custom_button.dart';
import '../../../../shared_widgets/status_card.dart';
import '../../data/models/application_model.dart';
import '../../providers/application_provider.dart';

class ConfirmationPage extends ConsumerWidget {
  final JobApplication application;

  const ConfirmationPage({super.key, required this.application});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Submitted')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        size: 64,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Application Submitted Successfully!',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Thank you for your interest in joining Tealive. We will review your application and get back to you soon.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Application Details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Application ID', application.id),
                    _buildDetailRow('Name', application.fullName),
                    _buildDetailRow('Phone', application.phoneNumber),
                    if (application.email != null)
                      _buildDetailRow('Email', application.email!),
                    _buildDetailRow('Position', application.position),
                    _buildDetailRow(
                      'Applied Date',
                      _formatDate(application.createdAt),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            StatusCard(
              status: application.status,
              updatedAt: application.updatedAt,
            ),
            const SizedBox(height: 32),
            if (application.email != null)
              Card(
                color: Colors.blue.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.email, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'A confirmation email has been sent to ${application.email}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Check Status Later',
              onPressed: () {
                ref.read(applicationSubmissionProvider.notifier).reset();
                context.pushNamed('status');
              },
              isSecondary: true,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Submit Another Application',
              onPressed: () {
                ref.read(applicationSubmissionProvider.notifier).reset();
                context.pushNamed('application');
              },
              icon: Icons.add,
            ),
          ],
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
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
