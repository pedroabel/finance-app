import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  String _typeController = "";
  DateTime? _selectedDate;

  ApiService api = ApiService();

  Future<bool> _createTransactions() async {
    String title = _titleController.text;
    double value = double.parse(_valueController.text.replaceAll(',', '.'));
    String type = _typeController;

    return await api.createTransactions(title, type, value);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _valueController.clear();
    _typeController = '';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _valueFormatter =
        FilteringTextInputFormatter.allow(RegExp(r'^\d+([.,]\d{0,2})?$'));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Cadastre uma transação',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Nome',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um nome';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nome da transação',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Preço',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _valueController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [_valueFormatter],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira um preço';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Insira o valor',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Tipo',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Renda',
                            child: Text('Renda'),
                          ),
                          DropdownMenuItem(
                            value: 'Despesa',
                            child: Text('Despesa'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _typeController = value ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Data',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            hintText: 'Selecione a data',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _selectedDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(_selectedDate!)
                                : 'Selecione a data',
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createTransactions();
                            _clearFields();
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 48),
                          ),
                        ),
                        child: const Text('Cadastrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
