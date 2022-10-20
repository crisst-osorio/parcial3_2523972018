import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcial3_2523972018/models/marvel_models.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  var marvelApiUrl="https://mcuapi.herokuapp.com/api/v1/movies";
  List<MarvelModels> marvelMovieList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarvelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.home)),
        title: Text('Marvel Movies'),
        centerTitle: true,
        elevation: 5.0,
        shadowColor: Color.fromARGB(255, 114, 109, 107),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        toolbarHeight: 40,
        toolbarOpacity: 0.9,
      ),
      
      backgroundColor: Colors.grey[900],
      body: marvelMovieList.isNotEmpty ?
          GridView.builder(
            itemCount: marvelMovieList.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2/3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
            ),
            
            itemBuilder: (BuildContext context, index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: marvelMovieList[index] .coverUrl.toString(),
                ) 
              );
            }
          )
          : Container(
            width: 50,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white70,),
            ),
          )
    );
  }

  void getMarvelData(){
    // debugPrint('----- Function Running -----');

    final uri = Uri.parse(marvelApiUrl);
    http.get(uri).then((response){
      if(response.statusCode == 200){
        var responseBody = response.body;
        final decodedData = jsonDecode(responseBody);
        final List marvelData = decodedData['data'];
        for (var i = 0; i < marvelData.length; i++) {
          final marvelMovie = MarvelModels.fromJson(marvelData[i] as Map<String, dynamic>);
          marvelMovieList.add(marvelMovie);
          

        }
        setState(() {});


      }else{

      }
    }).catchError((err){
      debugPrint('----- $err -----');
    });
  }
}