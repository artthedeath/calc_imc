import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home:Home() ,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
   
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String info = "Informe seus dados";

  void _ressetFields(){
    weightController.text = "";
    heightController.text = "";
    info = "Informe seus dados";
    _formKey = GlobalKey<FormState>();
  }
  
  void _calculate(){
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);
    height = height/100;
    double imc = weight/(height*height) ;
    var imc_2 = imc.toStringAsFixed(2);
    info = " Seu imc é $imc_2";
    if (imc >= 40) {
      info = info + "\n Obesidade grau III";
      
    } 
    else if( imc >= 35 ) {
      info = info + "\n Obesidade grau II";
    }
    else if( imc >= 30 ) {
      info = info + "\n Obesidade grau I";
    }
    else if( imc >= 25 ) {
      info = info + "\n Sobrepeso";
    }
    else if( imc >= 18.5 ) {
      info = info + "\n Peso normal";
    }
    else  {
      info = info + "\n Abaixo do peso";
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh),
           onPressed: (){
             setState(() {
               _ressetFields();
             });
           })
        ],
      ),
      body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0) ,
              child: Form(
                key: _formKey,
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.fitness_center, size: 120,
            color: Colors.green,),

            TextFormField(keyboardType:TextInputType.number,
            decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso!";
                  }
                } ,
            ),

            TextFormField(keyboardType:TextInputType.number,
            decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                } ,
            ),

            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        setState(() {
                        _calculate();
                          }
                        );
                      } 
                    },
                    child: Text("Calcular",
                     style: TextStyle(color: Colors.white,
                      fontSize: 35 
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
            ),
            Text(info,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green, fontSize: 35),)

        ],),
              ),
      ),
      
    );
  }
}
