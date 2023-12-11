import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Hesaplayıcı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(key: UniqueKey()),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;

  void calculateBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double heightInMeters = height / 100;
    setState(() {
      bmiResult = weight / (heightInMeters * heightInMeters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Hesaplayıcı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Boy (cm)',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilo (kg)',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (heightController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {
                  calculateBMI();
                } else {
                  // Eksik bilgi uyarısı
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Eksik Bilgi'),
                        content: const Text('Lütfen boy ve kilo giriniz.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Tamam'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Hesapla'),
            ),
            const SizedBox(height: 20),
            Text(
              'BMI Sonucunuz: ${bmiResult.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
