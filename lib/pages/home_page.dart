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
      'image': 'assets/pasta.jpg',
      'steps': '1. Boil water\n2. Add pasta\n3. Cook for 10 minutes\n4. Drain and serve.'
    },
    {
      'title': 'Pizza',
      'description': 'Cheesy pizza with pepperoni.',
      'image': 'assets/pizza.jpg',
      'steps': '1. Preheat oven\n2. Roll out dough\n3. Add toppings\n4. Bake for 15 minutes.'
    },
    {
      'title': 'Salad',
      'description': 'Fresh vegetable salad.',
      'image': 'assets/salad.jpg',
      'steps': '1. Chop vegetables\n2. Mix ingredients\n3. Add dressing\n4. Serve chilled.'
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
                        image: filteredRecipes[index]['image']!,
                        steps: filteredRecipes[index]['steps']!, // ✅ Passing steps here
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
