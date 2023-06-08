import 'package:finance/services/api.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  String _typeController = "";

  ApiService api = ApiService();

  Future<bool> _createTransactions() async {
    String title = _titleController.text;
    String value = _valueController.text;
    String type = _typeController;
    // String data = _dataController.text;

    return await api.createTransactions(title, type, value);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _titleController.clear();
    _valueController.clear();
    _dataController.clear();
    _typeController = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      style: Theme.of(context).textTheme.titleSmall,
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
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _valueController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
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
                      style: Theme.of(context).textTheme.titleSmall,
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
                          _typeController =
                              value ?? ''; // Atualiza o valor selecionado
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Data',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _dataController,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma data';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Insira a data',
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
    );
  }
}
