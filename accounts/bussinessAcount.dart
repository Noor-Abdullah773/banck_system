import '../reportes.dart';
import 'account.dart';

class BussineccAcount extends Account{
  double tax=0.01;
  BussineccAcount(super.accountNumber);
  double calculateTax(){
    return tax*getBalance;
  }
  @override
   withdraw(double amount)
   {
    if(getBalance > 100000000)
    {
      balance  = getBalance - calculateTax();
       Reports r = Reports();
    r.addTeransection(getDate(),calculateTax(),"tax",getBalance);
     transactions.add(r);
    
      super.withdraw(amount);
    }
    else
    super.withdraw(amount);
   }
}