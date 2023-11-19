import 'package:api_cotacao/src/controller/moeda_controller.dart';
import 'package:api_cotacao/src/models/moeda_model.dart';
import 'package:flutter/material.dart';

class MoedaPage extends StatefulWidget {
  const MoedaPage({super.key});

  @override
  State<MoedaPage> createState() => _MoedaPageState();
}

class _MoedaPageState extends State<MoedaPage> {
  final controller = MoedaController();
  var input = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getMoedas();
    });
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  Future<MoedaModel?> _selectMoeda(MoedaModel model) {
    return showModalBottomSheet<MoedaModel>(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return ListView.builder(
              itemCount: controller.value.moedas.length,
              itemBuilder: (context, index) {
                final innerMoeda = controller.value.moedas[index];
                return ListTile(
                  title: Text(innerMoeda.name),
                  selected: innerMoeda == model,
                  onTap: () {
                    Navigator.of(context).pop(innerMoeda);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de moedas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Moeda',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => input = value,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: state.moedaIn.code.isNotEmpty,
                  replacement: GestureDetector(
                    onTap: () async {
                       final moeda = await _selectMoeda(state.moedaIn);
                      if (moeda != null) {
                        controller.selecionarMoedaIn(moeda);
                      }
                    },
                    child: Text("Selecione a moeda")),
                  child: ElevatedButton(
                    onPressed: () async {
                      final moeda = await _selectMoeda(state.moedaIn);
                      if (moeda != null) {
                        controller.selecionarMoedaIn(moeda);
                      }
                    },
                    child: Text(state.moedaIn.code),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: controller.switchMoedas,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final moeda = await _selectMoeda(state.moedaOut);
                    if (moeda != null) {
                      controller.selecionarMoedaOut(moeda);
                    }
                  },
                  child: Text(state.moedaOut.code),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.converter(input),
              child: Text('Resultado: ${state.result}'),
            )
          ],
        ),
      ),
    );
  }
}