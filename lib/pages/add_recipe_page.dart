import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb check
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert'; // For Base64 encoding

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stepsController = TextEditingController();
  final _cuisineController = TextEditingController();

  Uint8List? _imageBytes;
  String? _base64Image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _base64Image = base64Encode(bytes); // Convert image to Base64 string
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _saveRecipe() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final steps = _stepsController.text.trim();
    final cuisine = _cuisineController.text.trim();

    if (title.isEmpty || description.isEmpty || steps.isEmpty || cuisine.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (_base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      final newRecipe = {
        'title': title,
        'description': description,
        'image': _base64Image, // Store Base64 string directly
        'steps': steps,
        'cuisine': cuisine,
      };

      await _firestore.collection('recipes').add(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added successfully!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add recipe: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTextField(_titleController, 'Recipe Title'),
              const SizedBox(height: 16),
              _buildTextField(_descriptionController, 'Recipe Description'),
              const SizedBox(height: 16),
              _buildTextField(_stepsController, 'Steps to Make', maxLines: 5),
              const SizedBox(height: 16),
              _buildTextField(_cuisineController, 'Cuisine (e.g., Italian, Indian)'),
              const SizedBox(height: 16),
              _imageBytes == null
                  ? ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image from Gallery'),
                    )
                  : Column(
                      children: [
                        Image.memory(_imageBytes!, height: 150, width: double.infinity, fit: BoxFit.cover),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _pickImage,
                          child: const Text('Change Image'),
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}