import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:taller_app/screens/catalogo.dart';
import 'package:taller_app/screens/registro.dart';

void main() {
  runApp(TallerApp());
}

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            // ignore: prefer_const_constructors
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 198, 218, 211)),
        useMaterial3: true,
      ),
      home: const Cuerpo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  int indice = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [Body(context), const Registro()];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("taller 1"),
      ),
      body: screens[indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) {
          setState(() {
            indice = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.login), label: "Login"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration), label: "Registro"),
        ],
      ),
    );
  }
}

Widget Body(context) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/vector-premium/fondo-elementos-cine_1278-161.jpg'),
            fit: BoxFit.cover)),
    child: Column(
      children: [
        Text(
          "Login",
          style: TextStyle(
              fontSize: 30, color: const Color.fromARGB(255, 190, 231, 153)),
        ),
        Usuario(),
        Password(),
        Boton(context)
      ],
    ),
  );
}

final TextEditingController _correo = TextEditingController();
final TextEditingController _contrasenia = TextEditingController();

Widget Usuario() {
  return (Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _correo,
        style: TextStyle(backgroundColor: Color.fromARGB(0, 137, 137, 240)),
        decoration: InputDecoration(
            hintText: "ingresar usuario",
            fillColor: Color.fromARGB(232, 248, 177, 136),
            filled: true),
      )));
}

Widget Password() {
  return (Container(
    padding: const EdgeInsets.all(10),
    child: TextField(
      controller: _contrasenia,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "ingresar password",
          fillColor: Colors.yellow,
          filled: true),
      keyboardType: TextInputType.number,
    ),
  ));
}

Widget Boton(context) {
  return (Container(
    child: ElevatedButton(
      onPressed: () {
        //funcion login
        login(context);
      },
      child: Text("LOGIN"),
      style: ButtonStyle(),
    ),
  ));
}

Future<void> login(context) async {
  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _correo.text, password: _contrasenia.text);

///////////////navegacion///////////////
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Pantalla2()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
