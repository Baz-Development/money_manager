import 'package:currency_picker/currency_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_calculator/flutter_dynamic_calculator.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/repository/firebase_transactions_repository.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  _AddBalanceScreenState createState() => _AddBalanceScreenState();
}
class _AddBalanceScreenState extends State<AddBalanceScreen>{
  var _colorTypeButton = Colors.green;
  var _textTypeButton = "Receitas";
  var _imageTypeButton = "icons/receita_icon.png";
  double? _currentValue = 0;
  var _currency = "BRL";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_colorTypeButton)
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            debugPrint("Receita tap");
                            setState(() {
                              _colorTypeButton = Colors.green;
                              _textTypeButton = "Receitas";
                              _imageTypeButton = "icons/receita_icon.png";
                            });
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            leading: ImageIcon(
                              AssetImage("icons/receita_icon.png"),
                            ),
                            title: Text("Receitas"),
                          )
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("Investimento tap");
                            setState(() {
                              _colorTypeButton = Colors.green;
                              _textTypeButton = "Investimentos";
                              _imageTypeButton = "icons/investimento.png";
                            });
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            leading: ImageIcon(
                              AssetImage("icons/investimento.png"),
                            ),
                            title: Text("Investimentos"),
                          )
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("Despesa tap");
                            setState(() {
                              _colorTypeButton = Colors.red;
                              _textTypeButton = "Despesas";
                              _imageTypeButton = "icons/despesa_icon.png";
                            });
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            leading: ImageIcon(
                              AssetImage("icons/despesa_icon.png"),
                            ),
                            title: Text("Despesas"),
                          )
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("Despesa cartão tap");
                            setState(() {
                              _colorTypeButton = Colors.red;
                              _textTypeButton = "Despesas cartão";
                              _imageTypeButton = "icons/despesa_cartao.png";
                            });
                            Navigator.pop(context);
                          },
                          child: const ListTile(
                            leading: ImageIcon(
                              AssetImage("icons/despesa_cartao.png"),
                            ),
                            title: Text("Despesa cartão"),
                          )
                        ),
                      ],
                    ),
                  );
                }
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_textTypeButton),
              const SizedBox(
                width: 5,
              ),
              ImageIcon(
                AssetImage(
                  _imageTypeButton,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(18, 20, 29, 1),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Receita",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        debugPrint("Valor keyboard open");
                        showCalculatorBottomSheet();
                      },
                      child: Text(
                        formatCurrency(_currentValue ?? 0),
                        style: const TextStyle(
                            fontSize: 28,
                            color: Colors.grey
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(18, 20, 29, 1))
                      ),
                      onPressed: () {
                        showCurrencyPicker(
                          context: context,
                          showFlag: true,
                          showCurrencyName: true,
                          showCurrencyCode: true,
                          onSelect: (Currency currency) {
                            debugPrint('Select currency: ${currency.name}');
                            setState(() {
                              _currency = currency.code;
                            });
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      label: Text(
                        _currency,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 25
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            color: Colors.grey,
            child: const Text("teste")
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  ),
                ),
                onPressed: (){
                  debugPrint("Continuar");
                  // addBalance();
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  Future showCalculatorBottomSheet() {
    var calc = DynamicCalculator(
      value: _currentValue ?? 0,
      hideExpression: false,
      hideSurroundingBorder: true,
      showCalculatorDisplay: true,
      autofocus: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? 0;
        });
        debugPrint('$key\t$value\t$expression');
      },
      onTappedDisplay: (value, details) {
        debugPrint('$value\t${details.globalPosition}');
      },
      theme: const CalculatorTheme(
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        displayCalculatorRadius: 10.0,
        displayBackgroundColor: Colors.white,
        displayStyle: TextStyle(fontSize: 30, color: Colors.green),
        expressionBackgroundColor: Colors.black12,
        expressionStyle: TextStyle(fontSize: 14, color: Colors.black45),
        operatorColor: Colors.green,
        operatorStyle: TextStyle(fontSize: 24, color: Colors.white),
        commandColor: Colors.white,
        commandStyle: TextStyle(fontSize: 24, color: Colors.green),
        numColor: Colors.white,
        numStyle: TextStyle(fontSize: 24, color: Colors.black87),
      ),
    );

    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 2,
                offset:
                const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 26.0, right: 26.0),
              child: calc,
            )
          ),
        );
      }
    );
  }

  String formatCurrency(double currency) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: currency,
        settings: MoneyFormatterSettings(
            symbol: 'R\$',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.long
        )
    );
    return fmf.output.symbolOnLeft;
  }

  void createTransactionInDB() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    var transaction = Transactions(_currentValue!, _currency, _textTypeButton, userId!, null);
    await createTransaction(transaction);
  }

  void addBalance() {
    createTransactionInDB();
  }
}