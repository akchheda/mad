// cuisine_page.dart
import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';

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
          Image.asset(
            cuisineImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
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
                        Image.asset(
                          cuisineRecipes[index]['image']!,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
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
}
