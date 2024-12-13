import 'package:flutter/material.dart';
import 'package:flutter_star_wars/models/people_list_response/result.dart';

class PeopleDetailScreen extends StatefulWidget {
  final People peopleItem;
  const PeopleDetailScreen({super.key, required this.peopleItem});

  @override
  State<PeopleDetailScreen> createState() => _PeopleDetailScreenState();
}

class _PeopleDetailScreenState extends State<PeopleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar negro
        title: Text(
          widget.peopleItem.name!,
          style: const TextStyle(color: Colors.white), // Título en blanco
        ),
      ),
         body:  Container(
        // Degradado de negro
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color.fromARGB(255, 22, 22, 22),
              Color.fromARGB(255, 68, 56, 56),
            ],
          ),
        ),
        child:  SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del personaje
    Center(
      child: Image.network(
        widget.peopleItem.url != null
            ? 'https://starwars-visualguide.com/assets/img/characters/${widget.peopleItem.url!.split('/').where((e) => e.isNotEmpty).last}.jpg'
            : 'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.person,
            size: 100,
            color: Colors.grey,
          );
        },
      ),
            ),
            const SizedBox(height: 16),

            // Nombre del personaje
            Center(
              child: Text(
                widget.peopleItem.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Detalles del personaje
          _buildDetailRow(Icons.height, 'Altura', '${widget.peopleItem.height} cm'),
          _buildDetailRow(Icons.fitness_center, 'Peso', '${widget.peopleItem.mass} kg'),
          _buildDetailRow(Icons.palette, 'Color de cabello', widget.peopleItem.hairColor!),
          _buildDetailRow(Icons.remove_red_eye, 'Color de ojos', widget.peopleItem.eyeColor!),
          _buildDetailRow(Icons.transgender, 'Género', widget.peopleItem.gender!),
          ],
        ),
      ),
        ),
      );
    
  }

  // Widget para mostrar filas de detalles, añadido el Ico Data 
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.yellowAccent,),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}