import 'package:flutter/material.dart';

import '../models/material_item.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    super.key,
    required this.material,
    required this.onTap,
    required this.onFavorite,
  });

  final MaterialItem material;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final color = switch (material.status) {
      MaterialStatus.available => Colors.teal,
      MaterialStatus.reserved => Colors.orange,
      MaterialStatus.delivered => Colors.blueGrey,
    };
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  material.imageUrl,
                  width: 54,
                  height: 54,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.school_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text('${material.category} - ${material.condition}'),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(material.status.label),
                      labelStyle: const TextStyle(color: Colors.white),
                      backgroundColor: color,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip:
                    material.isFavorite ? 'Remover dos favoritos' : 'Favoritar',
                onPressed: onFavorite,
                icon: Icon(
                  material.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: material.isFavorite ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
