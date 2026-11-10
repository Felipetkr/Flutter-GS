import 'package:flutter/material.dart';

import '../models/material_item.dart';
import '../services/material_service.dart';
import '../widgets/material_card.dart';
import 'add_material_screen.dart';
import 'material_detail_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final _service = MaterialService();
  List<MaterialItem> _items = [];
  bool _hasStartedRequest = false;
  bool _loading = true;
  String? _error;
  int _tab = 0;
  String _query = '';
  String _category = 'Todos';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() {
      _hasStartedRequest = true;
      _loading = true;
      _error = null;
    });
    try {
      final remote = await _service.fetchMaterials();
      if (!mounted) return;
      setState(() {
        _items = [
          const MaterialItem(
            id: 'mine-1',
            title: 'Mochila azul',
            description:
                'Mochila escolar limpa, com todos os zíperes funcionando.',
            category: 'Mochila',
            condition: 'Muito bom estado',
            region: 'Zona Sul',
            collectionPoint: 'Ponto parceiro - Zona Sul',
            donorName: 'Você',
            imageUrl:
                'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=800&q=80',
            isMine: true,
          ),
          ...remote,
        ];
        _loading = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _error =
              'Não foi possível carregar os materiais. Verifique sua conexão e tente novamente.';
          _loading = false;
        });
      }
    }
  }

  void _replace(MaterialItem item) => setState(
        () => _items =
            _items.map((value) => value.id == item.id ? item : value).toList(),
      );

  void _reserve(MaterialItem item) {
    if (item.isMine || item.status != MaterialStatus.available) return;
    _replace(
      item.copyWith(status: MaterialStatus.reserved, reservedByMe: true),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Material reservado. Veja os detalhes em Meus materiais.',
        ),
      ),
    );
  }

  Future<void> _openDetail(MaterialItem item) async {
    final updated = await Navigator.of(context).push<MaterialItem>(
      MaterialPageRoute(
        builder: (_) => MaterialDetailScreen(
          material: item,
          onReserve: () => _reserve(item),
        ),
      ),
    );
    if (updated != null) _replace(updated);
  }

  void _addMaterial() async {
    final material = await Navigator.of(context).push<MaterialItem>(
      MaterialPageRoute(builder: (_) => const AddMaterialScreen()),
    );
    if (material != null) setState(() => _items = [material, ..._items]);
  }

  @override
  Widget build(BuildContext context) {
    final views = [_explore(), _myMaterials(), _profile(), _about()];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            'Explorar materiais',
            'Meus materiais',
            'Meu perfil',
            'Sobre o projeto',
          ][_tab],
        ),
      ),
      body: views[_tab],
      floatingActionButton: _tab == 0
          ? FloatingActionButton.extended(
              onPressed: _addMaterial,
              icon: const Icon(Icons.add),
              label: const Text('Doar material'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Explorar'),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Meus materiais',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'Sobre'),
        ],
      ),
    );
  }

  Widget _explore() {
    if (!_hasStartedRequest) {
      return const Center(child: Text('Preparando o catálogo...'));
    }
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Carregando materiais...'),
          ],
        ),
      );
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 46),
              const SizedBox(height: 12),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _load,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }
    final filtered = _items
        .where(
          (item) =>
              item.status == MaterialStatus.available &&
              (_category == 'Todos' || item.category == _category) &&
              ('${item.title} ${item.description}'.toLowerCase().contains(
                    _query.toLowerCase(),
                  )),
        )
        .toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Buscar material',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Row(
            children: ['Todos', 'Mochila', 'Livro', 'Caderno', 'Estojo']
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: _category == category,
                      onSelected: (_) => setState(() => _category = category),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('Nenhum material encontrado.'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
                    itemCount: filtered.length,
                    itemBuilder: (_, index) {
                      final item = filtered[index];
                      return MaterialCard(
                        material: item,
                        onTap: () => _openDetail(item),
                        onFavorite: () => _replace(
                          item.copyWith(isFavorite: !item.isFavorite),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _myMaterials() {
    final mine =
        _items.where((item) => item.isMine || item.reservedByMe).toList();
    if (mine.isEmpty) {
      return const Center(
        child: Text('Você ainda não possui doações ou reservas.'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: mine.length,
      itemBuilder: (_, index) {
        final item = mine[index];
        return Card(
          child: ListTile(
            onTap: () => _openDetail(item),
            leading: const Icon(Icons.school),
            title: Text(item.title),
            subtitle: Text('${item.status.label} - ${item.collectionPoint}'),
            trailing:
                item.reservedByMe && item.status == MaterialStatus.reserved
                    ? IconButton(
                        tooltip: 'Cancelar reserva',
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () => _replace(
                          item.copyWith(
                            status: MaterialStatus.available,
                            reservedByMe: false,
                          ),
                        ),
                      )
                    : null,
          ),
        );
      },
    );
  }

  Widget _profile() => ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(radius: 42, child: Icon(Icons.person, size: 48)),
          SizedBox(height: 16),
          Center(child: Text('Pessoa usuária do ConectaDoa')),
          SizedBox(height: 28),
          ListTile(
            leading: Icon(Icons.volunteer_activism_outlined),
            title: Text('Você pode doar e reservar materiais'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Pontos ilustrativos: Centro, Zona Sul e Zona Leste'),
          ),
        ],
      );

  Widget _about() => const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.volunteer_activism, size: 52),
            SizedBox(height: 16),
            Text(
              'ConectaDoa',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Conectamos materiais escolares em bom estado a pessoas que precisam deles.',
            ),
            SizedBox(height: 22),
            Text(
              'ODS 4 - Educação de Qualidade\nODS 10 - Redução das Desigualdades',
            ),
          ],
        ),
      );
}
