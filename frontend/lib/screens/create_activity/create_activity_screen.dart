import 'package:flutter/material.dart';
import 'package:frontend/common_widgets/solid_button.dart';
import 'package:frontend/routing/app_routing.dart';
import 'package:frontend/theme/colors.dart';
import 'package:go_router/go_router.dart';

class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key});

  @override
  State<CreateActivityScreen> createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final TextEditingController _whatController = TextEditingController();
  final TextEditingController _whichController = TextEditingController();
  final TextEditingController _whenController = TextEditingController();
  final TextEditingController _whoController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    _whatController.dispose();
    _whichController.dispose();
    _whenController.dispose();
    _whoController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle valid form submission
      print('What: ${_whatController.text}');
      print('Which: ${_whichController.text}');
      print('When: ${_whenController.text}');
      print('Who: ${_whoController.text}');

      // Navigate or perform next action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('All inputs are valid! Moving to the next page.')),
      );
      context.goNamed(AppRouting.selectActivity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TypeForm Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _whatController,
                label: 'What?',
                hintText: 'Enter what',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _whichController,
                label: 'Which?',
                hintText: 'Enter which',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _whenController,
                label: 'When?',
                hintText: 'Enter when',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _whoController,
                label: 'Who?',
                hintText: 'Enter who',
              ),
              SizedBox(height: 32),
              SolidButton(
                onPressed: _goNext,
                backgroundColor: AppColors.primaryColor,
                text: "Find persons to meet with",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value for $label';
        }
        return null;
      },
    );
  }
}
