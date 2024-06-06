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
    List<Widget> screens = [Body(context), const Registro(), const Pantalla2()];
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
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: "Catalogo"),
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
        Boton()
      ],
    ),
  );
}

Widget Usuario() {
  return (Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
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
      obscureText: true,
      decoration: const InputDecoration(
          hintText: "ingresar password",
          fillColor: Colors.yellow,
          filled: true),
      keyboardType: TextInputType.number,
    ),
  ));
}

Widget Boton() {
  return (Container(
    child: ElevatedButton(
      onPressed: () {},
      child: Text("LOGIN"),
      style: ButtonStyle(),
    ),
  ));
}

// ignore: non_constant_identifier_names
Widget Boton1(context) {
  return (FilledButton(
      onPressed: () {
        irTab(context);
      },
      child: const Text("Ir a la ventana Principal")));
}

//funcion para navegar
void irTab(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const TallerApp()));
}
