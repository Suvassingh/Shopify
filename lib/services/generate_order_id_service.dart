import 'dart:math';

String generateOrderId(){
  DateTime now = DateTime.now();

  int randonNumbers = Random().nextInt(99999);
  String id  ='${now.microsecondsSinceEpoch} $randonNumbers';
  return id ;
}