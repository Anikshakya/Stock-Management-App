import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management/view/Dashboard/dashboard.dart';
import 'package:stock_management/view/crud/crud.dart';
import 'package:stock_management/view/stock%20manage/stock_manage.dart';

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
          actions: [
            TextButton(onPressed: ()=>Get.to(()=>const StockManage()), child: const Text("New CRUD page", style: TextStyle(color: Colors.white),))
          ],
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