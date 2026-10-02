// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// // Main application widget
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const ProfilePage(),
//     );
//   }
// }

// // Profile page
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Container, Padding, Row & Column'),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: Container(
//           width: 350,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.blue[300],
//             borderRadius: BorderRadius.circular(15),
//           ),

//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   const Row(
//                     children: [
//                       Icon(Icons.face, size: 45, color: Colors.black),
//                       SizedBox(height: 5),
//                     ],
//                   ),

//                   const Text(
//                     "My Profile Card",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 15),

//               const Text("Name: Clarke Murcia", style: TextStyle(fontSize: 19)),

//               const SizedBox(height: 10),

//               const Text("Age: 20", style: TextStyle(fontSize: 19)),

//               const SizedBox(height: 10),

//               const Text(
//                 "Location: Cahayag Tubigon Bohol",
//                 style: TextStyle(fontSize: 19),
//               ),fi

//               const SizedBox(height: 20),

//               // Row containing icons
//               Column(mainAxisAlignment: MainAxisAlignment.center, children: [

//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   final List<String> fruits = const [
//     'Apple',
//     'Grapes',
//     'Clarke Murcia',
//     'Orange',
//     'Kiwi',
//     'PineApple',
//     'Raspberry',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fruit List'),
//           actions: [
//             IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
//           ],
//         ),
//         body: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: fruits.length,
//           itemBuilder: (context, index) {
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               child: ListTile(
//                 title: Text(fruits[index]),
//                 trailing: const Icon(Icons.shopping_cart_outlined),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class Fruit {
//   String name;

//   Fruit({required this.name});
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<String> fruits = [
//       "Apple",
//       "Banana",
//       "Orange",
//       "Mango",
//       "Clarke Murcia",
//       "Grapes",
//       "Pineapple",
//       "Strawberry",
//     ];

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Fruits',
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Fruits')),
//         body: ListView.builder(
//           itemCount: fruits.length,
//           itemBuilder: (context, index) {
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(fruits[index], style: const TextStyle(fontSize: 20)),
//                     const Icon(Icons.shopping_cart),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fruit {
  String name;

  Fruit({required this.name});

  // Convert API JSON data into a Fruit object
  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(name: json['title']);
  }
}

// Fetch data from the API
Future<List<Fruit>> fetchFruits() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products?limit=0'),
  );

  if (response.statusCode == 200) {
    // Convert the API response into JSON
    final data = jsonDecode(response.body);

    // Get the products from the JSON
    List<dynamic> products = data['products'];

    // Fruit names that we want to display
    List<String> fruitNames = [
      'Apple',
      'Grape',
      'Orange',
      'Kiwi',
      'Pineapple',
      'Raspberry',
      'Banana',
      'Mango',
      'Strawberry',
      'Watermelon',
      'Lemon',
      'Lime',
      'Peach',
      'Pear',
      'Cherry',
      'Papaya',
      'Coconut',
      'Avocado',
      'Dragon Fruit',
      'Guava',
    ];

    // Get matching fruits from the API
    List<Fruit> fruits = products
        .where((product) {
          return fruitNames.contains(product['title']);
        })
        .map((product) {
          return Fruit.fromJson(product);
        })
        .toList();

    return fruits;
  } else {
    throw Exception('Failed to load fruits');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Fruit> fruits = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Fetch the API data when the app starts
    loadFruits();
  }

  // Get fruits from the API
  void loadFruits() async {
    try {
      List<Fruit> apiFruits = await fetchFruits();

      setState(() {
        fruits = apiFruits;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void removeFruit(Fruit fruit) {
    setState(() {
      fruits.remove(fruit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text('Fruit List'), centerTitle: true),

        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : fruits.isEmpty
            ? const Center(child: Text('No fruits found'))
            : ListView.builder(
                itemCount: fruits.length,

                itemBuilder: (context, index) {
                  final fruit = fruits[index];

                  return FruitCard(
                    fruit: fruit,
                    index: index,

                    delete: () {
                      removeFruit(fruit);
                    },
                  );
                },
              ),
      ),
    );
  }
}

class FruitCard extends StatelessWidget {
  final Fruit fruit;
  final int index;
  final Function delete;

  const FruitCard({
    super.key,
    required this.fruit,
    required this.index,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),

        title: Text(fruit.name),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 46, 87, 87),
              ),

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${fruit.name} added to cart!')),
                );
              },
            ),

            TextButton.icon(
              onPressed: () {
                delete();
              },

              icon: const Icon(Icons.delete, color: Colors.red),

              label: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
