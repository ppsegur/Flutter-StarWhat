import 'package:flutter/material.dart';
import 'package:flutter_star_wars/models/people_list_response/people_list_response.dart';
import 'package:flutter_star_wars/models/people_list_response/result.dart';
import 'package:http/http.dart' as http;

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  late Future<PeopleResponse> peopleResponse;

  @override
  void initState() {
    super.initState();
    peopleResponse = getPeople();
  }


  @override
  Widget build(BuildContext context) {
    
return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo
              Image.network(
                'https://i.blogs.es/1da08b/1366_2000-9-/1366_2000.jpeg',
                fit: BoxFit.cover,
              ),
              // Sombreado para mejorar legibilidad
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              // Título centrado
              const Center(
                child: Text(
                  'Star Wars People',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF1A1A1A),
           
            ],
          ),
        ),
        child: FutureBuilder<PeopleResponse>(
          future: peopleResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPeopleList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
        // Spinner de carga
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
  Future<PeopleResponse> getPeople() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));

    if (response.statusCode == 200) {
      return PeopleResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load people');
    }
  }

 Widget _buildPeopleList(PeopleResponse peopleResponse) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 10.0, 
        mainAxisSpacing: 10.0, 
        childAspectRatio: 0.7,
      ),
      itemCount: peopleResponse.results!.length,
      itemBuilder: (context, index) {
        final person = peopleResponse.results![index];
        return _buildPersonCard(person);
      },
    ),
  );
}
Widget _buildPersonCard(People person) {
    final id = person.url?.split('/').where((e) => e.isNotEmpty).last;
    final imageUrl = id != null
        ? 'https://starwars-visualguide.com/assets/img/characters/$id.jpg'
        : 'assets/images/placeholder.jpg';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Stack(
          children: [
            // Imagen de fondo
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
           
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7), 
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(15.0),
                  ),
                ),
                child: Text(
                  person.name ?? 'Unknown',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
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