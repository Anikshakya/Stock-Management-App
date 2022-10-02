import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stock_management/model/stock_manage_model.dart';

class StockManageController extends GetxController{
  RxBool isLoading = false.obs;
  List stockList = <StockManageModel>[];

  getData() async{
    try{
      isLoading(true);
      QuerySnapshot firebaseData = await FirebaseFirestore.instance.collection('stocks').get();
      stockList.clear();
      for(var data in firebaseData.docs){
        stockList.add(
          StockManageModel(
            data['stock_name'], 
            data['transaction_type'],
            data['quantity'],
            data['buying_price'],
            data['selling_price'],
            data['transaction_date']
          )
        );
      }
      update();
      
    }catch(e){
      Get.snackbar("An Error Occured!", e.toString());
    } finally{
      isLoading(false);
    }
  }
}