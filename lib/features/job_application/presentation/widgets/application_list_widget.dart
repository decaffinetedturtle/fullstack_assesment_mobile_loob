import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/application_model.dart';
import '../../providers/application_provider.dart';
import '../../../../core/utils/fuzzy_search.dart';
import '../../../../shared_widgets/status_card.dart';
import 'application_details_modal.dart';

class ApplicationListWidget extends ConsumerStatefulWidget {
  final bool useMockData;

  const ApplicationListWidget({super.key, this.useMockData = false});

  @override
  ConsumerState<ApplicationListWidget> createState() =>
      _ApplicationListWidgetState();
}

class _ApplicationListWidgetState extends ConsumerState<ApplicationListWidget> {
  final _searchController = TextEditingController();
  List<JobApplication> _allApplications = [];
  List<JobApplication> _filteredApplications = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadApplications();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadApplications() async {
    final searchNotifier = ref.read(applicationSearchProvider.notifier);
    await searchNotifier.searchApplications(
      '',
      useMockData: widget.useMockData,
    );
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _filteredApplications = _allApplications;
      });
    } else {
      final filtered = FuzzySearch.search(
        _allApplications,
        query,
        (app) => '${app.fullName} ${app.phoneNumber}',
      );
      setState(() {
        _filteredApplications = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(applicationSearchProvider);

    searchState.when(
      data: (applications) {
        if (_allApplications != applications) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _allApplications = applications;
              _filteredApplications = _searchController.text.isEmpty
                  ? applications
                  : FuzzySearch.search(
                      applications,
                      _searchController.text,
                      (app) => '${app.fullName} ${app.phoneNumber}',
                    );
            });
          });
        }
      },
      loading: () {},
      error: (error, stack) {},
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by name or phone number...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: searchState.when(
            data: (applications) => _filteredApplications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? 'No applications found'
                              : 'No applications match your search',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (_searchController.text.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Try searching with different keywords',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredApplications.length,
                    itemBuilder: (context, index) {
                      final application = _filteredApplications[index];
                      return _ApplicationListItem(
                        application: application,
                        isMockData: widget.useMockData,
                      );
                    },
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading applications',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: TextStyle(color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadApplications,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ApplicationListItem extends StatelessWidget {
  final JobApplication application;
  final bool isMockData;

  const _ApplicationListItem({
    required this.application,
    required this.isMockData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(application.status),
          child: Text(
            application.fullName.isNotEmpty
                ? application.fullName[0].toUpperCase()
                : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          application.fullName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(application.phoneNumber),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(
                  application.status,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getStatusColor(
                    application.status,
                  ).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                _getStatusText(application.status),
                style: TextStyle(
                  color: _getStatusColor(application.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          ApplicationDetailsModal.show(
            context,
            application: application,
            isMockData: isMockData,
          );
        },
      ),
    );
  }

  Color _getStatusColor(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.applied:
        return Colors.blue;
      case ApplicationStatus.screening:
        return Colors.orange;
      case ApplicationStatus.interview:
        return Colors.purple;
      case ApplicationStatus.offer:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
    }
  }

  String _getStatusText(ApplicationStatus status) {
    switch (status) {
      case ApplicationStatus.applied:
        return 'Applied';
      case ApplicationStatus.screening:
        return 'Screening';
      case ApplicationStatus.interview:
        return 'Interview';
      case ApplicationStatus.offer:
        return 'Offer';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }
}
