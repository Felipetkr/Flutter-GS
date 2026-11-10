# ConectaDoa — Visão geral do negócio

## A ideia

O **ConectaDoa** é uma plataforma simples para conectar pessoas que têm materiais escolares em bom estado, mas não usam mais, a pessoas que precisam desses materiais.

Exemplos de itens: mochilas, cadernos, livros, estojos e lápis.

## O problema

Existem materiais escolares que poderiam continuar sendo usados, mas acabam guardados ou descartados. Ao mesmo tempo, algumas pessoas podem ter dificuldade para conseguir esses itens.

O ConectaDoa propõe facilitar essa conexão em um único lugar.

> Essa é uma hipótese do projeto. Ainda precisa ser validada com pessoas usuárias reais.

## Como funciona

1. Uma pessoa cria uma conta.
2. Ela cadastra um material que deseja doar.
3. O material aparece na lista de itens disponíveis.
4. Uma pessoa interessada encontra o item e faz uma reserva.
5. A retirada é combinada para um ponto fixo de coleta parceiro ilustrativo.
6. A pessoa interessada consulta “Meus materiais” e, se necessário, pode excluir a reserva antes da retirada.
7. Depois da entrega, o doador marca o material como entregue.

## Para quem é

- **Doador:** pessoa que tem material escolar em bom estado e deseja doá-lo.
- **Interessado:** pessoa que procura material escolar disponível.

Uma mesma pessoa pode atuar nos dois papéis.

## O que o MVP precisa ter

- Cadastro e login de usuários.
- Cadastro de materiais para doação.
- Lista de materiais disponíveis.
- Filtro por categoria.
- Edição e exclusão do próprio anúncio.
- Reserva de um material por pessoa interessada.
- Área “Meus materiais” para visualizar e excluir uma reserva.
- Status do material: **disponível**, **reservado** e **entregue**.
- Descrição, estado de conservação, região/bairro e ponto de coleta no cadastro.
- Pontos fixos de coleta parceiros ilustrativos: Centro, Zona Sul e Zona Leste.

## O que não entra nesta primeira versão

- Pagamento.
- Entrega ou frete.
- Chat entre usuários.
- Mapa e endereço completo.
- Avaliações e comentários.
- Upload de fotos obrigatório.

Esses recursos podem ser pensados em versões futuras. O foco inicial é provar que o fluxo de doação e reserva funciona.

## Regras simples

- Cada material pertence a um doador.
- Um item começa como **disponível**.
- Apenas um interessado pode reservar cada item.
- O doador não pode reservar o próprio item.
- Somente o doador pode editar, excluir ou marcar a entrega do seu material.
- A pessoa interessada pode excluir a própria reserva antes da entrega; assim, o item retorna a disponível.
- O endereço residencial não é solicitado; a retirada é direcionada a um ponto de coleta.
- Os pontos de coleta exibidos são ilustrativos no MVP e não representam parceria real confirmada.

## Impacto esperado

O projeto pretende contribuir com:

- **ODS 4 — Educação de Qualidade:** facilitar o acesso a materiais que apoiam os estudos.
- **ODS 10 — Redução das Desigualdades:** ajudar a diminuir uma barreira material para estudantes e famílias.

O MVP demonstra a proposta; ele não mede impacto social real nesta fase.

## Tecnologia sugerida

- **React:** para criar as telas da plataforma.
- **Supabase:** para login, banco de dados e armazenamento das informações.

## Exemplo de uso

Ana tem uma mochila em bom estado e não usa mais. Ela entra no ConectaDoa, descreve o item, informa seu estado de conservação, escolhe a região e um ponto fixo de coleta.

Bruno procura uma mochila, encontra o anúncio de Ana e reserva o item. Em “Meus materiais”, ele visualiza o ponto de coleta e pode excluir a reserva se não conseguir retirar. Quando a mochila é entregue, Ana atualiza o status para entregue.

## Objetivo da apresentação

Mostrar que o ConectaDoa consegue realizar o fluxo principal de forma simples:

**Cadastrar material → Encontrar material → Reservar → Acompanhar ou cancelar → Marcar como entregue**

---

Para o detalhamento técnico e de desenvolvimento, consulte o documento completo: `conectadoa-mvp.md`.
