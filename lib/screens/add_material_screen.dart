import 'package:flutter/material.dart';

import '../models/material_item.dart';

class AddMaterialScreen extends StatefulWidget {
  const AddMaterialScreen({super.key});

  @override
  State<AddMaterialScreen> createState() => _AddMaterialScreenState();
}

class _AddMaterialScreenState extends State<AddMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  String _category = 'Mochila';
  String _condition = 'Bom estado';
  String _region = 'Centro';

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.pop(
      context,
      MaterialItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title.text,
        description: _description.text,
        category: _category,
        condition: _condition,
        region: _region,
        collectionPoint: 'Ponto parceiro - $_region',
        donorName: 'Você',
        imageUrl: _imageForCategory(_category),
        isMine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Cadastrar doação')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Nome do material',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Informe o material'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Descreva o item'
                    : null,
              ),
              const SizedBox(height: 16),
              _select(
                  'Categoria',
                  _category,
                  [
                    'Mochila',
                    'Livro',
                    'Caderno',
                    'Estojo',
                  ],
                  (value) => setState(() => _category = value!)),
              _select(
                'Estado de conservação',
                _condition,
                ['Bom estado', 'Muito bom estado'],
                (value) => setState(() => _condition = value!),
              ),
              _select(
                'Região e ponto de coleta',
                _region,
                ['Centro', 'Zona Sul', 'Zona Leste'],
                (value) => setState(() => _region = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.volunteer_activism),
                label: const Text('Publicar doação'),
              ),
            ],
          ),
        ),
      );

  Widget _select(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          items: options
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: onChanged,
        ),
      );

  String _imageForCategory(String category) => switch (category) {
        'Mochila' =>
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80',
        'Livro' =>
          'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=800&q=80',
        'Caderno' =>
          'https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=800&q=80',
        _ =>
          'https://images.unsplash.com/photo-1588072432836-7fb78a8f5235?auto=format&fit=crop&w=800&q=80',
      };
}
