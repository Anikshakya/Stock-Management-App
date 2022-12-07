import 'package:flutter/material.dart';
import 'package:stock_management/Dashboard/edit_gsheet_data.dart';
import 'package:stock_management/controller/gsheet_controller.dart';
import 'package:stock_management/model/gsheet2_model.dart';

class View2 extends StatefulWidget {
  const View2({ Key? key }) : super(key: key);

  @override
  State<View2> createState() => _View2State();
}

class _View2State extends State<View2> {
  List<SheetModel> feedbackItems2 = [];
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    FormController().getFeedbackList2().then((feedbackItems2) {
      setState(() {
        this.feedbackItems2 = feedbackItems2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gsheet View"),
      ),
      body: SingleChildScrollView(
        child: feedbackItems2.isEmpty ? SizedBox(
          height: MediaQuery.of(context).size.height-kToolbarHeight,
          child: const Center(child: CircularProgressIndicator(),)
        ) :
        Container(
          padding: const EdgeInsets.fromLTRB(5,10,10,10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: feedbackItems2.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0){
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditGsheet(
                        id: feedbackItems2[index].id.toString(),
                        name: feedbackItems2[index].fullName.toString(), 
                        email: feedbackItems2[index].emailAddress.toString(),
                        phone: feedbackItems2[index].contact.toString(),
                        update: "Second",
                      );
                    },));
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(bottom:3.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.person),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Text(feedbackItems2[index].fullName.toString()),
                        )
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      const Icon(Icons.email),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(feedbackItems2[index].emailAddress.toString()),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      )
    );
  }
}