import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared_widgets/custom_button.dart';
import '../../providers/application_provider.dart';

class ApplicationFormWidget extends ConsumerStatefulWidget {
  const ApplicationFormWidget({super.key});

  @override
  ConsumerState<ApplicationFormWidget> createState() =>
      _ApplicationFormWidgetState();
}

class _ApplicationFormWidgetState extends ConsumerState<ApplicationFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasValidationErrors = false;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(applicationFormProvider);
    final formNotifier = ref.read(applicationFormProvider.notifier);
    final submissionState = ref.watch(applicationSubmissionProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Join Our Team',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Apply for a position at Tealive',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildFormField(
              label: 'Full Name *',
              value: form.fullName,
              onChanged: formNotifier.updateFullName,
              validator: (value) =>
                  Validators.validateRequired(value, 'Full Name'),
              isRequired: true,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Phone Number *',
              value: form.phoneNumber,
              onChanged: formNotifier.updatePhoneNumber,
              validator: Validators.validatePhoneNumber,
              keyboardType: TextInputType.phone,
              isRequired: true,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Email Address',
              value: form.email ?? '',
              onChanged: formNotifier.updateEmail,
              validator: Validators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Optional - some positions may require email',
              isRequired: false,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Position Applied For *',
              value: form.position,
              onChanged: formNotifier.updatePosition,
              validator: (value) =>
                  Validators.validateRequired(value, 'Position'),
              hintText: 'e.g., Barista, Store Manager, Marketing Assistant',
              isRequired: true,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              label: 'Work Experience *',
              value: form.workExperience,
              onChanged: formNotifier.updateWorkExperience,
              validator: (value) =>
                  Validators.validateMinLength(value, 10, 'Work Experience'),
              maxLines: 4,
              hintText: 'Please describe your relevant work experience...',
              isRequired: true,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Submit Application',
              onPressed: submissionState.isLoading
                  ? null
                  : () => _submitApplication(),
              isLoading: submissionState.isLoading,
              icon: Icons.send,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    String? hintText,
    int maxLines = 1,
    required bool isRequired,
  }) {
    final hasError = _hasValidationErrors && isRequired && value.trim().isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: hasError ? Colors.red : null,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          onChanged: (newValue) {
            onChanged(newValue);
            if (_hasValidationErrors) {
              setState(() {
                _hasValidationErrors = false;
              });
            }
          },
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.grey,
                width: hasError ? 2.0 : 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.grey,
                width: hasError ? 2.0 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: hasError ? Colors.red : Theme.of(context).primaryColor,
                width: hasError ? 2.0 : 2.0,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _submitApplication() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      setState(() {
        _hasValidationErrors = true;
      });
      return;
    }

    final form = ref.read(applicationFormProvider);
    final notifier = ref.read(applicationSubmissionProvider.notifier);
    await notifier.submitApplication(form);
  }
}
