// home_page.dart
import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';
import 'cuisine_page.dart'; // Import the new file for cuisine navigation

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Updated recipes list with a 'cuisine' field and some recipes for each cuisine.
  final List<Map<String, String>> recipes = [
    {
      'title': 'Pasta',
      'description': 'Delicious Italian pasta.',
      'image': 'assets/pasta.jpg',
      'steps':
          '1. Boil water\n2. Add pasta\n3. Cook for 10 minutes\n4. Drain and serve.',
      'cuisine': 'Italian',
    },
    {
      'title': 'Pizza',
      'description': 'Cheesy pizza with pepperoni.',
      'image': 'assets/pizza.jpg',
      'steps':
          '1. Preheat oven\n2. Roll out dough\n3. Add toppings\n4. Bake for 15 minutes.',
      'cuisine': 'Italian',
    },
    {
      'title': 'Fried Rice',
      'description': 'Tasty Chinese fried rice with vegetables.',
      'image': 'assets/fried_rice.jpg',
      'steps':
          '1. Heat oil\n2. Add vegetables\n3. Stir in rice and soy sauce\n4. Fry until cooked.',
      'cuisine': 'Chinese',
    },
    {
      'title': 'Butter Chicken',
      'description': 'Creamy Indian butter chicken.',
      'image': 'assets/butter_chicken.jpg',
      'steps':
          '1. Marinate chicken\n2. Cook in a creamy tomato sauce\n3. Simmer and serve with naan.',
      'cuisine': 'Indian',
    },
    {
      'title': 'Tacos',
      'description': 'Spicy Mexican tacos with beef.',
      'image': 'assets/tacos.jpg',
      'steps':
          '1. Cook beef with spices\n2. Fill tortillas\n3. Top with salsa and cheese.',
      'cuisine': 'Mexican',
    },
  ];

  // Cuisines list.
  final List<Map<String, String>> cuisines = [
    {
      'name': 'Italian',
      'image': 'assets/italian.jpg',
    },
    {
      'name': 'Chinese',
      'image': 'assets/chinese.jpg',
    },
    {
      'name': 'Indian',
      'image': 'assets/indian.jpg',
    },
    {
      'name': 'Mexican',
      'image': 'assets/mexican.jpg',
    },
  ];

  late List<Map<String, String>> filteredRecipes;

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void _addNewRecipe(Map<String, String> newRecipe) {
    setState(() {
      recipes.add(newRecipe);
      filteredRecipes = recipes;
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
                delegate: RecipeSearchDelegate(recipes),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Using a Column to show a read-only search bar, cuisines section, then the recipe list.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Read-only Search Bar.
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: RecipeSearchDelegate(recipes),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      "Search recipes...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Cuisines Section.
            Text(
              'Cuisines',
              style: Theme.of(context).textTheme.headline6?.copyWith(
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
                      // Navigate to CuisinePage when a cuisine is tapped.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CuisinePage(
                            cuisineName: cuisine['name']!,
                            cuisineImage: cuisine['image']!,
                            recipes: recipes,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
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
            const SizedBox(height: 20),
            // Recipe List Section.
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
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
                              title: filteredRecipes[index]['title']!,
                              description: filteredRecipes[index]
                                  ['description']!,
                              image: filteredRecipes[index]['image']!,
                              steps: filteredRecipes[index]['steps']!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            filteredRecipes[index]['image']!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              filteredRecipes[index]['title']!,
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
                              filteredRecipes[index]['description']!,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => AddRecipePage()),
          );
          if (newRecipe != null) {
            _addNewRecipe(newRecipe);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

/// Custom Search Delegate for searching recipes.
class RecipeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Clear the search query.
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // A back button to exit the search.
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, String>> matchQuery = recipes.where((recipe) {
      final title = recipe['title']!.toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            matchQuery[index]['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(matchQuery[index]['title']!),
          subtitle: Text(matchQuery[index]['description']!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  title: matchQuery[index]['title']!,
                  description: matchQuery[index]['description']!,
                  image: matchQuery[index]['image']!,
                  steps: matchQuery[index]['steps']!,
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
    final List<Map<String, String>> matchQuery = recipes.where((recipe) {
      final title = recipe['title']!.toLowerCase();
      return title.contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset(
            matchQuery[index]['image']!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(matchQuery[index]['title']!),
          subtitle: Text(matchQuery[index]['description']!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  title: matchQuery[index]['title']!,
                  description: matchQuery[index]['description']!,
                  image: matchQuery[index]['image']!,
                  steps: matchQuery[index]['steps']!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
