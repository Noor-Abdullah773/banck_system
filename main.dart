
import 'dart:io';
import 'accounts/account.dart';
import 'accounts/bussinessAcount.dart';
import 'accounts/saveingAccount.dart';
import 'reportes.dart';
import 'users/admin.dart';
import 'users/customer.dart';
import 'users/user.dart';

main(){ 
bool chose = true;
 late int numList1;
 late int numList2;
 late int firstList;
 Customer c;
 late String accountNumber;
    
    print("1]Customer");
    print("2]Admin");
    print("Your choice :");
    firstList = int.parse(stdin.readLineSync()!);
    switch(firstList)
    {
    case 1 :{
    print("1]sign in");
    print("2]login");
    print("Your choice :");
    numList1 = int.parse(stdin.readLineSync()!);
    switch(numList1)
    {
      case 1 :{c= getSignIn();
                createFileCustomers(c);
                print("enter account number");
                accountNumber = stdin.readLineSync()!;
                print("1]create saveing account");
                print("2]create bussiness account");
                print("Your choice :");
                numList2 =int.parse(stdin.readLineSync()!);
                switch(numList2){
                  case 1 : {
                    SaveingAccount s = SaveingAccount(accountNumber);
                    addAccount( c , s);
                    createFileAccount(s, c);
                    showServices(c,s);
                  }
                  break;
                  case 2 : {
                     BussineccAcount b = BussineccAcount(accountNumber);
                     addAccount( c , b);
                     createFileAccount(b, c);
                     showServices(c,b);
                  }
                  break;

                }
      } 
      break;
      case 2 :
      {  late String email,password;
        print("enter your email :");
         email=stdin.readLineSync()!;
        print("enter your password :");
        password=stdin.readLineSync()!;
        if(getLogin(email ,password)) 
      {     
          print("enter account number");
          accountNumber = stdin.readLineSync()!;
          fechCustomerInformation(email ,password);
          fechCustomerAccount( fechCustomerInformation(email ,password),accountNumber);


      }
      else 
      print("you do not signed in ");
                
      
    }
    }


  }

  //////// admin
      }
      
     
 
}
 
 String reciveCountNumber(){
  String a = stdin.readLineSync()!;
  return a;
 }



 Customer getSignIn(){
    late String name ,email,password,address,idNumber;
    print("enter your name :");
    name = stdin.readLineSync()!;
    print("enter your email :");
    email = stdin.readLineSync()!;
    print("enter your password :");
    password = stdin.readLineSync()!;
    print("enter your address :");
    address = stdin.readLineSync()!;
    print("enter your idNumber :");
    idNumber = stdin.readLineSync()!;
   Customer c =Customer(name, email, password, address,idNumber);
   return c;
  }
/*userLogin(User u,String email,String password){ // تعدد اشكال
 u.login(email: email, password: password);
}*/

createFileCustomers(Customer c){
File file = File("customers.txt");
file.createSync(recursive: true);

file.writeAsString("${c.name}-${c.email}-${c.password}-${c.address}-${c.idNumber}\n",mode: FileMode.append);
print("${c.name}-${c.email}-${c.password}-${c.address}-${c.idNumber}");

}
createFileAccount(Account  acoountCustomer1,Customer customer1)
{
  File file = File("${acoountCustomer1.accountNumber}.txt");
 file.createSync(recursive: true);
 file.writeAsString("${acoountCustomer1.accountNumber}-${acoountCustomer1.getBalance}-${customer1.idNumber}-${customer1.address}");
}
addAccount(Customer c , Account a)// تعدد اشكال
{
  c.addAcount(a);
}
showServices(Customer c,Account a)
{ String choice="yes";
 late int list3;
 late int indx;
 indx = getIndexAccount(c, a); 
  while(choice == "yes")
  {
    print("1]To deposit");
    print("2]To withdraw");
    print("3]To transfer");
    print("4]get balance");
    print("5]show all report");
    print("your choice");
    list3 = int.parse(stdin.readLineSync()!);
    switch(list3){
      case 1 : c.customerAccounts[indx].deposit(getAmount());
      break;
      case 2 : c.customerAccounts[indx].withdraw(getAmount());
      break;
      case 3 :/*{Account a ;
         a = getSecondAccount();
         c.customerAccounts[indx].transfer(a, getAmount())
         };*/
      break;
      case 4  : print(c.customerAccounts[indx].getBalance);
 
    }
    print("Do you whant complate? yes/no");
    choice = stdin.readLineSync()!;
    addToFileReports(c ,a);
  }
}
addToFileReports(Customer c , Account a){
  File file = File("${a.accountNumber}.txt");
   file.createSync(recursive: true);
   c.customerAccounts[0].transactions.forEach((element) {
    print("${element.date}/${element.amount}/${element.type}/ ${element.balance}");
    file.writeAsString("${element.date}/${element.amount}/${element.type}/${element.balance} \n",mode: FileMode.append);
   });
   
}
double getAmount(){
 late double amount;
 print("enter the amount : ");
 amount=double.parse(stdin.readLineSync()!);
 return amount;
}
getIndexAccount(Customer c ,Account a)
{ late int index;
  
for(int i=0;i<c.customerAccounts.length;i++)
{
   if(c.customerAccounts[i].accountNumber==a.accountNumber);
   {
    index =i;
   } 
}
return index;
 
}
bool getLogin(String email ,String password){
  bool isFound=false;
  File file = File("customers.txt");
 final List<String>content=file.readAsLinesSync();
 for(var v in content)
 {
  List<String>s= v.split("-");
  if(s[1]== email && s[2]==password)
  isFound = true;

 }
return isFound;
 
}
fechCustomerInformation(String emailCus,String passCus){
  late String name ,address,idNumber;
  File file = File("customers.txt");
 final List<String>content=file.readAsLinesSync();
 for(var v in content)
 {
  List<String>s= v.split("-");
  if(s[1]== emailCus && s[2]==passCus)
  {
    name=s[0];
    emailCus=s[1];
    passCus=s[2];
    address=s[3];
    idNumber=s[4];
  }
 }
 Customer c = Customer(name,emailCus,passCus,address, idNumber);
 return c;
}
fechCustomerAccount(Customer c ,String customerAccount)
{
  String fileName ="${customerAccount}.txt"; 
  if (File(fileName).existsSync()) {
    print('الملف $fileName موجود.');
  } else {
    print('الملف $fileName غير موجود.');
  }
}