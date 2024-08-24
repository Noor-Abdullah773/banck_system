import '../accounts/account.dart';
import 'customer.dart';
import 'user.dart';

class Admin extends User{
  Admin(super.name, super.email, super.password);

  
   openAccount(Customer c,Account a)
   {  a.statusAccount ="open";
      c.addAcount(a);
   }
   CloseAccount(Customer c,Account a)
   {  a.statusAccount ="close";
      c.addAcount(a);
   }
}