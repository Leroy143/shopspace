import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopspace/screens/home.dart';
import '../utils/custome_theme.dart';
import '../main.dart';
import '../models/product.dart';

class UpdateDetailScreen extends StatefulWidget {
  final Product product;
  const UpdateDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdateDetailScreen> createState() => _UpdateDetailScreenState();
}

class _UpdateDetailScreenState extends State<UpdateDetailScreen> {
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  String getCurrentUserId(){
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    print(uid);
    return uid.toString();
    //print(uemail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      label: Text('Title'),
                      hintText: widget.product.title,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: TextField(
                    controller: _price,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      label: Text('Price'),
                      hintText: widget.product.price.toString(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      label: Text('Description'),
                      hintText: widget.product.description,
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _category,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      label: Text('Category'),
                      hintText: widget.product.category,
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){},//update image
                    style: ElevatedButton.styleFrom(primary: CustomTheme.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    child: Text('update product image', style: Theme.of(context).textTheme.titleSmall,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () async {
                      //double price = _price.text as double;
                      double? price = double.tryParse(_price.text);
                      Product update = Product(_title.text.toString(), price!, widget.product.id, _description.text.toString(), widget.product.image, _category.text.toString());

                      final docUser = FirebaseFirestore.instance.collection('users').doc(getCurrentUserId()).collection('properties').doc('products').collection('products posted').doc(widget.product.id);
                      final allProducts = FirebaseFirestore.instance.collection('product').doc(widget.product.id);

                      await docUser.update({
                        'title': update.title,
                        'price': update.price,
                        'description': update.description,
                        'category' : update.category,
                      });

                      await allProducts.update({
                        'title': update.title,
                        'price': update.price,
                        'description': update.description,
                        'category' : update.category,
                      });

                      print("Done");
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const MyApp()), (route) => false);

                    },
                        style: ElevatedButton.styleFrom(primary: CustomTheme.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Text('Save changes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14), )),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        style: ElevatedButton.styleFrom(primary: CustomTheme.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Text('Discard changes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14), )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
