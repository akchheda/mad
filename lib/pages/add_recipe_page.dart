import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _stepsController = TextEditingController(); // ✅ New TextField for steps

  void _saveRecipe() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final image = _imageController.text;
    final steps = _stepsController.text; // ✅ Get steps input

    if (title.isNotEmpty && description.isNotEmpty && image.isNotEmpty && steps.isNotEmpty) {
      final newRecipe = {
        'title': title,
        'description': description,
        'image': image,
        'steps': steps, // ✅ Save the steps
      };

      Navigator.pop(context, newRecipe);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextField(_titleController, 'Recipe Title'),
            const SizedBox(height: 20),
            _buildTextField(_descriptionController, 'Recipe Description'),
            const SizedBox(height: 20),
            _buildTextField(_imageController, 'Image Path (e.g., "assets/pasta.jpg")'),
            const SizedBox(height: 20),
            _buildTextField(_stepsController, 'Steps to Make', maxLines: 5), // ✅ Steps input
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveRecipe, child: const Text('Save Recipe')),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()));
  }
}
