import 'package:flutter/material.dart';
import 'package:temp/pages/Splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

// void populateFirestore() async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   final List<Map<String, String>> recipes = [
//     {
//       'title': 'Pasta',
//       'description': 'Delicious Italian pasta.',
//       'image': 'assets/pasta.jpg',
//       'steps': '1. Boil water\n2. Add pasta\n3. Cook for 10 minutes\n4. Drain and serve.',
//       'cuisine': 'Italian',
//     },
//   ];
//  for (var recipe in recipes) {
//     await firestore.collection('recipes').add(recipe);
//   }

//   print('Recipes added to Firestore!');
// }

void fetchRecipesData() async {
  try {
    // Fetch all documents from the 'recipes' collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('recipes').get();

    // Check if there are any documents in the collection
    if (querySnapshot.docs.isEmpty) {
      print("No data found in the 'recipes' collection.");
    } else {
      print("Data found in the 'recipes' collection:");
      // Iterate through all the documents and print their data
      for (var doc in querySnapshot.docs) {
        print(doc.data());  // Prints the document data
      }
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}

// void uploadRecipe() async {
//   try {
//     // Define the recipe data
//     Map<String, dynamic> recipeData = {
//       "name": "noodles",
//       "Steps": "fhlaf\nafdjgfdfg\nslghfdesgdlfgb\nlksdfhbgjkfdgsbls\n/nufguagfuagfkugafgakfgakfgkgdgdfkgd"
//       // You can add more fields here if necessary, e.g., ingredients, instructions, etc.
//     };

//     // Add the recipe to the 'recipes' collection
//     await FirebaseFirestore.instance.collection('recipes').add(recipeData);

//     print("Recipe 'Pav Bhaji' uploaded successfully!");
//   } catch (e) {
//     print("Error uploading recipe: $e");
//   }
// }


const FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyDMzzz7eL9QODkpMqPLTQaXV1CJk6g1jJk",
    authDomain: "foodieblog-41496.firebaseapp.com",
    projectId: "foodieblog-41496",
    storageBucket: "foodieblog-41496.firebasestorage.app",
    messagingSenderId: "636213249710",
    appId: "1:636213249710:web:c034adcd1f587bbeeccf3f",
    measurementId: "G-XZH9HC3NJM",
    // databaseURL:"https://console.firebase.google.com/project/foodieblog-41496/database/foodieblog-41496-default-rtdb/data/~2F"
    ); // Add the correct Firebase Realtime Database URL here);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await Firebase.initializeApp(options: firebaseConfig);
  // fetchRecipesData();
  // populateFirestore();
  
  // Initialize Firebase only if it's not already initialized
 
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash_Screen(),
    );
  }
}
