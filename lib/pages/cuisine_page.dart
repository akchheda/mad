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
            // Desktop view: Custom card with larger image
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
                  // Recipes grid with custom card for desktop
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 columns for desktop
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8, // Adjust the aspect ratio
                      ),
                      itemCount: cuisineRecipes.length,
                      itemBuilder: (context, index) {
                        return _buildDesktopRecipeCard(context, cuisineRecipes[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Mobile view: ListView with image on the left, title on the right, description below title
            return Column(
              children: [
                // Display the cuisine image at the top.
                _displayImage(cuisineImage),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cuisineRecipes.length,
                    itemBuilder: (context, index) {
                      return _buildMobileRecipeCard(context, cuisineRecipes[index]);
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

  Widget _buildDesktopRecipeCard(BuildContext context, Map<String, String> recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Larger image for desktop
            _displayImage(recipe['image']!, width: double.infinity, height: 250),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                recipe['title']!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                recipe['description']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileRecipeCard(BuildContext context, Map<String, String> recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Recipe image on the left
              _displayImage(recipe['image']!, width: 80, height: 80),
              const SizedBox(width: 12),
              // Recipe text content on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      recipe['description']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayImage(String imagePath, {double width = double.infinity, double height = 150}) {
    if (imagePath.startsWith('assets/')) {
      // Handle asset images
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      // Handle network images (URLs)
      return Image.network(
        imagePath,
        width: width,
        height: height,
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
          width: width,
          height: height,
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
      height: 80,
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
