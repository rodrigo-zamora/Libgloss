import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:libgloss/config/routes.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/colors.dart';
import '../../widgets/shared/search_appbar.dart';

class UsedBookSeller extends StatefulWidget {
  UsedBookSeller({
    super.key,
  });

  @override
  State<UsedBookSeller> createState() => _UsedBookSellerState();
}

class _UsedBookSellerState extends State<UsedBookSeller> {
  final Color _primaryColor =
      ColorSelector.getPrimary(LibglossRoutes.HOME_USED);
  final Color _secondaryColor =
      ColorSelector.getSecondary(LibglossRoutes.HOME_USED);
  final Color _defaultColor = ColorSelector.getBlack();

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments;
    _args as Map<String, dynamic>;
    Future<QuerySnapshot<Map<String, dynamic>>> result = FirebaseFirestore.instance.collection('users').where('username', isEqualTo: _args['vendedor']).get();  
    return FutureBuilder<DocumentSnapshot>(
      future: result.then((value) => value.docs.first.reference.get()),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic>? data =
                snapshot.data!.data() as Map<String, dynamic>?;
            if (data != null) return _buildUserOptions(data);
          }
        }
        return _loadingUserOptions();
      },
    );
  }

  Widget _loadingUserOptions() {
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
          title: "Vendedor",
        ),
      ),
      body: Center(
        child: CircularProgressIndicator(
          color: _secondaryColor,
        ),
      ),
    );
  }

  Widget _buildUserOptions(Map<String, dynamic>? data) {
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
          title: "Vendedor",
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  data?['username'],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: _defaultColor,
                  ),
                ),
                Text(
                  data!['email'],
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: _defaultColor,
                  ),
                ),
                SizedBox(height: 20),
                _profilePicture(data),
                SizedBox(height: 20),
                Text(
                  "Contacto",
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Divider(
                    color: _defaultColor,
                    thickness: 0.5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Teléfono de contacto",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: _defaultColor,
                      ),
                    ),
                    Text(
                      data['phoneNumber'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: _defaultColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.message),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Localización",
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Divider(
                    color: _defaultColor,
                    thickness: 0.5,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Image.network('https://blogs.iteso.mx/comollegar/wp-content/uploads/sites/84/2016/03/Ruta-salida-del-ITESO.jpg'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _profilePicture(Map<String, dynamic>? data) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CachedNetworkImage(
            placeholder: (context, url) {
              return ClipOval(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
            fit: BoxFit.contain,
            imageUrl: data!['profilePicture'],
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(
                backgroundImage: imageProvider,
              );
            },
          ),
        ],
      )
    );
  }

  Widget _show() {
    return AlertDialog(
      title: Text('AlertDialog Title'),
      content: Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
