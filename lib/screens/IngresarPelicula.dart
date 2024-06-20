import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:taller_app/screens/VisualizarInfo.dart';

void main() {
  runApp(IngresarPeli());
}

class IngresarPeli extends StatelessWidget {
  const IngresarPeli({super.key});

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
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pelicula = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _precio = TextEditingController();

  Future<void> guardar() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("productos/" + _id.text);

    await ref.set({
      "id": _id.text,
      "producto": _pelicula.text,
      "categoria": _categoria.text,
      "precio": _precio.text
    });

    // Mostrar un diálogo de éxito
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Guardado con éxito"),
          content: Text("El producto ha sido guardado exitosamente."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // Limpiar los campos de texto
    _id.clear();
    _pelicula.clear();
    _categoria.clear();
    _precio.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
      ),
      body: Cuerpo(context),
    );
  }

  Widget Cuerpo(context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://previews.123rf.com/images/vladru/vladru1701/vladru170100027/70907250-pasillo-vac%C3%ADo-del-cine-y-la-pantalla-blanca-3d-ilustraci%C3%B3n.jpg'),
                fit: BoxFit.cover)),
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const Text("Formulario de película"),
            CampoId(context),
            SizedBox(height: 10),
            CampoProducto(context),
            SizedBox(height: 10),
            CampoCategoria(context),
            SizedBox(height: 10),
            CampoPrecio(context),
            SizedBox(height: 20),
            btnGuardar(),
            BotonVisualizar(context)
          ],
        ),
      ),
    );
  }

  Widget CampoId(context) {
    return TextFormField(
      controller: _id,
      decoration: InputDecoration(
        hintText: "ingresar ID",
        prefixIcon: Icon(Icons.perm_identity),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget CampoProducto(context) {
    return TextField(
      controller: _pelicula,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: "ingrese nombre de producto",
        prefixIcon: Icon(Icons.production_quantity_limits),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget CampoCategoria(context) {
    return TextField(
      controller: _categoria,
      decoration: InputDecoration(
        hintText: "Ingresar categoria",
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget CampoPrecio(context) {
    return TextField(
      controller: _precio,
      decoration: InputDecoration(
        hintText: "Ingresar precio",
        prefixIcon: Icon(Icons.attach_money),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget btnGuardar() {
    return ElevatedButton(
      onPressed: () {
        guardar();
      },
      child: const Text("Guardar"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )),
      ),
    );
  }
}

Widget BotonVisualizar(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Productos(),
        ),
      );
    },
    child: Text("Ver lista"),
  );
}
