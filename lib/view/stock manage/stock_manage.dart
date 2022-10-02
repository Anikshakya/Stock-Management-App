import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import '../../controller/stock_manage_controller.dart';

class StockManage extends StatefulWidget {
  const StockManage({ Key? key }) : super(key: key);

  @override
  State<StockManage> createState() => _StockManageState();
}

class _StockManageState extends State<StockManage> {
  final StockManageController stockManageController = Get.put(StockManageController());

  //Text Field Control
  var formKey = GlobalKey<FormState>();
  final buyingPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final quantityController = TextEditingController();
  final transactionDateController = TextEditingController();
  final transactionTypeController = TextEditingController();
  var stocksDropDown = "Select Stock";

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  initializeData(){
    stockManageController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
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
                              controller: buyingPriceController,
                              decoration:const InputDecoration(hintText: "Buying Price"),
                              autovalidateMode:AutovalidateMode.onUserInteraction,
                              validator: (contact) => contact!.isEmpty
                                  ? "Buying Price cannot be empty."
                                  : null,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: sellingPriceController,
                              decoration:const InputDecoration(hintText: "Selling Price"),
                              autovalidateMode:AutovalidateMode.onUserInteraction,
                              validator: (contact) => contact!.isEmpty
                                  ? "Selling Price cannot be empty."
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
                              controller: transactionTypeController,
                              decoration:const InputDecoration(hintText: "Transaction Type"),
                              autovalidateMode:AutovalidateMode.onUserInteraction,
                              validator: (contact) => contact!.isEmpty
                                  ? "Transaction Type cannot be empty."
                                  : null,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      content: ElevatedButton(
                        onPressed: uploadStock,
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
                  },
                ),
              );
            },
            child: const Text("ADD", style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Column(
        children: [
          //Header
          Card(
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Stock Name', style: TextStyle(color: Colors.white),),
                  Text('Quantity', style: TextStyle(color: Colors.white),),
                  Text('Buying Price', style: TextStyle(color: Colors.white),),
                  Text('Selleing Price', style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),
          //Stock List that has been added
          Expanded(child: stockLists()),

          //Totals section
          Card(
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Total Buying Price:', style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Total Selling Price:', style: TextStyle(color: Colors.white),
                  ),

                  // Text(
                  //   'Total Buying Price:${stockManageController.stockList.reduce((value, element) => value + element.buyingPrice)}', 
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // Text(
                  //   'Total Selling Price:${stockManageController.stockList.reduce((value, element) => value + element.sellingPrice)}',
                  //   style: TextStyle(color: Colors.white),
                  // ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget stockLists(){
    return GetBuilder(
      init: StockManageController(),
      builder: (_){
        return Obx(
          ()=> stockManageController.isLoading.value
          ? SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: const Center(child: CircularProgressIndicator( color: Colors.black,),),
          )
          : ListView.builder(
            itemCount: stockManageController.stockList.length,
            itemBuilder: (BuildContext context, index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(stockManageController.stockList[index].stockName),
                      Text(stockManageController.stockList[index].quantity),
                      Text(stockManageController.stockList[index].buyingPrice),
                      Text(stockManageController.stockList[index].sellingPrice),
                    ],
                  ),
                ),
              );
            }
          )
        );
      }
    );
  }

  //Add New Stocks to firebase
  uploadStock() async{
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

    DocumentReference documentReferencer = FirebaseFirestore.instance.collection("stocks").doc(stocksDropDown.trim());
    Map<String, dynamic> data = {
      'stock_name':stocksDropDown.trim(),
      'buying_price':buyingPriceController.text.trim().toString(),
      'selling_price':buyingPriceController.text.trim().toString(),
      'transaction_date':transactionDateController.text.trim().toString(),
      'quantity':quantityController.text.trim().toString(),
      'transaction_type':transactionTypeController.text.trim().toString(),

    };
    await documentReferencer.set(data).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));
    stockManageController.getData();
  }

  //Date And Time Picker
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
        });
      }, 
      currentTime: DateTime.now(), locale: LocaleType.en
    );
  }
}