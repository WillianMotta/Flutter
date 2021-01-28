import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infotext = "Informe seus dados!";

  void _resetField(){
    weigthController.text = "";
    heigthController.text = "";
    setState(() {
      _infotext = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calc(){
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;
      double imc = weigth / (heigth * heigth);
      if(imc < 18.6){
        _infotext = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc>=18.6 && imc < 24.9){
        _infotext = "Peso ideal (${imc.toStringAsPrecision(2)})";
      }else if(imc >=24.9 && imc < 29.9 ){
        _infotext = "Levemente acima do peso (${imc.toStringAsPrecision(2)})";
      }else if(imc >=29.9 && imc < 34.9){
        _infotext = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      }else if(imc >= 34.9 && imc < 39.9 ){
        _infotext = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      }else if (imc >= 40){
        _infotext = "Obesidade grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weigthController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heigthController,
                // ignore: missing_return
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 13.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed:(){
                      if(_formKey.currentState.validate()){
                        _calc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infotext,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
