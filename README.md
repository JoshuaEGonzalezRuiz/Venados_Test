# venados_test

Aplicación de prueba para DaCodes

## Getting Started

Pasos para construir el proyecto:

 1. Crear un proyecto nuevo de Flutter en Android Studio.

 2. Eliminar el contenido del archivo main y dejar solo lo siguiente.

    void main() => runApp(PrincipalScreen());

 3. Crear un archivo dart que se llamará principal_screen.

 4. Dentro del archivo que se creó anteriormente crear un StatelessWidget con su respectivo StatefulWidget.

    import 'package:flutter/material.dart';
    import 'package:flutter/services.dart';
    import 'package:flutter_icons/flutter_icons.dart';

    int opcion;

    class PrincipalScreen extends StatelessWidget {
      // This widget is the root of your application.
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
     @override
      Widget build(BuildContext context) {}
    }

 5. Ahora crear el archivo que contendrá los métodos get, este archivo se llamará methods.

 6. Dentro de ese archivo escribir lo siguiente.

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

    Nota: agregar las siguientes dependencias en el pubsec.yaml.
    flutter_icons
    add_2_calendar
    intl
    http

 7. Ahora, se debe instanciar la clase getData encima del Widget build del principal_screen.

 8. Para crear el navigation drawer se deberá agregar el siguiente código.

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

 9. Para simular un recicler view se agregará un switch el cual permitirá gestionar el contenido que se mostrará en el body  principal, esto con la finalidad de simplemente mostrar todo el tiempo una sola vista.

    //Observese que se declara un widget llamado screen, el cual contiene los diferentes casos a mostrar en la pantalla principal.

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

    //Se agrega la clase privada _SliverAppBarDelegate la cual se encarga de redimensionar el TabBar.

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

 10. Ahora se crearán los archivos que contendrán la información de los ViewPagers (copa_mx y ascenso_mx).

 11. El contenido del archivo copa_mx será el siguiente.

    import 'package:add_2_calendar/add_2_calendar.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_icons/flutter_icons.dart';
    import 'package:intl/intl.dart';
    import 'package:intl/date_symbol_data_local.dart';

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

 12. El contenido del archivo ascenso_mx será el siguiente.

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

 13. Se proseguirá con la creación del archivo dart llamado players y contendrá el siguiente código.

    import 'package:flutter/material.dart';
    import 'package:intl/intl.dart';
    import 'package:intl/date_symbol_data_local.dart';

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

 14. Ahora se creará el último archivo dart llamado statistics y contendrá el siguiente código:

    import 'package:flutter/material.dart';

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