abstract class User{
  late String name,email,password;
  User(  this.name, this.email, this.password);
  login({required String email,required String password}){
    
  }
  registration(String name, String email,  String password){
    this.email=email;
    this.password=password;
    this.name=name;
  }
  logout(){
    
  }


}