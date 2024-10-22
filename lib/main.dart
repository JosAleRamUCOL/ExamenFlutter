import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter',
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 25, 38, 132)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Examen Flutter'),
    );
  }
}

class Usuarios {
  String logi;
  String nombre;
  String pass;
  String email;
  
  Usuarios(this.logi, this.nombre, this.pass, this.email);
}

List<Usuarios> _Usuarioss = [
  Usuarios('Alex', 'Jose Alejandro Ramírez Muñoz', '1234', 'alex@correo.com'),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _contador = 0; 

  void _onLogin() {
    String logi = _nombreController.text;
    String password = _passwordController.text;

    try {
      Usuarios? user = _Usuarioss.firstWhere(
        (Usuarios) => Usuarios.logi == logi && Usuarios.pass == password,
      );

      if (user != null) {
        // Reinicia los intentos fallidos
        setState(() {
          _contador = 0;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Principal2(user: user),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _contador++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Inicio de Sesión', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30.0),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                hintText: 'Login',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
                
              ),
              child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.black)),
              onPressed: _onLogin,
            ),
            const SizedBox(height: 30.0),
            
            Text(
              'Intentos: $_contador',
              style: const TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class Principal2 extends StatelessWidget {
  final Usuarios user;

  const Principal2({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Usuario'),
      ),
      body: Center(
        child: Text(
          'Login del usuario: ${user.logi}\nNombre: ${user.nombre}\nEmail: ${user.email}\n Encontrado!!!',
          style: const TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

