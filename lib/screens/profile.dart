
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopspace/components/profile_list_button.dart';
import 'package:shopspace/screens/add_product.dart';
import 'package:shopspace/screens/check_products.dart';
import 'package:shopspace/screens/favourite.dart';
import 'package:shopspace/screens/search_product.dart';

import '../components/custom_button.dart';

import '../utils/application_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loadingButton = false;

  void signOutButtonPressed() {
    setState(() {
      _loadingButton = true;
    });
    Provider.of<ApplicationState>(context, listen: false).signOut();
  }
  


  @override
  Widget build(BuildContext context) {
    return Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  ProfileListButton(icon: Icons.post_add, text: "Post Product/Service", onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProductScreen()));
                  }),
                  ProfileListButton(icon: Icons.image_search, text: "Check Posts", onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckProductScreen()));
                  }),
                  ProfileListButton(icon: Icons.history, text: "Purchase History".toString(), onPress: (

                      ){}),
                  //navigate  to favorite screen
                  ProfileListButton(icon: Icons.help_center_outlined, text: "Favourites", onPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavouriteScreen()));
                  }),
                  //ProfileListButton(icon: Icons.settings, text: "Help & Support", onPress: (){}),
                  //ProfileListButton(icon: Icons.share, text: "Invite a friend", onPress: (){}),
                  ProfileListButton(icon: Icons.logout, text: "Log out", onPress: signOutButtonPressed),
                ],
              ),
            ),
          ),
        );
  }

}