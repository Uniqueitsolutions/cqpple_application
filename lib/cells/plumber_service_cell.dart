import 'package:bath_service_project/models/plumber_service.dart';
import 'package:flutter/material.dart';

class ServiceListCell extends StatelessWidget {
  final PlumberService plumberService;
  final VoidCallback? onPressed;

  const ServiceListCell(
      {super.key, required this.plumberService, this.onPressed});
  Widget buildTitleValue(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String?> addressComponents = [
      plumberService.address,
      plumberService.cityname,
      plumberService.statename,
    ];

    String fullAddress =
        addressComponents.where((component) => component != null).join(', ');
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plumberService.problem ?? '',
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(height: 8.0),
            buildTitleValue(
                'Complaint #: ', plumberService.complainNumber ?? ''),
            const SizedBox(height: 4.0),
            buildTitleValue('Name: ', plumberService.name ?? ''),
            const SizedBox(height: 4.0),
            buildTitleValue('Contact: ', plumberService.contactNumber ?? ''),
            const SizedBox(height: 4.0),
            buildTitleValue('Address: ', fullAddress),
            const SizedBox(height: 8.0),
            buildTitleValue('Created: ', plumberService.created ?? ''),
            const SizedBox(height: 8.0),
            // You can add more information or customization as needed
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
