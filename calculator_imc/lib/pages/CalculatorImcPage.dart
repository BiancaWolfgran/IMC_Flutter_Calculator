import 'package:flutter/material.dart';

class CalculatorImcPage extends StatefulWidget {
  const CalculatorImcPage({Key? key}) : super(key: key);

  @override
  State<CalculatorImcPage> createState() => _CalculatorImcPageState();
}

class _CalculatorImcPageState extends State<CalculatorImcPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();


  String _infoText = 'Insira seus dados!';

  String? errorTextHeight;
  String? errorTextWeight;

  void resetFields() {
    heightController.clear();
    weightController.clear();
    setState(() {
      _infoText = 'Insira seus dados!';
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: const Text(
              'Calculadora de IMC',
              style: TextStyle(fontSize: 25),
            ),
            actions: [
              IconButton(
                icon: (const Icon(Icons.refresh)),
                onPressed: resetFields,
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      color: Colors.redAccent,
                      size: 120,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: weightController,
                      decoration: InputDecoration(
                        errorText: errorTextWeight,
                        labelText: 'Peso (Kg)',
                        labelStyle:
                            const TextStyle(color: Colors.redAccent, fontSize: 20),
                      ),

                    ),
                    const SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: heightController,
                      decoration: InputDecoration(
                        errorText: errorTextHeight,
                        labelText: 'Altura (Cm)',
                        labelStyle:
                            const TextStyle(color: Colors.redAccent, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        backgroundColor: Colors.redAccent,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        String text = weightController.text;

                        if(text.isEmpty) {
                          setState(() {
                            errorTextWeight = 'Informe o peso';
                          });
                          return;
                        }

                        text = heightController.text;
                        if(text.isEmpty) {
                          setState(() {
                            errorTextHeight = 'Informe a altura';
                          });
                          return;
                        }

                        setState(() {
                          _calculate();
                          errorTextWeight = null;
                          errorTextHeight = null;
                        });
                      },
                      child: const Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _infoText,
                      style: const TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
