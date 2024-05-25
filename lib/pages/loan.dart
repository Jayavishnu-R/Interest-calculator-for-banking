import 'package:flutter/material.dart';
import 'dart:math';



class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      home: LoanCalculatorScreen(),
    );
  }
}

class LoanCalculatorScreen extends StatefulWidget {
  @override
  _LoanCalculatorScreenState createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();
  double monthlyPayment = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: loanAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Amount'),
            ),
            TextField(
              controller: interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            ),
            TextField(
              controller: loanTermController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Term (years)'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateMonthlyPayment,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  void calculateMonthlyPayment() {
    double loanAmount = double.tryParse(loanAmountController.text) ?? 0.0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0.0;
    double loanTerm = double.tryParse(loanTermController.text) ?? 0.0;

    double monthlyInterest = interestRate / 100 / 12;
    double numberOfPayments = loanTerm * 12;

    if (loanAmount > 0 && interestRate > 0 && loanTerm > 0) {
      double monthlyPayment = (loanAmount * monthlyInterest) /
          (1 - pow(1 + monthlyInterest, -numberOfPayments));
      setState(() {
        this.monthlyPayment = monthlyPayment;
      });
    } else {
      setState(() {
        this.monthlyPayment = 0.0;
      });
    }
  }
}
