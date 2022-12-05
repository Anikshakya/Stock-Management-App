import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('totals').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
                return const Text(
                  'Loading...',
                );
              } else {
                List<QueryDocumentSnapshot<Object?>> firestoreItems = snapshot.data!.docs;
                return Column(
                  children: [
                    Text("Total Amount : ${firestoreItems[0]['total_amount']}"),
                    Text("Total Amount : ${firestoreItems[0]['total_amountxquantity']}"),
                  ],
                );
              }
          }
        ),
      ),
    );
  }
}