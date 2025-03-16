// cuisine_page.dart
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
      body: Column(
        children: [
          // Display the cuisine image at the top.
          _displayImage(cuisineImage),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cuisineRecipes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(
                            title: cuisineRecipes[index]['title']!,
                            description: cuisineRecipes[index]['description']!,
                            image: cuisineRecipes[index]['image']!,
                            steps: cuisineRecipes[index]['steps']!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        _displayImage(cuisineRecipes[index]['image']!),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            cuisineRecipes[index]['title']!,
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
                            cuisineRecipes[index]['description']!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      // Handle asset images
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      // Handle network images (URLs)
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 200,
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
          height: 200,
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
      height: 200,
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