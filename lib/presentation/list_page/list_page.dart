import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mispris_course/database_service.dart';
import 'package:mispris_course/entity/chem_class.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Column(
        children: [
          const TableHeader(),
          FutureBuilder(
            future: DataBaseService().getAllChemClass(),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ChemClassRow(
                      chemClass: snapshot.data?.elementAt(index),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('id'),
        ),
        Expanded(
          flex: 6,
          child: Text('shortName'),
        ),
        Expanded(
          flex: 10,
          child: Text('name'),
        ),
        Expanded(
          flex: 4,
          child: Text('base_units'),
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
    return chemClass != null
        ? SizedBox(
            height: 30.0,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(chemClass!.idClass.toString()),
                ),
                Expanded(
                  flex: 10,
                  child: Text(chemClass!.shortName ?? 'Нет'),
                ),
                Expanded(
                  flex: 10,
                  child: Text(chemClass!.name ?? 'Нет'),
                ),
                Expanded(
                  flex: 10,
                  child: Text((chemClass!.baseUnits ?? 'Нет').toString()),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
