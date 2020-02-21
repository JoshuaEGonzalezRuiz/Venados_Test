import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'ascenso_mx.dart';
import 'copa_mx.dart';
import 'methods/methods.dart';

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

  var methods = new getData();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

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
                          color: Colors.white),
                      indicatorColor: Colors.black,
                      labelColor: Colors.black87,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(),
                                border: Border.all(color: Colors.green,
                                    width: 2)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("COPA MX"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(),
                                border: Border.all(color: Colors.green,
                                    width: 2)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("ASCENSO MX"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: new TabBarView(children: [CopaMx(), AscensoMx()]),
          )
      );
      break;
    case 2: //Estadísticas
      return new Scaffold(
        appBar: new AppBar(
          leading: Icon(Icons.ac_unit),
          iconTheme: new IconThemeData(color: Colors.green),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Text('HOLA'),
        ),
      );
      break;
    default: //Pantalla por defecto
      return new AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
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