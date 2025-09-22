import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application_list_widget.dart';

class StatusTestWidget extends ConsumerStatefulWidget {
  const StatusTestWidget({super.key});

  @override
  ConsumerState<StatusTestWidget> createState() => _StatusTestWidgetState();
}

class _StatusTestWidgetState extends ConsumerState<StatusTestWidget> {
  bool _useMockData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Test')),
      body: ApplicationListWidget(useMockData: _useMockData),
    );
  }
}
