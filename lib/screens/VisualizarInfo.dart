import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Productos());
}

class Productos extends StatelessWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
    DatabaseReference productoRef = FirebaseDatabase.instance.ref('productos');
    productoRef.onValue.listen((event) {
      final data = event.snapshot.value;
      updateProductList(data);
    });
  }

  void updateProductList(Object? data) {
    if (data != null) {
      List<Map<dynamic, dynamic>> tempList = [];

      if (data is Map) {
        data.forEach((key, value) {
          tempList.add({
            "producto": value['producto'],
            "precio": value['precio'],
            "categoria": value['categoria'],
            "imagen": value['imagen'],
            "video": value['video'],
          });
        });
      } else if (data is List) {
        for (var value in data) {
          if (value is Map) {
            tempList.add({
              "producto": value['producto'],
              "precio": value['precio'],
              "categoria": value['categoria'],
              "imagen": value['imagen'],
              "video": value['video'],
            });
          }
        }
      }

      setState(() {
        productList = tempList;
      });
    }
  }

  void _playYoutubeVideo(String videoUrl) {
    String videoId = YoutubePlayer.convertUrlToId(videoUrl)!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Trailer'),
            backgroundColor: Color.fromARGB(255, 72, 65, 165),
          ),
          body: Center(
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Películas'),
        backgroundColor: Color.fromARGB(255, 72, 65, 165),
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: InkWell(
              onTap: () {
                _playYoutubeVideo(product['video']);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: product['imagen'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['producto'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 4, 0, 43),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Precio: \$${product['precio']}',
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            'Categoría: ${product['categoria']}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 65, 167, 218),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
