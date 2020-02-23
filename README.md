# Venados_Test
Ejercicio de prueba para DaCodes.

## Requerimientos

1. Crear un proyecto en blanco de Flutter en el IDE de tu preferencia
2. Borrar el contenido del archivo main.dart
3. Seguir las instrucciones al pie de la letra.

## Agregar lo siguiente al archivo main.dart
  ```dart
  import 'package:flutter/material.dart';
  import 'package:venados_test/principal_screen.dart';`

  void main() => runApp(PrincipalScreen());
  ```
## Crear el archivo principal_screen.dart y agregar lo siguiente
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:venados_test/players.dart';
import 'package:venados_test/statistics.dart';

import 'ascenso_mx.dart';
import 'copa_mx.dart';
import 'methods/methods.dart';

int opcion;

class PrincipalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venados Test',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: PrincipalScreenPage(),
      routes: {
        '/principalScreen': (context) => PrincipalScreen()
      },
    );
  }
}

class PrincipalScreenPage extends StatefulWidget {
  PrincipalScreenPage({Key key}) : super(key: key);

  @override
  _PrincipalScreenPageState createState() => _PrincipalScreenPageState();
}

class _PrincipalScreenPageState extends State<PrincipalScreenPage> {

  var methods = new getData();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Jonathan Lee'),
      accountEmail: Text('user.name@email.com'),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          radius: 15.0,
          child: ClipOval(
            child: Image.network('https://s3.amazonaws.com/lmxwebsite/docs/archdgtl/AfldDrct/logos/10732/10732.png'),
          ),
          backgroundColor: Colors.white,
        ),
        onTap: (){
          setState(() {
            opcion = 0;
          });
          Navigator.of(context).pop();
        },
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(MaterialIcons.home),
          title: Text('Home'),
          onTap: () {
            setState(() {
              opcion = 1;
            });
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(Octicons.graph),
          title: Text('Estadísticas'),
          onTap: () {
            setState(() {
              opcion = 2;
            });
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: Icon(MaterialIcons.people),
          title: Text('Jugadores'),
          onTap: () {
            setState(() {
              opcion = 3;
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    return Scaffold(
        body: screen(context, opcion),
        drawer: Drawer(
          child: drawerItems,
        ));
  }
}

Widget screen (BuildContext context, int option){
  switch(option) {
    case 1: //Home
      return new DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIScrolled) {
              return <Widget>[
                SliverAppBar(
                  iconTheme: new IconThemeData(color: Colors.black),
                  backgroundColor: Colors.white,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Center(
                        child: Image.network(
                          'https://s3.amazonaws.com/lmxwebsite/docs/archdgtl/AfldDrct/logos/10732/10732.png',
                          height: 150,
                        ),
                      )
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(),
                          color: Colors.transparent),
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.horizontal(),
                                border: Border.all(color: Colors.green,
                                    width: 4)
                               ),
                            child: Align(
                              child: Text("COPA MX"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.horizontal(),
                                border: Border.all(color: Colors.green,
                                    width: 4)
                                ),
                            child: Align(
                              child: Text("ASCENSO MX"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: false,
                  floating: false,
                ),
              ];
            },
            body: new TabBarView(
                children: [CopaMx(), AscensoMx()
                ]
            ),
          )
      );
      break;
    case 2: //Estadísticas
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            floating: false,
            pinned: false,
          ),
          SliverFillRemaining(
            child: Container(
              child: new Statistics(),
            )
          )
        ],
      );
      break;
    case 3:
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            floating: false,
            pinned: false,
            title: Text('Jugadores', style: TextStyle(color: Colors.black),),
          ),
          SliverFillRemaining(
              child: Container(
                child: new Players(),
              )
          )
        ],
      );
      break;
    default: //Pantalla por defecto
      return new AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white
      );
      break;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
```

## Crear el archivo copa_mx.dart e incluir lo siguiente
```dart
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:venados_test/methods/methods.dart';

class CopaMx extends StatefulWidget {
  CopaMx({Key key}) : super(key: key);
  @override
  _CopaMxState createState() => new _CopaMxState();
}

class _CopaMxState extends State<CopaMx> {

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
        future: method.getGames('Copa MX'),
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
          return RefreshIndicator(
              key: _refreshIndicatorKey,
              child: ListView.builder(
                itemCount: snapshot == null ? 0 : snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  initializeDateFormatting();
                  String fechaE = snapshot.data[index]["datetime"].toString();
                  fechaE = fechaE.replaceRange(10, 25, '');
                  DateTime fechaP = DateTime.parse(fechaE);
                  var fechaD = DateFormat('d', 'es_MX').format(fechaP);
                  var fechaNombreD =
                      DateFormat('EEE', 'es_MX').format(fechaP).toUpperCase();

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
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Text(
                            fechaE,
                            style: TextStyle(
                                backgroundColor: Colors.grey,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(color: Colors.green),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          AntDesign.calendar,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            event.title =
                                                'Partido Venados F.C.';
                                            event.description = '';
                                            event.location = '';
                                            event.startDate = fechaP;
                                            event.endDate =
                                                fechaP.add(Duration(days: 1));
                                            event.allDay = false;
                                          });
                                          Add2Calendar.addEvent2Cal(event)
                                              .then((success) {
                                            print('Evento creado');
                                          });
                                        }),
                                    Text(
                                      fechaD,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      fechaNombreD,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                    Text(
                                      'Venados F.C.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${snapshot.data[index]["home_score"].toString()}-${snapshot.data[index]["away_score"].toString()}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                    Text(
                                      equipo,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
              onRefresh: _refresh);
        });
  }

  Future<List<dynamic>> _refresh() {
    return method.getGames('Copa MX');
  }
}
```

## Crear el archivo ascenso_mx.dart e incluir lo siguiente
```dart
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
```
## Crear el archivo players.dart e incluir lo siguiente
```dart
import 'package:flutter/material.dart';
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
```
