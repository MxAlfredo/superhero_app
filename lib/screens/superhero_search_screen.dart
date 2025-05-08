import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
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
          bodyList(),
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList() {
    return FutureBuilder(
      future: _superHeroInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (snapshot.hasData) {
          List<SuperheroDetailResponse>? data = snapshot.data?.results;
          return Expanded(
            child: ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, index) {
                if (data != null && data.isNotEmpty) {
                  return ListTile(
                    leading: Image.network(data[index].url ?? ''),
                    title: Text(data[index].name ?? ''),
                    subtitle: Text("Power: ${data[index].id}"),
                  );
                } else {
                  return const ListTile(
                    leading: Icon(Icons.error),
                    title: Text('No data available'),
                    subtitle: Text('Please try again later'),
                  );
                }
              },
            ),
          );
        }
        return Center(child: Text('No data available'));
      },
    );
  }
}
