import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management/Dashboard/view_gsheet_data.dart';
import 'package:stock_management/controller/gsheet_controller.dart';
import 'package:stock_management/model/gsheet_model.dart';

class DashboardForm extends StatefulWidget {
  const DashboardForm({ Key? key }) : super(key: key);

  @override
  State<DashboardForm> createState() => _DashboardFormState();
}

class _DashboardFormState extends State<DashboardForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  final FormController formCon = Get.put(FormController());

  @override
  void initState() {
    formCon.getFeedbackList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25,40,25,0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
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
              const SizedBox(height: 20,),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null) {
                    return 'Enter Name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Full Name'
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null) {
                    return 'Enter Email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email'
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: mobileNoController,
                validator: (value) {
                  if (value == null) {
                    return 'Enter Phone Number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Contact'
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                onPressed: submitForm, 
                child: const Text("Submit")
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GsheetView(),));
                }, 
                child: const Text("View Data")
              ),
            ],
          ),),
      )
    );
  }

  // Method to Submit and save it in Google Sheets
  void submitForm() async{
    await formCon.getFeedbackList();
    GoogleSheetModel feedbackForm = GoogleSheetModel(
          (formCon.lastId+1).toString(),
          nameController.text,
          emailController.text,
          mobileNoController.text,
      );
      formCon.submitForm(feedbackForm, (String response) {});
  }
}