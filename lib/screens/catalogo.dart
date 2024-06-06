import 'package:flutter/material.dart';

void main() {
  runApp(Pantalla2());
}

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

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
      appBar: AppBar(),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://e0.pxfuel.com/wallpapers/847/384/desktop-wallpaper-film-film-horror-film-and-film-noir-movies-collage.jpg'),
            fit: BoxFit.cover)),
    child: Center(
      child: Column(
        children: <Widget>[
          BotonCatalogo(context),
        ],
      ),
    ),
  );
}

// Lista de URLs de imágenes
final List<String> imageUrls = [
  'https://www.originalfilmart.com/cdn/shop/products/taxi_driver_R06_german_a1_original_film_art_5000x.jpg?v=1590181824',
  'https://m.media-amazon.com/images/S/pv-target-images/d7cd0dcc35e6279755ce93444242894366b0a2303053043af5aefd4ff595b2b3.jpg',
  'https://m.media-amazon.com/images/S/pv-target-images/6cd55bc1b57fe5325cb9282beafeed33f7afd1b84587ace542199387eafbec21.jpg',
  'https://static.wikia.nocookie.net/doblaje/images/e/ec/Escape_Plan_The_extractors_2019.jpg/revision/latest?cb=20200328230224&path-prefix=es',
  'https://musicart.xboxlive.com/7/d7315200-0000-0000-0000-000000000002/504/image.jpg?w=1920&h=1080',
  'https://cdn.domestika.org/c_fill,dpr_1.0,f_auto,h_1200,pg_1,t_base_params,w_1200/v1592232391/project-covers/000/761/173/761173-original.jpg?1592232391'
];

// Widget para el catálogo de imágenes
Widget BotonCatalogo(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatalogoImagenes(),
        ),
      );
    },
    child: Text("Abrir Catálogo de Películas"),
  );
}

class CatalogoImagenes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 4.0, // Espaciado entre columnas
          mainAxisSpacing: 4.0, // Espaciado entre filas
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetalleImagen(imageUrl: imageUrls[index]),
                ),
              );
            },
            child: Image.network(imageUrls[index]),
          );
        },
      ),
    );
  }
}

class DetalleImagen extends StatelessWidget {
  final String imageUrl;

  DetalleImagen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Película'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
