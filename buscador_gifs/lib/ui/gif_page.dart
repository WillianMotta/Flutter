import 'package:flutter/material.dart';
import 'package:share/share.dart';

class gifPage extends StatelessWidget {
  final Map _gifData;
  gifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_gifData["title"],
          style: TextStyle(
              color: Colors.white
          ),
          ) ,
          backgroundColor: Colors.grey,
          actions:<Widget> [
            IconButton(
            icon: Icon(Icons.share),
            onPressed: (){
              Share.share(_gifData["images"]["fixed_height"]["url"]);
            },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(_gifData["images"]["fixed_height"]["url"]),
        )
    );
  }
}
