import 'package:flutter/material.dart';
import 'package:parcial3_2523972018/home.dart';

//Cristian Alexander Osorio Martínez
// 25-2397-2018

void main(){
  runApp(MarvelApi());
}

class MarvelApi extends StatelessWidget {
  const MarvelApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Home(),
    );
  }
}
