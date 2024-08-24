

import 'dart:io';

import '../reportes.dart';

abstract class Account {
  final String accountNumber;
  double _balance = 0;
  List<Reports> transactions=[];
  String statusAccount="open";
  
  Account(this.accountNumber)
  {}
  //ايداع
 void deposit(double amount) {
  if(statusAccount=="open"){
    if (amount > 0) {
      _balance += amount;
      Reports r = Reports();
      r.addTeransection(getDate(),amount,"deposit",getBalance);
      print("${r.date}/${r.amount}/${r.type}/ ${r.balance}");
       transactions.add(r);/////////// اضها عن طريق كائن
    } else {
      print('Invalid deposit amount.');
    }
  }
  else
  print("account is closed");
  } 
  //السحب
 void  withdraw(double amount) {
  if(statusAccount=="open"){
    if (amount > 0 && amount <= getBalance) {
      _balance -= amount;
      Reports r = Reports();
      r.addTeransection(getDate(),amount,"withdraw",getBalance);
     transactions.add(r);
    } else {
      print('Insufficient funds or invalid withdrawal amount.');
    }
  }
  else
  print("account is closed");
  }
  // تحويل اموال
  void transfer(Account toAccount, double amount) {
    if(statusAccount == "open"){
    if (amount > 0 && amount <= getBalance) {
      withdraw(amount);
      toAccount.deposit(amount);
      
      Reports r = Reports();
      r.addTeransection(getDate(),amount,"Transfer to ${toAccount.accountNumber}",getBalance);
     transactions.add(r);
    } else {
      print('Insufficient funds or invalid transfer amount.');
    }
    }
  else
  print("account is closed");
  }
  
get getBalance => _balance;
set balance(double value)=>_balance;

addToFile(Reports r){
  File file = File("${accountNumber}.txt");
   file.createSync(recursive: true);
   file.writeAsString("${DateTime.now()}-${r.amount}-'Deposit'-${getBalance}\n ",mode: FileMode.append);
}
showAllReports(String accountInput){
  if (accountNumber == accountInput)
  {
    File file = File("${accountNumber}.txt");
    String fileContent = file.readAsStringSync();
  }
} 
String getDate(){
 late String date;
DateTime now = DateTime.now();
date = now.day.toString()+"-";
date =date+ now.month.toString()+"-";
date =date+ now.year.toString();
return date;
}
showReportWithDate(){}
}
 