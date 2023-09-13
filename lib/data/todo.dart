class Todo {
 final String email ;
  final String title;
  final String subtitle ;
  final  DateTime date ;
  final bool done ;
  final String image ;

  Todo({ required this.email, required this.title , required this.subtitle , required this.date , required this.done , required this.image});
  factory Todo.fromJson(Map<String, dynamic> json) {
   return Todo(
       email: json['email'],
       title: json['title'],
       subtitle: json['subtitle'],
       date: json['date'].toDate(),
       done: json['done'],
       image: json['image'],
       );

  }

  toJson() {
   return {
    'email' : email ,
    'title' : title ,
    'subtitle' : subtitle ,
    'date' : date ,
    'done' : done ,
    'image'  : image  ,
   };
  }

}