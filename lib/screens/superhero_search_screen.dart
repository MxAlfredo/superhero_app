import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/respository.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superHeroInfo;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Superhero Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter superhero name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                setState(() {
                  _superHeroInfo = repository.fetchSuperhero(value);
                });
              },
            ),
          ),
          FutureBuilder(
            future: _superHeroInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error fetching data'));
              } else if (snapshot.hasData) {
                return Center(
                  child: Text(
                    'Superhero Response: ${snapshot.data?.response}',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return Center(child: Text('No data available'));
            },
          ),
        ],
      ),
    );
  }
}
