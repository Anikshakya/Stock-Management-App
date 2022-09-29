import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({ Key? key }) : super(key: key);

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {

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

  List<int> amountTimesQuantityList = [0];
  List<int> amountList = [0];
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                              'NABIL',
                              'API',
                              'UNI',
                              'SCB'
                            ].map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration:const InputDecoration(hintText: "Amount"),
                            autovalidateMode:AutovalidateMode.onUserInteraction,
                            validator: (contact) => contact!.isEmpty
                                ? "Amount cannot be empty."
                                : null,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: quantityController,
                            decoration:const InputDecoration(hintText: "Quantity"),
                            autovalidateMode:AutovalidateMode.onUserInteraction,
                            validator: (contact) => contact!.isEmpty
                                ? "Quantity cannot be empty."
                                : null,
                          ),
                          TextFormField(
                            controller: transactionDateController,
                            decoration: InputDecoration(
                              hintText: "Transaction Date",
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  dateTimePicker();
                                },
                                child: const Icon(Icons.timer),
                              ),
                            ),
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
        //Table Header
        Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: const [
                Text("Stock"),
                 SizedBox(width: 25,),
                Text("Amount"),
                 SizedBox(width: 25,),
                Text("Quantity"),
                 SizedBox(width: 25,),
                Text("Total Price"),
                 SizedBox(width: 25,),
              ],
            ),
          ),
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
                  // multipliedQuantityList.add(int.parse(firestoreItems[index]['amount'])*int.parse(firestoreItems[index]['transaction_quantity']));
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(firestoreItems[index]['stock_name']),
                              const SizedBox(width: 10,),
                              Text(firestoreItems[index]['amount']),
                              const SizedBox(width: 5,),
                              Text(firestoreItems[index]['transaction_quantity']),
                              // const SizedBox(width: 5,),
                              // Text(multipliedQuantityList[index].toString()),
                              const SizedBox(width: 20,),
                              Text(firestoreItems[index]['transaction_date']),
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
                                    stocksDropDown1 = firestoreItems[index]['stock_name'];
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
                                                    stocksDropDown1.toString(),
                                                  ].map<DropdownMenuItem<String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                                TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: amountController1,
                                                  decoration:const InputDecoration(hintText: "Amount"),
                                                  autovalidateMode:AutovalidateMode.onUserInteraction,
                                                  validator: (contact) => contact!.isEmpty
                                                      ? "Amount cannot be empty."
                                                      : null,
                                                ),
                                                TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: quantityController1,
                                                  decoration:const InputDecoration(hintText: "Quantity"),
                                                  autovalidateMode:AutovalidateMode.onUserInteraction,
                                                  validator: (contact) => contact!.isEmpty
                                                      ? "Quantity cannot be empty."
                                                      : null,
                                                ),
                                                TextFormField(
                                                  controller: transactionDateController,
                                                    decoration: InputDecoration(
                                                    hintText: "Transaction Date",
                                                    suffixIcon: GestureDetector(
                                                      onTap: (){
                                                        dateTimePicker();
                                                      },
                                                      child: const Icon(Icons.timer),
                                                    ),
                                                  ),
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
                                            onPressed: (){
                                              edit(firestoreItems[index]['stock_name']);
                                            },
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
                              IconButton(
                                onPressed: (){
                                  var amount;
                                  var amountTimesQuantity;
                                  if(count == 1){
                                  setState(() {
                                      for(int i = 0; i < firestoreItems.length; i++){
                                      amountList.add(int.parse(firestoreItems[i]['amount']));
                                      amountTimesQuantityList.add(int.parse(firestoreItems[i]['amount'])*int.parse(firestoreItems[i]['transaction_quantity']));
                                      amount = amountList.reduce((value, element) => value + element);
                                      amountTimesQuantity = amountTimesQuantityList.reduce((value, element) => value + element);
                                      count ++;
                                    }
                                    addTotals(amount,amountTimesQuantity);
                                  });
                                  }
                                },
                                icon: const Icon(Icons.add, color: Colors.greenAccent,)
                              ),
                            ],
                          ),
                          // Text("Net Price = ${multipliedQuantityList.reduce((value, element) => value + element)}"),
                        ],
                      ),
                    ),
                  );
                }));
              }
            }
          ),
        ),
        Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("Net Amount = ${amountList.reduce((value, element) => value + element)}"),
                 const SizedBox(width: 25,),
                Text("Net Price = ${amountTimesQuantityList.reduce((value, element) => value + element)}"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  
  upload() async{
    setState(() {
      count = 1;
      amountList.clear();
      amountTimesQuantityList.clear();
      amountList = [0];
      amountTimesQuantityList = [0];
    });
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (stocksDropDown == "Select Stock") {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Select a Stock"),
          backgroundColor: Colors.redAccent,
        )
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

  edit(name) async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    if (stocksDropDown1 == "Select Stock") {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Select a Stock"),
          backgroundColor: Colors.redAccent,
        )
      );
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      DocumentReference documentReferencer = FirebaseFirestore.instance.collection("stock").doc(name);
      Map<String, dynamic> data = {
        'stock_name':stocksDropDown1.trim(),
        'amount':amountController1.text.trim().toString(),
        'transaction_date':transactionDateController1.text.trim().toString(),
        'transaction_quantity':quantityController1.text.trim().toString(),
        'transaction_status':transactionStatusController1.text.trim().toString(),

      };
      await documentReferencer.update(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
  }

  void dateTimePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      onChanged: (date) {
      }, 
      onConfirm: (date) {
        //Set the picked value to the Text controller
        setState(() {
          transactionDateController.text=date.toString();
          transactionDateController1.text=date.toString();
        });
      }, 
      currentTime: DateTime.now(), locale: LocaleType.en);
  }

  addTotals(amt, multiAmt) async{
    DocumentReference documentReferencer = FirebaseFirestore.instance.collection("totals").doc('id');
    Map<String, dynamic> data = {
      'id':'id',
      'total_amount' : amt,
      'total_amountxquantity' :multiAmt,
      };
    await documentReferencer.update(data);
  }
}