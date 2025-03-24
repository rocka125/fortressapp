import 'package:flutter/material.dart';

class PoliticaPage extends StatefulWidget {
  final String email;

  const PoliticaPage({super.key, required this.email});

  @override
  _PoliticaPageState createState() => _PoliticaPageState();
}

class _PoliticaPageState extends State<PoliticaPage> {
  final TextEditingController _politicaController = TextEditingController();

  void _guardarPolitica() {
    String politica = _politicaController.text;
    if (politica.isNotEmpty) {
      print('Política guardada: $politica');
      // Aquí puedes agregar la lógica para guardar la política en el servidor
    } else {
      print('Por favor, ingresa una política válida.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear Política")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Bienvenido, ${widget.email}"),
            TextField(
              controller: _politicaController,
              decoration: InputDecoration(labelText: "Escribe una política"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarPolitica,
              child: Text("Guardar Política"),
            ),
          ],
        ),
      ),
    );
  }
}
