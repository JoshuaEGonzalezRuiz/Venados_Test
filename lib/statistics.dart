import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:venados_test/methods/methods.dart';

class Statistics extends StatefulWidget {
  Statistics({Key key}) : super(key: key);
  @override
  _StatisticsState createState() => new _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var method = getData();

  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: method.getStatistics(),
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
          return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(2, 0, 80, 10),
                          child: Text(
                              'Tabla General',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 2, 10),
                          child: Text('JJ',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 0, 2, 10),
                          child: Text('DG',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 0, 2, 10),
                          child: Text('PTS',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot == null ? 0 : snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {

                              String equipo = snapshot.data[index]["team"].toString();
                              if(equipo.length > 7){
                                equipo = equipo.replaceRange(8, equipo.length, '');
                                print(equipo);
                              }

                              return Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                                      decoration: BoxDecoration(color: Colors.green),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index]["position"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[

                                                Container(
                                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                  child: Image.network(
                                                    snapshot.data[index]["image"].toString(),
                                                    height: 50,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                                                  child: Text(
                                                    equipo,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]["games"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data[index]["score_diff"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data[index]["points"].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ))
                                ],
                              );
                            }),
                      )
                  )
                ],
              );
        });
  }
}
