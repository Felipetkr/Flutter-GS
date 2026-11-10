import 'package:flutter_test/flutter_test.dart';

import 'package:conectadoa/models/material_item.dart';

void main() {
  test('copyWith updates a reservation without changing ownership', () {
    const item = MaterialItem(
      id: '1',
      title: 'Livro',
      description: 'Teste',
      category: 'Livro',
      condition: 'Bom estado',
      region: 'Centro',
      collectionPoint: 'Centro',
      donorName: 'Ana',
      imageUrl: 'https://example.com/livro.jpg',
    );
    final reserved = item.copyWith(
      status: MaterialStatus.reserved,
      reservedByMe: true,
    );
    expect(reserved.status, MaterialStatus.reserved);
    expect(reserved.reservedByMe, isTrue);
    expect(reserved.isMine, isFalse);
  });
}
