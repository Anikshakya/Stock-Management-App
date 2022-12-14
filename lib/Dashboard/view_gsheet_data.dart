import 'package:flutter/material.dart';
import 'package:stock_management/Dashboard/edit_gsheet_data.dart';
import 'package:stock_management/controller/gsheet_controller.dart';
import 'package:stock_management/model/gsheet_model.dart';

class GsheetView extends StatefulWidget {
  const GsheetView({ Key? key }) : super(key: key);

  @override
  State<GsheetView> createState() => _GsheetViewState();
}

class _GsheetViewState extends State<GsheetView> {
  List<GoogleSheetModel> items = [];
    
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();
    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        items = feedbackItems;
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
        child: items.isEmpty ? SizedBox(
          height: MediaQuery.of(context).size.height-kToolbarHeight,
          child: const Center(child: CircularProgressIndicator(),)
        ) :
        Container(
          padding: const EdgeInsets.fromLTRB(5,10,10,10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if(index != 0){
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditGsheet(
                        id: items[index].id.toString(),
                        name: items[index].name.toString(), 
                        email: items[index].email.toString(),
                        phone: items[index].mobileNo.toString(),
                        update: "first",
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
                          child: Text(items[index].name.toString()),
                        )
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      const Icon(Icons.email),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Text(items[index].email.toString()),
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