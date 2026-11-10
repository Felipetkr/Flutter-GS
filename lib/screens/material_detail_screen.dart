import 'package:flutter/material.dart';

import '../models/material_item.dart';

class MaterialDetailScreen extends StatefulWidget {
  const MaterialDetailScreen({
    super.key,
    required this.material,
    required this.onReserve,
  });

  final MaterialItem material;
  final VoidCallback onReserve;

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  late MaterialItem _item;

  @override
  void initState() {
    super.initState();
    _item = widget.material;
  }

  @override
  Widget build(BuildContext context) {
    final canReserve =
        !_item.isMine && _item.status == MaterialStatus.available;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do material')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              _item.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.school_outlined, size: 100),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(_item.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Chip(label: Text(_item.status.label)),
          const Divider(height: 32),
          _line(Icons.category_outlined, 'Categoria', _item.category),
          _line(Icons.verified_outlined, 'Conservação', _item.condition),
          _line(Icons.person_outline, 'Doador(a)', _item.donorName),
          _line(
            Icons.location_on_outlined,
            'Ponto de coleta',
            _item.collectionPoint,
          ),
          const SizedBox(height: 18),
          Text('Descrição', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(_item.description),
          const SizedBox(height: 28),
          if (canReserve)
            ElevatedButton.icon(
              onPressed: () {
                widget.onReserve();
                setState(
                  () => _item = _item.copyWith(
                    status: MaterialStatus.reserved,
                    reservedByMe: true,
                  ),
                );
              },
              icon: const Icon(Icons.bookmark_add_outlined),
              label: const Text('Reservar material'),
            ),
          if (_item.reservedByMe && _item.status == MaterialStatus.reserved)
            OutlinedButton.icon(
              onPressed: () {
                final changed = _item.copyWith(
                  status: MaterialStatus.available,
                  reservedByMe: false,
                );
                Navigator.pop(context, changed);
              },
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancelar reserva'),
            ),
          if (_item.isMine && _item.status != MaterialStatus.delivered)
            ElevatedButton.icon(
              onPressed: () {
                final changed = _item.copyWith(
                  status: MaterialStatus.delivered,
                );
                Navigator.pop(context, changed);
              },
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Marcar como entregue'),
            ),
        ],
      ),
    );
  }

  Widget _line(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(child: Text('$label\n$value')),
          ],
        ),
      );
}
