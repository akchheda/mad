import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';
import 'cuisine_page.dart';

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
      'steps': '1. Boil water\n2. Add pasta\n3. Cook for 10 minutes\n4. Drain and serve.',
      'cuisine': 'Italian',
    },
    {
      'title': 'Pizza',
      'description': 'Cheesy pizza with pepperoni.',
      'image': 'assets/pizza.jpg',
      'steps': '1. Preheat oven\n2. Roll out dough\n3. Add toppings\n4. Bake for 15 minutes.',
      'cuisine': 'Italian',
    },
        {
      'title': 'Sushi',
      'description': 'Fresh sushi rolls with salmon and avocado.',
      'image': 'assets/sushi.jpg',
      'steps': '1. Prepare sushi rice\n2. Cut fish and vegetables\n3. Roll with nori\n4. Slice and serve.',
      'cuisine': 'Japanese',
    },
    {
      'title': 'Tacos',
      'description': 'Mexican tacos with beef and fresh toppings.',
      'image': 'assets/tacos.jpg',
      'steps': '1. Cook beef with spices\n2. Warm tortillas\n3. Add toppings\n4. Serve with lime.',
      'cuisine': 'Mexican',
    },
    {
      'title': 'Butter Chicken',
      'description': 'Rich and creamy Indian butter chicken.',
      'image': 'assets/butter_chicken.jpg',
      'steps': '1. Marinate chicken in yogurt and spices\n2. Cook with tomato and butter sauce\n3. Simmer until creamy\n4. Serve with rice or naan.',
      'cuisine': 'Indian',
    },
    {
      'title': 'Pad Thai',
      'description': 'Thai stir-fried noodles with shrimp and peanuts.',
      'image': 'assets/pad_thai.jpg',
      'steps': '1. Soak rice noodles\n2. Stir-fry shrimp and tofu\n3. Add noodles and sauce\n4. Garnish with peanuts and lime.',
      'cuisine': 'Thai',
    },
    {
      'title': 'Cheeseburger',
      'description': 'Classic American cheeseburger with fries.',
      'image': 'assets/cheeseburger.jpeg',
      'steps': '1. Grill beef patty\n2. Toast buns\n3. Add cheese and toppings\n4. Serve with fries.',
      'cuisine': 'American',
    },
    {
      'title': 'Paella',
      'description': 'Traditional Spanish seafood paella.',
      'image': 'assets/paella.jpg',
      'steps': '1. Sauté onions and garlic\n2. Add rice, saffron, and broth\n3. Add seafood and cook\n4. Serve with lemon wedges.',
      'cuisine': 'Spanish',
    },
    {
      'title': 'Kimchi Fried Rice',
      'description': 'Korean-style fried rice with kimchi and egg.',
      'image': 'assets/kimchi_fried_rice.jpg',
      'steps': '1. Sauté kimchi and garlic\n2. Add rice and soy sauce\n3. Stir-fry until combined\n4. Top with a fried egg.',
      'cuisine': 'Korean',
    },
    {
      'title': 'Falafel',
      'description': 'Crispy Middle Eastern chickpea falafels.',
      'image': 'assets/falafel.jpg',
      'steps': '1. Blend chickpeas with spices\n2. Shape into balls\n3. Deep-fry until golden\n4. Serve in pita with tahini.',
      'cuisine': 'Middle Eastern',
    },
    {
      'title': 'Biryani',
      'description': 'Aromatic Indian rice dish with spices and meat.',
      'image': 'assets/biryani.jpg',
      'steps': '1. Cook spiced rice and marinated meat\n2. Layer them together\n3. Slow cook until flavors blend\n4. Serve with yogurt or raita.',
      'cuisine': 'Indian',
    },
    {
      'title': 'Croissant',
      'description': 'Flaky and buttery French croissants.',
      'image': 'assets/croissant.jpg',
      'steps': '1. Prepare laminated dough\n2. Roll and shape croissants\n3. Proof and bake\n4. Enjoy warm with butter or jam.',
      'cuisine': 'French',
    }

  ];

  final List<Map<String, String>> cuisines = [
    {'name': 'Italian', 'image': 'assets/italian.jpg'},
    {'name': 'Chinese', 'image': 'assets/chinese.jpg'},
    {'name': 'Indian', 'image': 'assets/indian.jpg'},
    {'name': 'Mexican', 'image': 'assets/mexican.jpg'},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: RecipeSearchDelegate(recipes),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text("Search recipes...", style: TextStyle(color: Colors.grey)),
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
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              description: filteredRecipes[index]['description']!,
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
          ],
        ),
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
    final results = recipes.where((recipe) => recipe['title']!.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['title']!),
          onTap: () {
            query = results[index]['title']!;
            showResults(context);
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
