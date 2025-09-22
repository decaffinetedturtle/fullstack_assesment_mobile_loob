import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application_list_widget.dart';

class StatusCheckWidget extends ConsumerStatefulWidget {
  const StatusCheckWidget({super.key});

  @override
  ConsumerState<StatusCheckWidget> createState() => _StatusCheckWidgetState();
}

class _StatusCheckWidgetState extends ConsumerState<StatusCheckWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application Status')),
      body: ApplicationListWidget(useMockData: false),
    );
  }
}
