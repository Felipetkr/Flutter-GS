import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/material_item.dart';

class MaterialService {
  MaterialService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<MaterialItem>> fetchMaterials() async {
    final response = await _client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=8'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Não foi possível buscar os materiais.');
    }
    final posts = jsonDecode(response.body) as List<dynamic>;
    const titles = [
      'Mochila escolar azul',
      'Livro de matemática',
      'Caderno universitário',
      'Estojo com zíper',
      'Kit de lápis de cor',
      'Livro de português',
      'Caderno brochura',
      'Régua e materiais de desenho',
    ];
    const descriptions = [
      'Em ótimo estado, pronta para uso.',
      'Livro conservado, sem páginas rasgadas.',
      'Caderno com poucas páginas usadas.',
      'Estojo limpo e com zíper funcionando.',
      'Conjunto completo para atividades escolares.',
      'Livro didático bem conservado.',
      'Caderno quase novo, com capa firme.',
      'Materiais básicos para as atividades.',
    ];
    const images = [
      'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1588072432836-7fb78a8f5235?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1576504672861-9de1d317dca6?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1596495578068-7cc3e0d53446?auto=format&fit=crop&w=800&q=80',
    ];
    const categories = ['Mochila', 'Livro', 'Caderno', 'Estojo'];
    const regions = ['Centro', 'Zona Sul', 'Zona Leste'];
    return posts.asMap().entries.map((entry) {
      final json = entry.value as Map<String, dynamic>;
      final index = entry.key;
      return MaterialItem(
        id: 'api-${json['id']}',
        title: titles[index % titles.length],
        description: descriptions[index % descriptions.length],
        category: categories[index % categories.length],
        condition: index.isEven ? 'Bom estado' : 'Muito bom estado',
        region: regions[index % regions.length],
        collectionPoint: 'Ponto parceiro - ${regions[index % regions.length]}',
        donorName: 'Doador(a) da comunidade #${json['userId']}',
        imageUrl: images[index % images.length],
      );
    }).toList();
  }
}
