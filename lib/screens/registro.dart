import 'package:flutter/material.dart';

void main() {
  runApp(Registro());
}

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Cuerpo(
          context, _nombreController, _emailController, _passwordController),
    );
  }
}

Widget Cuerpo(
    context,
    TextEditingController nombreController,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            'https://media.istockphoto.com/id/1566653954/es/foto/manos-sosteniendo-tablillas-haciendo-cine-de-video-en-el-estudio-claqueta-de-producci%C3%B3n-de.jpg?s=612x612&w=0&k=20&c=B7JoPct1gkPTnEuhC5lKvHG79HOzQm6ulyLZ9LyeVec='),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes añadir la lógica para manejar el registro, como enviar los datos a un servidor
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Registro Exitoso"),
                      content: Text(
                          "Nombre: ${nombreController.text}\nCorreo: ${emailController.text}"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    ),
  );
}
