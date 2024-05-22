import 'package:flutter/material.dart';
import 'package:mispris_course/entity/chem_class.dart';
import 'package:mispris_course/entity/prod.dart';
import 'package:mispris_course/entity/unit.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int tableId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Column(
        children: [
          DropdownButton(
            value: tableId,
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('Классы'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('Продукты'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('Единицы измерения'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                tableId = value ?? 0;
              });
            },
          ),
          if (tableId == 0) ...[
            const ChemClassTableHeader(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return;
                  // return ChemClassRow(
                  //   chemClass: ChemClass(
                  //       idClass: 1,
                  //       baseUnits: 1,
                  //       mainClass: 1,
                  //       name: 'dsa',
                  //       shortName: 'hr'),
                  // );
                },
              ),
            ),
          ] else if (tableId == 1) ...[
            const ProdTableHeader(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return;
                  // return ProdRow();
                },
              ),
            ),
          ] else ...[
            const UnitTableHeader(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return;
                  // return UnitRow();
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class ChemClassTableHeader extends StatelessWidget {
  const ChemClassTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text('id'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Кор. название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 10,
          child: Text('Название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Единицы изм.'),
        ),
      ],
    );
  }
}

class ChemClassRow extends StatelessWidget {
  final ChemClass? chemClass;

  const ChemClassRow({
    super.key,
    required this.chemClass,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: chemClass != null
          ? Container(
              color: Colors.deepOrange.shade100,
              height: 30.0,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(chemClass!.idClass.toString()),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(chemClass!.shortName ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(chemClass!.name ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text((chemClass!.baseUnits ?? 'Нет').toString()),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class ProdTableHeader extends StatelessWidget {
  const ProdTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('id'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Кор. название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 10,
          child: Text('Название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Класс родитель'),
        ),
      ],
    );
  }
}

class ProdRow extends StatelessWidget {
  final Prod? prod;

  const ProdRow({
    super.key,
    required this.prod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: prod != null
          ? Container(
              color: Colors.deepOrange.shade100,
              height: 30.0,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(prod!.idProd.toString()),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(prod!.shortName ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(prod!.name ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text((prod!.idClass).toString()),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class UnitTableHeader extends StatelessWidget {
  const UnitTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('id'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Кор. название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 10,
          child: Text('Название'),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          flex: 6,
          child: Text('Код'),
        ),
      ],
    );
  }
}

class UnitRow extends StatelessWidget {
  final Unit? unit;

  const UnitRow({
    super.key,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: unit != null
          ? Container(
              color: Colors.deepOrange.shade100,
              height: 30.0,
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(unit!.idUnits.toString()),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(unit!.shortName ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(unit!.name ?? 'Нет'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text((unit!.code ?? 'Нет').toString()),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
