import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libgloss/blocs/auth/bloc/auth_bloc.dart';
import 'package:libgloss/blocs/used_books/bloc/used_books_bloc.dart';
import 'package:libgloss/config/app_color.dart';
import 'package:libgloss/config/routes.dart';
import 'package:libgloss/widgets/shared/search_appbar.dart';

import '../../models/ModelProvider.dart';

class MyBooks extends StatefulWidget {
  MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final Color _primaryColor = AppColor.getPrimary(Routes.options);

  final Color _secondaryColor = AppColor.getSecondary(Routes.options);

  final Color _tertiaryColor = AppColor.getQuaternary(Routes.options);

  final Color _iconColors = AppColor.gray;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SearchAppBar(
          primaryColor: _primaryColor,
          secondaryColor: _secondaryColor,
          showMenuButton: false,
          showCameraButton: false,
          showSearchField: false,
          showBackButton: true,
          title: 'Mis libros',
        ),
      ),
      body: _main(context),
    );
  }

  Widget _main(BuildContext _context) {
    final query = UserBooks.SELLERUUID
        .eq(BlocProvider.of<AuthBloc>(context).currentUser!.id);
    final req = ModelQueries.list<UserBooks>(UserBooks.classType, where: query);
    return FutureBuilder(
      future: Amplify.API.query(request: req).response,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Algo salió mal");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> data = [];
            snapshot.data?.data?.items.forEach((item) {
              data.add(item!.toJson());
            });
            return _buildMyBooks(data, _context);
          }
        }
        return Center(
            child: CircularProgressIndicator(
          color: _secondaryColor,
        ));
      },
    );
  }

  Widget _buildMyBooks(List<Map<String, dynamic>> data, BuildContext _context) {
    if (data.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No tienes libros en venta',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildBook(data[index], _context);
        },
      );
    }
  }

  Widget _buildBook(Map<String, dynamic> data, BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _secondaryColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                data['authors'].join(', '),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Precio: ',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '\$${data['price']}',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _images(data['images']),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: _iconColors,
              ),
              onPressed: () {
                _edit(data, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _images(List<dynamic> images) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 10),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  _edit(Map<String, dynamic> data, BuildContext context) {
    final TextEditingController _priceController =
        TextEditingController(text: data['price'].toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar libro'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Precio: '),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: _secondaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: MaterialButton(
                  child: Text('Elminar libro'),
                  color: _tertiaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteBook(data['id'], data['images']);
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                Navigator.pop(context);
                _updateBook(data, _priceController.text, context);
              },
            ),
          ],
        );
      },
    );
  }

  _updateBook(
      Map<String, dynamic> data, String price, BuildContext context) async {
    try {
      // TODO: Update book in Amplify
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  _deleteBook(String id, List<dynamic> _images) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar libro'),
          content: Text('¿Estás seguro de eliminar este libro?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () async {
                List<dynamic> images = _images;
                try {
                  // TODO: Delete book in Amplify
                  BlocProvider.of<UsedBooksBloc>(context)
                      .add(GetUsedBooksEvent());
                } catch (e) {
                  print(e);
                }
                setState(() {});
                Navigator.pop(context);
                for (String image in images) {
                  try {
                    // TODO: Delete image in Amplify
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
