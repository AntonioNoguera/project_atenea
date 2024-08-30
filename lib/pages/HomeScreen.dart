import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          color: Colors.lightBlueAccent, // Establece el color de fondo aquí
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              ElevatedButton(
              onPressed: () {
                print('Button pressed');
              },
              child: Text('Press me'),
            ),

              ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                },
                child: Text('Press me'),
              ),
            ],
          )
        )  ,
      ),
    );
  }
}
