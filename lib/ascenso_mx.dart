import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'methods/methods.dart';

class AscensoMx extends StatefulWidget {
  AscensoMx({Key key}) : super(key: key);
  @override
  _AscensoMxState createState() => new _AscensoMxState();
}

class _AscensoMxState extends State<AscensoMx> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  var method = getData();

  Widget build(BuildContext context) {

    Event event = Event(
      title: '',
      description: '',
      location: '',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 1)),
      allDay: false,
    );

    return new FutureBuilder<List<dynamic>>(
        future: method.getGames('Ascenso MX'),
        builder: (BuildContext context,
            AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Cargando...',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                  CircularProgressIndicator()
                ],
              ),
            );
          }
          return RefreshIndicator(
              child: ListView.builder(
                itemCount: snapshot == null ? 0 : snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  initializeDateFormatting();
                  String fechaE = snapshot.data[index]["datetime"].toString();
                  fechaE = fechaE.replaceRange(10,25,'');
                  DateTime fechaP = DateTime.parse(fechaE);
                  var fechaD = DateFormat('d','es_MX').format(fechaP);
                  var fechaNombreD =  DateFormat('EEE','es_MX').format(fechaP).toUpperCase();

                  String equipo = snapshot.data[index]["opponent"].toString();
                  if(equipo.length > 7){
                    equipo = equipo.replaceRange(8, equipo.length, '');
                    print(equipo);
                  }

                  return Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.grey
                          ),
                          child: Text(fechaE, style: TextStyle(backgroundColor: Colors.grey, color: Colors.white, fontWeight: FontWeight.bold),)
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.green
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(AntDesign.calendar, size: 25, color: Colors.white,),
                                        onPressed: (){
                                          setState(() {
                                            event.title = 'Partido Venados F.C.';
                                            event.description = '';
                                            event.location = '';
                                            event.startDate = fechaP;
                                            event.endDate = fechaP.add(Duration(days: 1));
                                            event.allDay = false;
                                          });
                                          Add2Calendar.addEvent2Cal(event).then((success) {
                                            print('Evento creado');
                                          });
                                        }
                                    ),
                                    Text(fechaD, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                    Text(fechaNombreD, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),

                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      'https://s3.amazonaws.com/lmxwebsite/docs/archdgtl/AfldDrct/logos/10732/10732.png',
                                      height: 50,
                                    ),
                                    Text('Venados F.C.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('${snapshot.data[index]["home_score"].toString()}-${snapshot.data[index]["away_score"].toString()}', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      '${snapshot.data[index]["opponent_image"].toString()}',
                                      height: 55,
                                    ),
                                    Text(equipo, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),

                            ],
                          )
                      ),
                    ],
                  );
                },
              ),
              onRefresh: _refresh);
        }
    );
  }

  Future<List<dynamic>> _refresh() {
    return method.getGames('Copa MX');
  }
}
