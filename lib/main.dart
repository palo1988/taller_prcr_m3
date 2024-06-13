import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:taller_app/screens/inicio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Pantalla1());
}

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taller'),
      ),
      body: Cuerpo(context),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Cuerpo(context) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/foto-gratis/collage-fondo-pelicula_23-2149876016.jpg'),
            fit: BoxFit.cover)),
    child: Center(
      child: (Column(
        children: <Widget>[
          Boton1(context),
        ],
      )),
    ),
  );
}

/////////////////////boton1
// ignore: non_constant_identifier_names
Widget Boton1(BuildContext context) {
  return FilledButton(
    onPressed: () {
      irPrincipal(context);
    },
    child: const Text("Iniciar "),
  );
}

//funcion para navegar
void irPrincipal(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const TallerApp()));
}
