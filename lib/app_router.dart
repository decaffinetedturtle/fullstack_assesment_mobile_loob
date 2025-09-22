import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/job_application/presentation/pages/application_page.dart';
import 'features/job_application/presentation/pages/status_page.dart';
import 'features/job_application/presentation/pages/confirmation_page.dart';
import 'features/job_application/presentation/widgets/status_test_widget.dart';
import 'features/job_application/data/models/application_model.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/application',
      name: 'application',
      builder: (context, state) => const ApplicationPage(),
    ),
    GoRoute(
      path: '/status',
      name: 'status',
      builder: (context, state) => const StatusPage(),
    ),
    GoRoute(
      path: '/confirmation',
      name: 'confirmation',
      builder: (context, state) {
        final application = state.extra as JobApplication;
        return ConfirmationPage(application: application);
      },
    ),
    GoRoute(
      path: '/status-test',
      name: 'status-test',
      builder: (context, state) => const StatusTestWidget(),
    ),
  ],
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6B46C1), Color(0xFF8B5CF6)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.local_drink,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tealive Careers',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Join Malaysia\'s favorite lifestyle tea brand',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildActionCard(
                  context,
                  title: 'Apply for a Position',
                  description: 'Submit your job application',
                  icon: Icons.work,
                  onTap: () => context.pushNamed('application'),
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  title: 'Check Application Status',
                  description: 'Track your application progress',
                  icon: Icons.search,
                  onTap: () => context.pushNamed('status'),
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  title: 'Status Test (Mock/API)',
                  description: 'Test application status with mock data',
                  icon: Icons.science,
                  onTap: () => context.pushNamed('status-test'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B46C1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF6B46C1), size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
