import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared_widgets/loading_spinner.dart';
import '../widgets/application_form_widget.dart';
import '../../providers/application_provider.dart';

class ApplicationPage extends ConsumerWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissionState = ref.watch(applicationSubmissionProvider);

    ref.listen(applicationSubmissionProvider, (previous, next) {
      next.when(
        data: (application) {
          if (application != null) {
            context.pushNamed('confirmation', extra: application);
          }
        },
        loading: () {},
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Job Application')),
      body: LoadingOverlay(
        isLoading: submissionState.isLoading,
        loadingMessage: 'Submitting application...',
        child: const ApplicationFormWidget(),
      ),
    );
  }
}
