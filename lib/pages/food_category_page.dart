import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_detail_page.dart';
import 'dart:convert';
import 'dart:typed_data';

class FoodCategoryPage extends StatefulWidget {
  final String categoryName;
  final String categoryImage;

  const FoodCategoryPage({
    super.key,
    required this.categoryName,
    required this.categoryImage,
  });

  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  List<Map<String, dynamic>> categoryRecipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipesForCategory();
  }

  Future<void> _fetchRecipesForCategory() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('recipes').get();

    setState(() {
      categoryRecipes = snapshot.docs
          .map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            // Check if the recipe belongs to this category
            List<dynamic> categories = data['categories'] ?? [];
            if (categories.contains(widget.categoryName)) {
              return {
                'title': data['title'] as String,
                'description': data['description'] as String,
                'image': data['image'] as String,
                'steps': data['steps'] as String,
              };
            }
            return null;
          })
          .where((recipe) => recipe != null)
          .cast<Map<String, dynamic>>()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: Column(
        children: [
          _displayCategoryImage(widget.categoryImage),
          const SizedBox(height: 10),
          Expanded(
            child: categoryRecipes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: categoryRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = categoryRecipes[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: _displayRecipeImage(recipe['image']),
                          title: Text(recipe['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(recipe['description'],
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage(
                                  title: recipe['title'],
                                  description: recipe['description'],
                                  image: recipe['image'],
                                  steps: recipe['steps'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Display the category image with the same logic as in the CuisinePage
  Widget _displayCategoryImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        height: 200,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      try {
        Uint8List decodedBytes = base64Decode(imagePath);
        return Image.memory(
          decodedBytes,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      } catch (e) {
        return _buildErrorWidget();
      }
    }
  }

  // Display the recipe image with the same logic as in the CuisinePage
  Widget _displayRecipeImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      try {
        Uint8List decodedBytes = base64Decode(imagePath);
        return Image.memory(
          decodedBytes,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget();
          },
        );
      } catch (e) {
        return _buildErrorWidget();
      }
    }
  }

  // Error widget to show in case image cannot be loaded
  Widget _buildErrorWidget() {
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          'Invalid Image Data',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
