import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';
import 'cuisine_page.dart';
import 'food_category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> cuisines = [
    {'name': 'Italian', 'image': 'assets/italian.jpg'},
    {'name': 'Chinese', 'image': 'assets/chinese.jpg'},
    {'name': 'Indian', 'image': 'assets/indian.jpg'},
    {'name': 'Mexican', 'image': 'assets/mexican.jpg'},
  ];

  final List<Map<String, String>> foodCategories = [
    {'name': 'Breakfast', 'image': 'assets/breakfast.jpg'},
    {'name': 'Snacks', 'image': 'assets/snacks.jpg'},
    {'name': 'Lunch', 'image': 'assets/lunch.jpg'},
    {'name': 'Dinner', 'image': 'assets/dinner.jpg'},
    {'name': 'Desserts', 'image': 'assets/desserts.jpg'},
  ];


  late List<Map<String, String>> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

Future<void> _fetchRecipes() async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('recipes').get();
  setState(() {
    filteredRecipes = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'title': data['title'] as String,
        'description': data['description'] as String,
        'image': data['image'] as String,
        'steps': data['steps'] as String,
        'cuisine': data['cuisine'] as String,
        'categories': jsonEncode(List<String>.from(data['categories'] ?? [])), // Convert List<String> to JSON
      };
    }).toList();
  });
}


  void _addNewRecipe(Map<String, String> newRecipe) {
    setState(() {
      filteredRecipes.add(newRecipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(filteredRecipes),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {  // Desktop View
   return Row(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       // Left Sidebar (Cuisines & Food Categories)
       Container(
         width: 250,  // Sidebar width
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
           color: Colors.grey[200],
           border: Border(
             right: BorderSide(
               color: Colors.grey[300]!,
               width: 1,
             ),
           ),
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             // Cuisines Section
             const Text(
               'Cuisines',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.deepPurple,
               ),
             ),
             const SizedBox(height: 10),
             Expanded(
               flex: 1,
               child: ListView.builder(
                 itemCount: cuisines.length,
                 itemBuilder: (context, index) {
                   final cuisine = cuisines[index];
                   return GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => CuisinePage(
                             cuisineName: cuisine['name']!,
                             cuisineImage: cuisine['image']!,
                             recipes: filteredRecipes,
                           ),
                         ),
                       );
                     },
                     child: Card(
                       margin: const EdgeInsets.only(bottom: 10),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       elevation: 3,
                       child: Column(
                         children: [
                           ClipRRect(
                             borderRadius: const BorderRadius.only(
                               topLeft: Radius.circular(10),
                               topRight: Radius.circular(10),
                             ),
                             child: Image.asset(
                               cuisine['image']!,
                               height: 80,
                               width: double.infinity,
                               fit: BoxFit.cover,
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               cuisine['name']!,
                               style: const TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.deepPurple,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 },
               ),
             ),

             const SizedBox(height: 20),

             // Food Categories Section
             const Text(
               'Food Categories',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,
                 color: Colors.deepPurple,
               ),
             ),
             const SizedBox(height: 10),
             Expanded(
               flex: 1,
               child: ListView.builder(
                 itemCount: foodCategories.length,
                 itemBuilder: (context, index) {
                   final category = foodCategories[index];
                   return GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => FoodCategoryPage(
                             categoryName: category['name']!,
                             categoryImage: category['image']!,
                           ),
                         ),
                       );
                     },
                     child: Card(
                       margin: const EdgeInsets.only(bottom: 10),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       elevation: 3,
                       child: Column(
                         children: [
                           ClipRRect(
                             borderRadius: const BorderRadius.only(
                               topLeft: Radius.circular(10),
                               topRight: Radius.circular(10),
                             ),
                             child: Image.asset(
                               category['image']!,
                               height: 80,
                               width: double.infinity,
                               fit: BoxFit.cover,
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               category['name']!,
                               style: const TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.deepPurple,
                               ),
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
       ),
                // Recipes section (right side)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search bar
                        GestureDetector(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: RecipeSearchDelegate(filteredRecipes),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8),
                                Text("Search recipes...",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6, // 2 columns for desktop
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8, // Adjust the aspect ratio
                            ),
                            itemCount: filteredRecipes.length,
                            itemBuilder: (context, index) {
                              return _buildRecipeCard(filteredRecipes[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile view: Default layout
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: RecipeSearchDelegate(filteredRecipes),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("Search recipes...",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Cuisines',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cuisines.length,
                      itemBuilder: (context, index) {
                        final cuisine = cuisines[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CuisinePage(
                                  cuisineName: cuisine['name']!,
                                  cuisineImage: cuisine['image']!,
                                  recipes: filteredRecipes,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      cuisine['image']!,
                                      height: 70,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Text(
                                      cuisine['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Food Categories Section
                  const Text(
                    'Food Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodCategories.length,
                      itemBuilder: (context, index) {
                        final category = foodCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodCategoryPage(
                                  categoryName: category['name']!,
                                  categoryImage: category['image']!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      category['image']!,
                                      height: 80,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Text(
                                      category['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20), // Space before recipe list

                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        return _buildRecipeCard(filteredRecipes[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipePage()),
          );
          if (newRecipe != null) {
            _addNewRecipe(newRecipe);
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, String> recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
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
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
      );
    } else {
      try {
        Uint8List decodedBytes = base64Decode(imagePath);
        return Image.memory(
          decodedBytes,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        );
      } catch (e) {
        return const SizedBox(
          height: 200,
          child: Center(child: Text('Invalid Image Data')),
        );
      }
    }
  }
}

/// Recipe Search Delegate for searching recipes
class RecipeSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, String>> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = recipes
        .where((recipe) =>
            recipe['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['title']!),
          onTap: () {
            // Push the RecipeDetailPage when a recipe is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  title: results[index]['title']!,
                  description: results[index]['description']!,
                  image: results[index]['image']!,
                  steps: results[index]['steps']!,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}