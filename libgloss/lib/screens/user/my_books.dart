import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../config/routes.dart';
import '../../repositories/auth/user_auth_repository.dart';
import '../../widgets/shared/search_appbar.dart';

class MyBooks extends StatefulWidget {
  MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final Color _primaryColor = ColorSelector.getPrimary(LibglossRoutes.OPTIONS);

  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.OPTIONS);

  final Color _tertiaryColor =
      ColorSelector.getQuaternary(LibglossRoutes.OPTIONS);

  final Color _iconColors = ColorSelector.getGrey();

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
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    return FutureBuilder(
      future: books
          .where('sellerUid', isEqualTo: UserAuthRepository().getuid())
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Algo salió mal");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> data = [];
            snapshot.data?.docs.forEach((doc) {
              Map<String, dynamic> bookData = {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>
              };
              data.add(bookData);
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
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _buildBook(data[index], _context);
      },
    );
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
      await FirebaseFirestore.instance
          .collection('books')
          .doc(data['id'])
          .update({'price': int.parse(price)});
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
                  await FirebaseFirestore.instance
                      .collection('books')
                      .doc(id)
                      .delete();
                } catch (e) {
                  print(e);
                }
                setState(() {});
                Navigator.pop(context);
                for (String image in images) {
                  try {
                    await FirebaseStorage.instance.refFromURL(image).delete();
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
