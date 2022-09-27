import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final quantityController = TextEditingController();
  final transactionDateController = TextEditingController();
  final transactionStatusController = TextEditingController();
  var stocksDropDown = "Select Stock";

  var amountController1 = TextEditingController();
  var quantityController1 = TextEditingController();
  var  transactionDateController1 = TextEditingController();
  var transactionStatusController1= TextEditingController();
  var stocksDropDown1 = "Select Stock";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: stocksDropDown,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    stocksDropDown = newValue!;
                                  });
                                },
                                items: <String>[
                                  "Select Stock",
                                  'BARUN',
                                  'HIDCL',
                                  'MABIL',
                                  'API',
                                ].map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              TextFormField(
                                controller: amountController,
                                decoration:const InputDecoration(hintText: "Amount"),
                                autovalidateMode:AutovalidateMode.onUserInteraction,
                                validator: (contact) => contact!.isEmpty
                                    ? "Amount cannot be empty."
                                    : null,
                              ),
                              TextFormField(
                                controller: quantityController,
                                decoration:const InputDecoration(hintText: "Quantity"),
                                autovalidateMode:AutovalidateMode.onUserInteraction,
                                validator: (contact) => contact!.isEmpty
                                    ? "Quantity cannot be empty."
                                    : null,
                              ),
                              TextFormField(
                                controller: transactionDateController,
                                decoration:const InputDecoration(hintText: "Transaction Date"),
                                autovalidateMode:AutovalidateMode.onUserInteraction,
                                validator: (contact) => contact!.isEmpty
                                    ? "Date cannot be empty."
                                    : null,
                              ),
                              TextFormField(
                                controller: transactionStatusController,
                                decoration:const InputDecoration(hintText: "Transaction Status"),
                                autovalidateMode:AutovalidateMode.onUserInteraction,
                                validator: (contact) => contact!.isEmpty
                                    ? "Status cannot be empty."
                                    : null,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        content: ElevatedButton(
                          onPressed: upload,
                          child: const Text(
                            "Add Stock",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 238, 238, 238),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              onPrimary: const Color.fromARGB(255, 184, 183, 183),
                              primary: Colors.black),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 12, top: 20),
                      );
                    }
                  ),
                );
              },
              child: const Text("Add"),
            ),
            //Table
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("stock").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        'Loading...',
                      );
                    } else {
                      List<QueryDocumentSnapshot<Object?>> firestoreItems = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: firestoreItems.length,
                        itemBuilder: ((context, index) {
                        
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(firestoreItems[index]['stock_name']),
                                Text(firestoreItems[index]['amount']),
                                Text(firestoreItems[index]['transaction_date']),
                                Text(firestoreItems[index]['transaction_quantity']),
                                Text(firestoreItems[index]['transaction_status']),
                                IconButton(
                                  onPressed: (){
                                    delete(firestoreItems[index]['stock_name']);
                                  }, 
                                  icon: const Icon(Icons.delete, color: Colors.redAccent,)
                                ),
                                 IconButton(
                                  onPressed: (){
                                    setState(() {
                                      amountController1.text = firestoreItems[index]['amount'];
                                      quantityController1.text = firestoreItems[index]['transaction_quantity'];
                                      transactionDateController1.text = firestoreItems[index]['transaction_date'];
                                      transactionStatusController1.text = firestoreItems[index]['transaction_status'];
                                      stocksDropDown = firestoreItems[index]['stock_name'];
                                    });
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: Form(
                                              key: formKey,
                                              child: Column(
                                                children: [
                                                  DropdownButton<String>(
                                                    value: stocksDropDown1,
                                                    icon: const Icon(Icons.arrow_downward),
                                                    elevation: 16,
                                                    style: const TextStyle(color: Colors.deepPurple),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Colors.deepPurpleAccent,
                                                    ),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        stocksDropDown = newValue!;
                                                      });
                                                    },
                                                    items: <String>[
                                                      "Select Stock",
                                                      'BARUN',
                                                      'HIDCL',
                                                      'MABIL',
                                                      'API',
                                                    ].map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                  TextFormField(
                                                    controller: amountController1,
                                                    decoration:const InputDecoration(hintText: "Amount"),
                                                    autovalidateMode:AutovalidateMode.onUserInteraction,
                                                    validator: (contact) => contact!.isEmpty
                                                        ? "Amount cannot be empty."
                                                        : null,
                                                  ),
                                                  TextFormField(
                                                    controller: quantityController1,
                                                    decoration:const InputDecoration(hintText: "Quantity"),
                                                    autovalidateMode:AutovalidateMode.onUserInteraction,
                                                    validator: (contact) => contact!.isEmpty
                                                        ? "Quantity cannot be empty."
                                                        : null,
                                                  ),
                                                  TextFormField(
                                                    controller: transactionDateController1,
                                                    decoration:const InputDecoration(hintText: "Transaction Date"),
                                                    autovalidateMode:AutovalidateMode.onUserInteraction,
                                                    validator: (contact) => contact!.isEmpty
                                                        ? "Date cannot be empty."
                                                        : null,
                                                  ),
                                                  TextFormField(
                                                    controller: transactionStatusController1,
                                                    decoration:const InputDecoration(hintText: "Transaction Status"),
                                                    autovalidateMode:AutovalidateMode.onUserInteraction,
                                                    validator: (contact) => contact!.isEmpty
                                                        ? "Status cannot be empty."
                                                        : null,
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            content: ElevatedButton(
                                              onPressed: edit,
                                              child: const Text(
                                                "Update",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(255, 238, 238, 238),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize: const Size(150, 40),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                                  onPrimary: const Color.fromARGB(255, 184, 183, 183),
                                                  primary: Colors.black),
                                            ),
                                            contentPadding: const EdgeInsets.only(
                                                left: 24, right: 24, bottom: 12, top: 20),
                                          );
                                        }
                                      ),
                                    );
                                  }, 
                                  icon: const Icon(Icons.edit, color: Colors.greenAccent,)
                                ),
                              ],
                            ),
                          ),
                        );
                      }));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  upload() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (stocksDropDown == "Select Stock") {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Text("Select a Stock"),
        ),
      );
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("stock").doc(stocksDropDown.trim());
      Map<String, dynamic> data = {
        'stock_name':stocksDropDown.trim(),
        'amount':amountController.text.trim().toString(),
        'transaction_date':transactionDateController.text.trim().toString(),
        'transaction_quantity':quantityController.text.trim().toString(),
        'transaction_status':transactionStatusController.text.trim().toString(),

      };
      await documentReferencer.set(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
  }

  delete(name){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
     FirebaseFirestore.instance.collection("stock").doc(name).delete().then((value) => Navigator.pop(context));
  }

  edit() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (stocksDropDown == "Select Stock") {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: Text("Select a Stock"),
        ),
      );
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("stock").doc(stocksDropDown.trim());
      Map<String, dynamic> data = {
        'stock_name':stocksDropDown1.trim(),
        'amount':amountController1.text.trim().toString(),
        'transaction_date':transactionDateController1.text.trim().toString(),
        'transaction_quantity':quantityController1.text.trim().toString(),
        'transaction_status':transactionStatusController1.text.trim().toString(),

      };
      await documentReferencer.update(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
  }
}