import 'package:flutter/material.dart';
import 'api_service.dart';
import 'politica_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FORTREAPP',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    // Hacemos la animación de opacidad para desaparecer el icono
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
      // Luego de 2 segundos, navega a la página de Login
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Icon(Icons.shield, size: 100, color: Colors.red),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  String _message = '';

  void _login() async {
    try {
      var response = await _apiService.loginUser(
        _emailController.text,
        _passwordController.text,
      );

      if (response.containsKey('error')) {
        setState(() {
          _message = response['error'];
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield, size: 80, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'FORTIAPP',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Correo electrónico",
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Contraseña",
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Iniciar sesión"),
                ),
                SizedBox(height: 16),
                if (_message.isNotEmpty)
                  Text(_message, style: TextStyle(color: Colors.red)),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "¿No tienes cuenta? Regístrate aquí",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ApiService _apiService = ApiService();

  HomePage({super.key});

  void _logout(BuildContext context) async {
    try {
      await _apiService.logoutUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PoliticaPage()),
            );
          },
          child: Text('Políticas de Privacidad'),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final ApiService _apiService = ApiService();
  String _message = '';

  void _register() async {
    var response = await _apiService.registerUser(
      _controllers[0].text,
      _controllers[1].text,
      _controllers[2].text,
      _controllers[3].text,
      _controllers[4].text,
      _controllers[5].text,
    );
    setState(() {
      _message = response['message'];
    });
    if (_message == 'Registro exitoso') {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final labels = [
      "Correo electrónico",
      "Contraseña",
      "Nombre",
      "Apellido",
      "Dirección",
      "Teléfono",
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.person_add, size: 80, color: Colors.red),
                SizedBox(height: 20),
                ...List.generate(labels.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(hintText: labels[index]),
                      obscureText: index == 1,
                    ),
                  );
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Registrarse"),
                ),
                if (_message.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(_message, style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
