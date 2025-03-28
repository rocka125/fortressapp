import 'package:flutter/material.dart';

class PoliticaPage extends StatelessWidget {
  const PoliticaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Política de Privacidad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Política de Privacidad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Esta es la política de privacidad de Fortressapp. Aquí puedes '
                'describir cómo se recopilan, almacenan y utilizan los datos '
                'de los usuarios. Asegúrate de incluir toda la información '
                'relevante para que los usuarios estén informados sobre '
                'el uso de sus datos.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '1. Recopilación de Datos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Recopilamos datos como el nombre, correo electrónico y dirección para '
                'ofrecerte una mejor experiencia en la aplicación.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '2. Uso de Datos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Los datos recopilados se usan para personalizar la experiencia '
                'y ofrecer servicios adecuados a tus necesidades.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                '3. Seguridad:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Implementamos medidas de seguridad para proteger tus datos.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
