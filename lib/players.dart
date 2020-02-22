import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:venados_test/methods/methods.dart';

class Players extends StatefulWidget {
  Players({Key key}) : super(key: key);
  @override
  _PlayersState createState() => new _PlayersState();
}

class _PlayersState extends State<Players> {
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

    return FutureBuilder<List<dynamic>>(
          future: method.getPlayers(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
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
            return GridView.builder(
                    padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1, crossAxisCount: 3),
                    shrinkWrap: true,
                    itemCount:
                    snapshot == null ? 0 : snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      initializeDateFormatting();
                      String fechaE = snapshot.data[index]["birthday"].toString();
                      fechaE = fechaE.replaceRange(10, 25, '');
                      DateTime fechaP = DateTime.parse(fechaE);
                      var fechaD = DateFormat('dd/MM/yyyy', 'es_MX').format(fechaP);
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              width: 80,
                              height: 70,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      image: new NetworkImage(
                                          snapshot.data[index]["image"]
                                      )
                                  )
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return Dialog(
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                        BorderRadius.horizontal()),
                                    backgroundColor: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          color: Colors.green.shade800,
                                          height: 350,
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                               Text(
                                                 'FICHA TÉCNICA',
                                                 style: TextStyle(
                                                     color: Colors.white,
                                                   fontStyle: FontStyle.normal,
                                                   fontWeight: FontWeight.normal,
                                                   fontSize: 20
                                                 ),
                                               ),
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      image: new DecorationImage(
                                                          image: new NetworkImage(
                                                              snapshot.data[index]["image"]
                                                          )
                                                      )
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data[index]["name"]} ${snapshot.data[index]["first_surname"]} ${snapshot.data[index]["second_surname"]}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                Text(
                                                  '${snapshot.data[index]["position"]}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 18
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.vertical,
                                                    children: <Widget>[
                                                      Text(
                                                            'FECHA DE NACIMIENTO',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.normal,
                                                                fontSize: 18
                                                            )
                                                        ),
                                                      Text(
                                                          fechaD,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'LUGAR DE NACIMIENTO',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                          )
                                                      ),
                                                      Text(
                                                          '${snapshot.data[index]["birth_place"]}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'PESO',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                          )
                                                      ),
                                                      Text(
                                                          '${snapshot.data[index]["weight"]} KG',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'ALTURA',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                          )
                                                      ),
                                                      Text(
                                                          '${snapshot.data[index]["height"]} M',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'EQUIPO ANTERIOR',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                          )
                                                      ),
                                                      Text(
                                                          '${snapshot.data[index]["last_team"]}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                          'NÚMERO DE CAMISETA',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 18
                                                          )
                                                      ),
                                                      Text(
                                                          '${snapshot.data[index]["number"]}',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontStyle: FontStyle.normal,
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14
                                                          )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                          Text(
                              "${snapshot.data[index]["position"]}"),
                          Text("${snapshot.data[index]["name"]} ${snapshot.data[index]["first_surname"]}", textAlign: TextAlign.center,)
                        ],
                      );
                    });
          });
  }

  Future<List<dynamic>> _refresh() {
    return method.getGames('Copa MX');
  }
}
