import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:dio/dio.dart';

class getData {
  Future<List<dynamic>> getGames(String liga) async {
    /*Response response = await Dio().get("https://venados.dacodes.mx/api/games",
        options: Options(
          headers: {"Accept": "application/json"},
          sendTimeout: 1000,
          receiveTimeout: 1000,
        ));*/

//    var datos = response.toString();

    /*var jsonObject = (jsonDecode(datos) as List).cast<Map<String, dynamic>>();
    var result = jsonObject.map((e) => e == null ? null : games.map(e));*/

    var response = await http.get(
        Uri.encodeFull("https://venados.dacodes.mx/api/games"),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> map = json.decode(response.body);

    List<dynamic> data = map["data"]["games"];

    List<dynamic> dataCopa = List<dynamic>();

    switch(liga){
      case 'Ascenso MX':
        for(var item in data){
          if(item["league"] != "Copa MX"){
            dataCopa.add(item);
          }
        }
        break;
      case 'Copa MX':
        for(var item in data){
          if(item["league"] != "Ascenso MX"){
            dataCopa.add(item);
          }
        }
        break;
    }

    return dataCopa.toList();
  }
}
