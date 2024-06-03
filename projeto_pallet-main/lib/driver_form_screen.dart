import 'package:flutter/material.dart';
import 'shipment_form_screen.dart';

class DriverFormScreen extends StatelessWidget {
  final String driverName;
  final String vehiclePlate;
  final int? driverId;

  const DriverFormScreen({
    super.key,
    required this.driverName,
    required this.vehiclePlate,
    this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController driverNameController = TextEditingController(text: driverName);
    final TextEditingController vehiclePlateController = TextEditingController(text: vehiclePlate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário do Motorista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: driverNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do Motorista',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: vehiclePlateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placa do Veículo',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShipmentFormScreen(
                      driverName: driverNameController.text,
                      vehiclePlate: vehiclePlateController.text,
                      driverId: driverId ?? 0,
                      shipmentId: '',
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
