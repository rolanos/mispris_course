import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mispris_course/presentation/bloc/chem_class_bloc.dart';
import 'package:mispris_course/presentation/bloc/prod_bloc.dart';
import 'package:mispris_course/presentation/bloc/spec_prod_bloc.dart';
import 'package:mispris_course/presentation/bloc/unit_bloc_bloc.dart';
import 'package:mispris_course/utility/SnackBarCustom.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChemClassBloc, ChemClassState>(
          listener: (context, state) {
            if (state is ChemClassError) {
              SnackBarCustom(context: context, message: state.message)
                  .showSnackBar();
            }
          },
        ),
        BlocListener<ProdBloc, ProdState>(
          listener: (context, state) {
            if (state is ProdError) {
              SnackBarCustom(context: context, message: state.message)
                  .showSnackBar();
            }
          },
        ),
        BlocListener<UnitBloc, UnitState>(
          listener: (context, state) {
            if (state is UnitError) {
              SnackBarCustom(context: context, message: state.message)
                  .showSnackBar();
            }
          },
        )
      ],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Классы',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddChemClassAlertDialog(),
                    );
                  },
                  child: const Text('Добавить класс'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteClassAlertDialog(),
                    );
                  },
                  child: const Text('Удалить класс'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ChangeParentClassAlertDialog(),
                    );
                  },
                  child: const Text('Изменить родителя'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => FindParentsClassAlertDialog(),
                    );
                  },
                  child: const Text('Найти родителей'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => FindChildrenClassAlertDialog(),
                    );
                  },
                  child: const Text('Найти потомков'),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Изделия',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddProdAlertDialog(),
                    );
                  },
                  child: const Text('Добавить изделие'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => FindProdByClassAlertDialog(),
                    );
                  },
                  child: const Text('Найти изделия'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteProdAlertDialog(),
                    );
                  },
                  child: const Text('Удалить изделие'),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Единицы измерения',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddUnitAlertDialog(),
                    );
                  },
                  child: const Text('Добавить единицу'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteUnitAlertDialog(),
                    );
                  },
                  child: const Text('Удалить единицу'),
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Спецификации',
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddSpecProdAlertDialog(),
                    );
                  },
                  child: const Text('Добавить спецификацию'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteSpecProdAlertDialog(),
                    );
                  },
                  child: const Text('Удалить спецификацию'),
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width - 16.0,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade100,
                    shape: const BeveledRectangleBorder(),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditSpecProdAlertDialog(),
                    );
                  },
                  child: const Text('Изменить спецификацию'),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class EditSpecProdAlertDialog extends StatelessWidget {
  final TextEditingController idController = TextEditingController();

  final TextEditingController posController = TextEditingController();

  final TextEditingController idPartController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  EditSpecProdAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Изменить спецификацию'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id продукции',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Номер позиции',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: posController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'id входящего изделия',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idPartController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 8.0),
            const Text(
              'Кол-во',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: quantityController,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<SpecProdBloc>().add(
                  EditSpecProd(
                    idProd: int.tryParse(idController.text),
                    positionNumber: int.tryParse(posController.text),
                    idProdPart: int.tryParse(idPartController.text),
                    quantity: int.tryParse(quantityController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteSpecProdAlertDialog extends StatelessWidget {
  DeleteSpecProdAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить спецификацию'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id продукции',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<SpecProdBloc>().add(
                  DeleteSpecProd(
                    idProd: int.tryParse(idController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddSpecProdAlertDialog extends StatelessWidget {
  AddSpecProdAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  final TextEditingController posController = TextEditingController();

  final TextEditingController idPartController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить спецификацию'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id продукции',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Номер позиции',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: posController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'id входящего изделия',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idPartController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 8.0),
            const Text(
              'Кол-во',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: quantityController,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<SpecProdBloc>().add(
                  AddSpecProd(
                    idProd: int.tryParse(idController.text),
                    positionNumber: int.tryParse(posController.text),
                    idProdPart: int.tryParse(idPartController.text),
                    quantity: int.tryParse(quantityController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddChemClassAlertDialog extends StatelessWidget {
  AddChemClassAlertDialog({super.key});

  final TextEditingController shortNameController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController idUnitController = TextEditingController();

  final TextEditingController idClassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить класс'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: shortNameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'id ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idUnitController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 8.0),
            const Text(
              'id родителя',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idClassController,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ChemClassBloc>().add(
                  AddChemClass(
                    shortName: shortNameController.text.isNotEmpty
                        ? shortNameController.text
                        : null,
                    name: nameController.text.isNotEmpty
                        ? nameController.text
                        : null,
                    baseUnits: int.tryParse(idUnitController.text),
                    mainClass: int.tryParse(idClassController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteClassAlertDialog extends StatelessWidget {
  DeleteClassAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить класс'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context
                .read<ChemClassBloc>()
                .add(DeleteChemClass(classId: int.tryParse(idController.text)));
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class FindProdByClassAlertDialog extends StatelessWidget {
  FindProdByClassAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить класс'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context
                .read<ProdBloc>()
                .add(FindProdByClass(id: int.tryParse(idController.text)));
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class ChangeParentClassAlertDialog extends StatelessWidget {
  ChangeParentClassAlertDialog({super.key});

  final TextEditingController idClassController = TextEditingController();

  final TextEditingController idNewBaseClassController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Изменить родителя'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idClassController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 8.0),
            const Text(
              'id нового родителя',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idNewBaseClassController,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ChemClassBloc>().add(
                  ChangeParent(
                    classId: int.tryParse(idClassController.text),
                    newClassId: int.tryParse(idNewBaseClassController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class FindParentsClassAlertDialog extends StatelessWidget {
  FindParentsClassAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Найти родителей'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ChemClassBloc>().add(
                  FindParents(
                    id: int.tryParse(
                      idController.text,
                    ),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class FindChildrenClassAlertDialog extends StatelessWidget {
  FindChildrenClassAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Найти потомков'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ChemClassBloc>().add(
                  FindChildren(
                    id: int.tryParse(idController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddProdAlertDialog extends StatelessWidget {
  AddProdAlertDialog({super.key});

  final TextEditingController shortNameController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить продукт'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: shortNameController,
                keyboardType: TextInputType.text),
            const SizedBox(height: 8.0),
            const Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: nameController, keyboardType: TextInputType.text),
            const SizedBox(height: 8.0),
            const Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ProdBloc>().add(
                  AddProd(
                    shortName: shortNameController.text.isNotEmpty
                        ? shortNameController.text
                        : null,
                    name: nameController.text.isNotEmpty
                        ? nameController.text
                        : null,
                    idClass: idController.text.isNotEmpty
                        ? int.tryParse(idController.text)
                        : null,
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteProdAlertDialog extends StatelessWidget {
  DeleteProdAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить продукт'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id продукта',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<ProdBloc>().add(
                  DeleteProd(
                    productId: int.tryParse(idController.text),
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddUnitAlertDialog extends StatelessWidget {
  AddUnitAlertDialog({super.key});

  final TextEditingController shortNameController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить ЕИ'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: shortNameController,
                keyboardType: TextInputType.text),
            const SizedBox(height: 8.0),
            const Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: nameController, keyboardType: TextInputType.text),
            const SizedBox(height: 8.0),
            const Text(
              'Код ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: codeController, keyboardType: TextInputType.text),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<UnitBloc>().add(
                  AddUnit(
                    shortName: shortNameController.text.isNotEmpty
                        ? shortNameController.text
                        : null,
                    name: nameController.text.isNotEmpty
                        ? nameController.text
                        : null,
                    code: codeController.text.isNotEmpty
                        ? codeController.text
                        : null,
                  ),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteUnitAlertDialog extends StatelessWidget {
  DeleteUnitAlertDialog({super.key});

  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить ЕИ'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'id ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
                controller: idController, keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            context.read<UnitBloc>().add(
                  DeleteUnit(unitId: int.tryParse(idController.text)),
                );
            Navigator.pop(context);
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
