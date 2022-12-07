import 'package:flutter/material.dart';
import 'package:stock_management/controller/gsheet_controller.dart';

class EditGsheet extends StatefulWidget {
  final String name, email, phone, update;
  final String id;
  const EditGsheet(
      {Key? key, required this.name, required this.email, required this.phone, required this.id, required this.update})
      : super(key: key);

  @override
  State<EditGsheet> createState() => _EditGsheetState();
}

class _EditGsheetState extends State<EditGsheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  @override
  void initState() {
    nameController.text =widget.name;
    emailController.text = widget.email;
    mobileNoController.text = widget.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Gsheet Data"),),
      body: Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
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
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null) {
                return 'Enter Email';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: mobileNoController,
            validator: (value) {
              if (value == null) {
                return 'Enter Phone Number';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Contact'),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: updateForm, child: const Text("Submit")),
        ],
      ),
    ));
  }

    // Method to Submit and save it in Google Sheets
  void updateForm() {
      FormController formController = FormController();
      // Submit 'form' and save it in Google Sheets.
      widget.update == "first" ?
      formController.updateForm(
        widget.id.toString(),
        widget.name,
        nameController.text,
        widget.email,
        emailController.text,
        widget.phone,
        mobileNoController.text,
    ) : 
    formController.updateForm2(
        widget.id.toString(),
        widget.name,
        nameController.text,
        widget.email,
        emailController.text,
        widget.phone,
        mobileNoController.text,
    );
  }
}
