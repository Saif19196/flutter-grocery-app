import 'package:flutter/material.dart';
import 'package:untitled1/pages/dashboard_page.dart';
import 'package:untitled1/utils/cart_icons.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  List<Widget> widgetList = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage()
  ];

  int _index =0;

  @override
Widget build(BuildContext context){
    return Scaffold(appBar: _buildAppBar(),
    bottomNavigationBar: BottomNavigationBar(
      items: [
      BottomNavigationBarItem(
        icon: Icon(
          CartIcons.home,
        ),
        title: Text('Store',style: TextStyle(),
        ),
      ),
        BottomNavigationBarItem(
          icon: Icon(
            CartIcons.cart,
          ),
          title: Text('My Cart',style: TextStyle(),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CartIcons.favourite,
          ),
          title: Text('Favourites',style: TextStyle(),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CartIcons.account,
          ),
          title: Text('My Account',style: TextStyle(),
          ),
        )
      ],
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.shifting,
      currentIndex: _index,
      onTap: (index){
    setState(() {
      _index=index;
    });
      },
    ),
      body: widgetList[_index],
    );
  }
  Widget _buildAppBar(){
    return AppBar(
      backgroundColor: Colors.redAccent,
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text("Azad Essentials",
          style: TextStyle(color: Colors.white),
    ),
    actions: [
      Icon(Icons.notifications_none,color: Colors.white,),
    SizedBox(width: 10),
    Icon(Icons.shopping_cart,color: Colors.white,),
    ],
    );
  }
}