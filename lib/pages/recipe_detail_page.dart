import 'package:flutter/material.dart';

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
    required this.steps, // ✅ New parameter for steps
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(image, width: double.infinity, height: 250, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),

              // Recipe Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
              const SizedBox(height: 20),

              // Recipe Description
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, height: 1.5),
              ),
              const SizedBox(height: 20),

              // Recipe Steps
              const Text(
                "Steps to Make:",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              Text(
                steps,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
