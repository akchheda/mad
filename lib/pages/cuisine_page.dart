import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'dart:convert';
import 'dart:typed_data';

class CuisinePage extends StatelessWidget {
  final String cuisineName;
  final String cuisineImage;
  final List<Map<String, String>> recipes;

  const CuisinePage({
    super.key,
    required this.cuisineName,
    required this.cuisineImage,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    // Filter recipes based on the selected cuisine.
    final List<Map<String, String>> cuisineRecipes = recipes
        .where((recipe) => recipe['cuisine'] == cuisineName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(cuisineName),
        backgroundColor: Colors.deepPurple,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop view: Grid layout with 4 columns
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cuisine name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      cuisineName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Recipes grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // 4 columns for desktop
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8, // Adjust the aspect ratio
                      ),
                      itemCount: cuisineRecipes.length,
                      itemBuilder: (context, index) {
                        return _buildRecipeCard(context, cuisineRecipes[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Mobile view: Single-column layout
            return Column(
              children: [
                // Display the cuisine image at the top.
                _displayImage(cuisineImage),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cuisineRecipes.length,
                    itemBuilder: (context, index) {
                      return _buildRecipeCard(context, cuisineRecipes[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Map<String, String> recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Navigate to RecipeDetailPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(
                title: recipe['title']!,
                description: recipe['description']!,
                image: recipe['image']!,
                steps: recipe['steps']!,
              ),
            ),
          );
        },
        child: Column(
          children: [
            _displayImage(recipe['image']!),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                recipe['title']!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                recipe['description']!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      // Handle asset images
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      // Handle network images (URLs)
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      // Handle Base64-encoded images
      try {
        Uint8List decodedBytes = base64Decode(imagePath);
        return Image.memory(
          decodedBytes,
          width: double.infinity,
          height: 150,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      } catch (e) {
        // Handle invalid image data
        return _buildErrorWidget();
      }
    }
  }

  Widget _buildErrorWidget() {
    return SizedBox(
      height: 150,
      child: Center(
        child: Text(
          'Invalid Image Data',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}