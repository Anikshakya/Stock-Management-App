import 'package:flutter/material.dart';
import 'package:stock_management/Dashboard/view_gsheet_data.dart';
import 'package:stock_management/controller/gsheet_controller.dart';
import 'package:stock_management/model/gsheet_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25,40,25,0),
        child: Column(
          children: [
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
        ),)
    );
  }

  // Method to Submit and save it in Google Sheets
  void submitForm() {
    GoogleSheetModel feedbackForm = GoogleSheetModel(
          nameController.text,
          emailController.text,
          mobileNoController.text,);

      FormController formController = FormController();


      // Submit 'form' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        debugPrint("Response: $response");
        if (response == FormController.status) {
          // Feedback is saved succesfully in Google Sheets.
          debugPrint("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          debugPrint("Error Occurred!");
        }
      }
    );
  }
}