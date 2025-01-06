class Usermodel{
   String? id;
  final String? name ;
  final String? email ;

   Usermodel(
    {this.id ,
      required this.name,
      required this.email,
    }
  );

  toJson()
  {
    return{
      "Name" : name ,
      "email" : email
    };
  }

  
}
