import 'dart:convert';
import 'package:http/http.dart' as http;

class getData {
  Future<List<dynamic>> getGames(String liga) async {

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

  Future<List<dynamic>> getStatistics() async {

    var response = await http.get(
        Uri.encodeFull("https://venados.dacodes.mx/api/statistics"),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> map = json.decode(response.body);

    List<dynamic> data = map["data"]["statistics"];

    return data.toList();
  }

  Future<List<dynamic>> getPlayers() async {

    var response = await http.get(
        Uri.encodeFull("https://venados.dacodes.mx/api/players"),
        headers: {"Accept": "application/json"});

    Map<String, dynamic> map = json.decode(response.body);

    List<dynamic> data = map["data"]["team"]["forwards"];

    return data.toList();
  }

}