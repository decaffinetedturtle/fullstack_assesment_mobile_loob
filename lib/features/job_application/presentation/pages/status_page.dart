import 'package:flutter/material.dart';
import '../widgets/status_check_widget.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const StatusCheckWidget());
  }
}
