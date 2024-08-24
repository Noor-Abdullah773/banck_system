import '../accounts/account.dart';
import 'user.dart';

class Customer extends User {
  late String address;
  late String idNumber;

  List<Account> customerAccounts=[];

  Customer(super.name, super.email, super.password,this.address,this.idNumber);  /// يطبق تعدد الاشكال
  addAcount(Account c)
  {
    customerAccounts.add(c);
  }
}