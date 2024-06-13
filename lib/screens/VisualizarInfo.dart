import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Productos());
}

class Productos extends StatelessWidget {
  const Productos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lista(),
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> productList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    /////////////////////////////////////////
    /// Función con el objetivo de traer los datos
    /////////////////////////////////////////

    DatabaseReference productoRef = FirebaseDatabase.instance.ref('productos');
    productoRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateProductList(data);
    });
  }

  void updateProductList(Object? data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];

      if (data is Map) {
        data.forEach((key, value) {
          //////////////////////////////////////////
          /// Se asigna la clave y valor a la lista temporal
          //////////////////////////////////////////

          tempList.add({
            "producto": value['producto'],
            "precio": value['precio'],
            "categoria": value['categoria']
          });
        });
      } else if (data is List) {
        for (var value in data) {
          if (value is Map) {
            tempList.add({
              "producto": value['producto'],
              "precio": value['precio'],
              "categoria": value['categoria']
            });
          }
        }
      }

      setState(() {
        productList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Películas'),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ListTile(
            //////////////////////////////////////
            /// Se manda a imprimir los valores solicitados
            //////////////////////////////////////

            title: Text('${productList[index]["producto"]}'),
          );
        },
      ),
    );
  }
}

Widget Cuerpo(context) {
  return (Column(
    children: <Widget>[const Text("Products")],
  ));
}
