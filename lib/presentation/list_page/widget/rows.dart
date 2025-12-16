import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/presentation/list_page/cubit/type_process_cubit.dart';
import '../../../entity/entity.dart';

class GrPersonRow extends StatelessWidget {
  final GroupPerson entity;
  const GrPersonRow({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(entity.id.toString())),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.name ?? '-')),
      ],
    );
  }
}

class PersonRow extends StatelessWidget {
  final Person entity;
  const PersonRow({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(entity.id.toString())),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.fio ?? '-')),
      ],
    );
  }
}

class ProcessRow extends StatelessWidget {
  final ProcessEntity entity;
  const ProcessRow({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final typePr = (context.read<TypeProcessCubit>().getTypeById(
                          entity.typePr,
                        )?.name ??
                    '-');
    return Row(
      children: [
        Expanded(flex: 2, child: Text(entity.id.toString())),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.shortName ?? '-')),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.name ?? '-')),
        const VerticalDivider(width: 10),
        Expanded(
          flex: 6,
          child: Text(
            typePr.toString(),
          ),
        ),
      ],
    );
  }
}

class TypeStateRow extends StatelessWidget {
  final TypeState entity;
  const TypeStateRow({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(entity.id.toString())),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.shortName ?? '-')),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.name ?? '-')),
      ],
    );
  }
}

class TypeProcessRow extends StatelessWidget {
  final TypeProcess entity;
  const TypeProcessRow({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: Text(entity.id.toString())),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.name ?? '-')),
        const VerticalDivider(width: 10),
        Expanded(flex: 6, child: Text(entity.shortName ?? '-')),
      ],
    );
  }
}
