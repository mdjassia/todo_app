class Todo {
  final String id ;
 final String email ;
  final String title;
  final String subtitle ;
  final  String date  ;
  final bool done ;



  Todo({required this.id ,  required this.email, required this.title , required this.subtitle , required this.date , required this.done });
  factory Todo.fromJson(Map<String, dynamic> json) {
   return Todo(
       id: json['id'],
       email: json['email'],
       title: json['title'],
       subtitle: json['subtitle'],
       date: json['date'],
       done: json['done'],


       );

  }

  toJson() {
   return {
    'id' : id ,
    'email' : email ,
    'title' : title ,
    'subtitle' : subtitle ,
    'date' : date ,
    'done' : done ,


   };
  }

}