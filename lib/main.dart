import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///* Replace All Charactor in String {0}
  String replaceCharacters(String inputString) {
    return inputString.replaceAll(RegExp(r'[X/+-]'), '0');
  }

  ///* Variable {1}
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  ///* Check Execute InPut And Set And Show to View {2}
  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      num1 = double.parse(output);

      operand = buttonText;

      _output = buttonText;
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        logger.i("Already conatains a decimals");
        return;
      } else {
        _output = replaceCharacters(_output + buttonText);
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = replaceCharacters(_output + buttonText);
    }

    logger.i(_output);

    setState(() {
      output = _output.contains('.')
          ? double.parse(_output).toStringAsFixed(2)
          : _output;
    });
  }

  /// * UI for Button {3} Call {2}
  Widget buildButton(String buttonText) {
    return Expanded(
        child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(24.0),
        textStyle: const TextStyle(
          color: Colors.yellowAccent,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      onPressed: () => buttonPressed(buttonText),
      child: Text(buttonText),
    ));
  }

  ///* Build And Show To App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            ///* Input output Values
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 12.0),
                child: Text(output,
                    style: const TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ))),

            ///*Middle line margin button
            const Expanded(
              child: Divider(
                color: Color.fromARGB(255, 231, 6, 197),
                height: 16.0,
              ),
            ),

            ///* All Button in Calculator
            Column(children: [
              ///Call {3} And Render To View
              Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/")
              ]),
              Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("X")
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
                buildButton("+")
              ]),
              Row(children: [
                buildButton("CLEAR"),
                buildButton("="),
              ])
            ])
          ],
        ));
  }
}
