import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> recipes = [
    {
      'title': 'Pasta',
      'description': 'Delicious Italian pasta.',
      'image': 'assets/pasta.jpg'
    },
    {
      'title': 'Pizza',
      'description': 'Cheesy pizza with pepperoni.',
      'image': 'assets/pizza.jpg'
    },
    {
      'title': 'Salad',
      'description': 'Fresh vegetable salad.',
      'image': 'assets/salad.jpg'
    },
  ];

  late List<Map<String, String>> filteredRecipes;
  String searchQuery = '';

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

  void _searchRecipes(String query) {
    setState(() {
      searchQuery = query;
      filteredRecipes = recipes
          .where((recipe) =>
              recipe['title']!.toLowerCase().contains(query.toLowerCase()) ||
              recipe['description']!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: RecipeSearchDelegate(recipes),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        description: filteredRecipes[index]['description']!,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
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
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
              ),
            );
          },
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
        tooltip: 'Add Recipe',
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate {
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
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredRecipes = recipes
        .where((recipe) =>
            recipe['title']!.toLowerCase().contains(query.toLowerCase()) ||
            recipe['description']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredRecipes[index]['title']!),
          subtitle: Text(filteredRecipes[index]['description']!),
          onTap: () {
            close(context, null);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  title: filteredRecipes[index]['title']!,
                  description: filteredRecipes[index]['description']!,
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
    final suggestions = recipes
        .where((recipe) =>
            recipe['title']!.toLowerCase().contains(query.toLowerCase()) ||
            recipe['description']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]['title']!),
          subtitle: Text(suggestions[index]['description']!),
        );
      },
    );
  }
}
