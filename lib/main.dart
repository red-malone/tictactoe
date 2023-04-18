import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TICTACTOE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TICTACTOE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int X=0;
  int Y=0;
  bool _turnO=false;
  int filled=0;
  final List<String> _xolist=['','','','','','','','',''];

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TICTACTOE"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed:(){}, icon: Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            _score(),
            _grid(),
            _turn(),
          ],
        ),
      ),
    );

  }

  Widget _score(){
    return Expanded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Player X',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w800),),
                    SizedBox(height: 2),
                    Text("Score",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                  ],
                ),

              ),
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Player O',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w800),),
                    SizedBox(height: 2),
                    Text("Score",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                  ],
                ),

              ),




            ],
          ),
        ),
    );
  }
  Widget _grid(){
    return Expanded(
      flex: 3,
        child:GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:3 ),
            itemBuilder:(BuildContext context,int index){
              return GestureDetector(
                onTap:(){},
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      _xolist[index],style: TextStyle(
                      color: _xolist[index] =='x' ? Colors.amber : Colors.blue,
                      fontSize: 10,
                    ),
                    ),
                  ),

                ),
              );
            }

        ),
    );
  }
  Widget _turn(){
    return Expanded(
      flex: 0,
        child:Padding(
          padding: EdgeInsets.all(15),
          child: Center(child: Text( _turnO ? "Y Turn" : "X Turn",
            style: TextStyle(fontSize:20,fontWeight: FontWeight.w600 ),),
          ),
        ),
    );
  }
}
