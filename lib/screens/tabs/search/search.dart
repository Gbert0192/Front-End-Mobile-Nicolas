import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Where To Park ?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                readOnly: true,
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> data = [
    {
      'name': 'Sun Plaza',
      'address': 'Jl. KH. Zainul Arifin No.7',
      'image': 'assets/images/building/Sun Plaza.png',
      'price': 3000,
    },
    {
      'name': 'Center Point',
      'address': 'Jl. KH. Zainul Arifin No.7',
      'image': 'assets/images/building/Centre Point.png',
      'price': 3000,
    },
    {
      'name': 'Manhattan Time Square',
      'address': 'Medan, North Sumatra',
      'image': 'assets/images/building/Manhatan Time Square.png',
      'price': 3000,
    },
    {
      'name': 'Delipark',
      'address': 'Medan City Center',
      'image': 'assets/images/building/Delipark.png',
      'price': 5000,
    },
    {
      'name': 'Plaza Medan Fair',
      'address': 'Jl. MT Haryono',
      'image': 'assets/images/building/Plaza Medan Fair.png',
      'price': 4000,
    },
    {
      'name': 'Lippo Plaza',
      'address': 'Jl. Gatot Subroto',
      'image': 'assets/images/building/Lippo Plaza.png',
      'price': 3500,
    },
    {
      'name': 'Aryaduta',
      'address': 'Jl. Gatot Subroto',
      'image': 'assets/images/building/Aryaduta.png',
      'price': 3500,
    },
  ];

  @override
  String? get searchFieldLabel => "Search Mall";

  @override
  List<Widget>? buildActions(BuildContext context) {
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
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        data
            .where(
              (element) =>
                  element['name'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/empty/search_where.png', width: 200),
            const SizedBox(height: 16),
            const Text('Search no founded', style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final place = results[index];
        return ListTile(
          leading:
              place['image'] != ''
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      place['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                  : const Icon(Icons.location_on, size: 40),
          title: Text(place['name']),
          subtitle: Text(place['address']),
          trailing: Text(
            'Rp. ${place['price'].toString()}/hour',
            style: const TextStyle(color: Colors.orange),
          ),
          onTap: () {
            // Go to details page
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); // Show the same as result list
  }
}
