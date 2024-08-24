import 'dart:io';
import 'dart:math';

import '../reportes.dart';
import 'account.dart';

class SaveingAccount extends Account{
   int timesOfWithdraw =0;
   double interestRate = 0.02;
  late double interest;

  SaveingAccount(super.accountNumber);

  calculateInterest() { /// حساب الفائدة
     interest = (getBalance * interestRate)  / 12 ;
    
  }
  increamentBalance()
  {
   balance = getBalance + interest;
    Reports r = Reports();
      r.addTeransection(getDate(),interest,"interest",getBalance);
     transactions.add(r);
  
   
  }

  @override
  withdraw(double amount)
  {
    if(checkTimesOfWithdraw() < 5 )
    {
      super.withdraw(amount);
      timesOfWithdraw += timesOfWithdraw;
    }
  }
 int checkTimesOfWithdraw(){ //تصفر عداد عدد مرات السحب
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  if (now.day == firstDayOfMonth.day) 
    timesOfWithdraw = 0;
  return timesOfWithdraw;
  }
  
  DateTime getNextMonthEnd() {
    DateTime now = DateTime.now();
    DateTime nextMonth = DateTime(now.year, now.month + 1);
    return DateTime(nextMonth.year, nextMonth.month, 0);
  }
  
void chekMonth()
{
   if(getNextMonthEnd() == DateTime.now() );
   calculateInterest();
    
}
}