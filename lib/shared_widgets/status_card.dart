import 'package:flutter/material.dart';

enum ApplicationStatus {
  applied('Applied', Icons.description, Colors.blue),
  screening('Screening', Icons.search, Colors.orange),
  interview('Interview', Icons.people, Colors.purple),
  offer('Offer', Icons.card_giftcard, Colors.green),
  rejected('Rejected', Icons.cancel, Colors.red);

  const ApplicationStatus(this.displayName, this.icon, this.color);

  final String displayName;
  final IconData icon;
  final Color color;
}

class StatusCard extends StatelessWidget {
  final ApplicationStatus status;
  final DateTime? updatedAt;
  final String? notes;

  const StatusCard({
    super.key,
    required this.status,
    this.updatedAt,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(status.icon, color: status.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.displayName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: status.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (updatedAt != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(updatedAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (notes != null) ...[
                    const SizedBox(height: 4),
                    Text(notes!, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}
