import 'package:flutter/material.dart';
import 'package:mispris_course/utility/SnackBarCustom.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    builder: (context) => const AddChemClassAlertDialog(),
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
                    builder: (context) => const DeleteClassAlertDialog(),
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
                    builder: (context) => const ChangeParentClassAlertDialog(),
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
                    builder: (context) => const FindParentsClassAlertDialog(),
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
                    builder: (context) => const FindChildrenClassAlertDialog(),
                  );
                },
                child: const Text('Изменить потомков'),
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
                    builder: (context) => const AddProdAlertDialog(),
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
                    builder: (context) => const DeleteProdAlertDialog(),
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
                    builder: (context) => const AddUnitAlertDialog(),
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
                    builder: (context) => const DeleteUnitAlertDialog(),
                  );
                },
                child: const Text('Удалить единицу'),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class AddChemClassAlertDialog extends StatelessWidget {
  const AddChemClassAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить класс'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'id ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'id родителя',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteClassAlertDialog extends StatelessWidget {
  const DeleteClassAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить класс'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class ChangeParentClassAlertDialog extends StatelessWidget {
  const ChangeParentClassAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Изменить родителя'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'id нового родителя',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class FindParentsClassAlertDialog extends StatelessWidget {
  const FindParentsClassAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Найти родителей'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class FindChildrenClassAlertDialog extends StatelessWidget {
  const FindChildrenClassAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Найти потомков'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddProdAlertDialog extends StatelessWidget {
  const AddProdAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить продукт'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'id класса',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteProdAlertDialog extends StatelessWidget {
  const DeleteProdAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить продукт'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id продукта',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class AddUnitAlertDialog extends StatelessWidget {
  const AddUnitAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить ЕИ'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Короткое название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'Название',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
            SizedBox(height: 8.0),
            Text(
              'Код ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}

class DeleteUnitAlertDialog extends StatelessWidget {
  const DeleteUnitAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить ЕИ'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'id ЕИ',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(),
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
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
