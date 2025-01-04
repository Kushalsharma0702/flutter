// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(EcoTrackApp());

class EcoTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double transportation = 0;
  double energy = 0;
  double diet = 0;
  double carbonFootprint = 0;
  List<String> tips = [];

  Future<void> calculateFootprint() async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/calculate'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "transportation": transportation,
        "energy": energy,
        "diet": diet,
      }),
    );
    final data = json.decode(response.body);
    setState(() {
      carbonFootprint = data['carbonFootprint'];
    });
  }

  Future<void> fetchTips() async {
    final response = await http.get(Uri.parse('http://localhost:3000/tips'));
    final data = json.decode(response.body);
    setState(() {
      tips = List<String>.from(data['tips']);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoTrack'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculate Your Carbon Footprint',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildInputField('Transportation (km/day)', (value) {
              transportation = double.tryParse(value) ?? 0;
            }),
            buildInputField('Energy Usage (kWh/day)', (value) {
              energy = double.tryParse(value) ?? 0;
            }),
            buildInputField('Diet (meals/day)', (value) {
              diet = double.tryParse(value) ?? 0;
            }),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: calculateFootprint,
              child: Text('Calculate Footprint'),
            ),
            SizedBox(height: 20),
            Text(
              'Your Carbon Footprint: ${carbonFootprint.toStringAsFixed(2)} kg CO₂/day',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              'Tips to Reduce Your Footprint',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...tips.map((tip) => ListTile(
                  leading: Icon(Icons.eco, color: Colors.green),
                  title: Text(tip, style: TextStyle(fontSize: 16)),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, color: Colors.white)),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          keyboardType: TextInputType.number,
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
