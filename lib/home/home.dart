import 'package:flutter/material.dart';
import 'package:stock_management/Dashboard/dashboard.dart';
import 'package:stock_management/crud/crud.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom:  const TabBar(
            tabs: [
              Text('Dashboard'),
              Text('CRUD'),
            ],
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              Dashboard(),
              CrudPage(),
            ],
          ),
        ),
      ),
    );
  }
}