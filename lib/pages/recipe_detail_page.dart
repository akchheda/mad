import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final String steps;

  const RecipeDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.steps,
  });

  // Function to upload recipe data to Firebase
  void uploadData(BuildContext context) {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref("recipes");

    dbRef.push().set({
      "title": title,
      "description": description,
      "image": image,
      "steps": steps,
      "uploadedAt": DateTime.now().toIso8601String(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recipe Uploaded Successfully!")),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Uploading: $error")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop view: Two-column layout
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column: Image
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _displayImage(image, constraints),
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Right column: Details
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Steps to Make:",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildStepsGrid(steps, constraints),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => uploadData(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Upload Recipe",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Mobile view: Single-column layout
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: _displayImage(image, constraints),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Steps to Make:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      steps,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => uploadData(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Upload Recipe",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _displayImage(String imagePath, BoxConstraints constraints) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: constraints.maxWidth > 600 ? 400 : 250,
        fit: BoxFit.cover,
      );
    } else {
      try {
        Uint8List decodedBytes = base64Decode(imagePath);
        return Image.memory(
          decodedBytes,
          width: double.infinity,
          height: constraints.maxWidth > 600 ? 400 : 250,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return SizedBox(
          height: constraints.maxWidth > 600 ? 400 : 250,
          child: const Center(child: Text('Invalid Image Data')),
        );
      }
    }
  }

  Widget _buildStepsGrid(String steps, BoxConstraints constraints) {
    final List<String> stepList = steps.split('\n');
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth > 600 ? 3 : 1, // 2 columns for desktop
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3, // Adjust the aspect ratio
      ),
      itemCount: stepList.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              stepList[index],
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}