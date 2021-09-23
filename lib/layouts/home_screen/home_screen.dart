import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:shop_app/modules/favorite_Screen/favorite_Screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components.dart';

class HomeScreen extends StatelessWidget {
  var searchController = TextEditingController();

  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            /*leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),*/
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: defaultFormField(
                    //      labelText: 'Search',
                    paddingContent: 10,
                    curoserHeight: 25,
                    onTap: () {
                      navigateTo(context, SearchScreen());
                    },
                    prefix: Icons.search,
                    enabledBorderColor: Colors.deepOrange,
                    iconColor: Colors.deepOrange,
                    fillcolor: Colors.deepOrange,
                    focusColor: Colors.deepOrange,
                    enabledBorderRaduis: 20,
                    errorBorderColor: Colors.deepOrange,
                    cursorColor: Colors.deepOrange,
                    focusdborderColor: Colors.deepOrange,
                    focusedBorderRaduis: 20,
                    errorBorderRaduis: 20,
                    borderColor: Colors.deepOrange,
                    borderRaduis: 20,
                    labelColor: Colors.grey,
                    type: TextInputType.text,
                    controller: searchController,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Search must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        /*  Text(
                            ShopAppCubit.get(context).userModel.data.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        Text(
                            ShopAppCubit.get(context).userModel.data.email,
                            style: TextStyle(
                                color: Colors.white60,
                                ),
                          ),
                          Text(ShopAppCubit.get(context).userModel.data.phone, style: TextStyle(
                            color: Colors.white60,
                          ),),*/
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/drawer1.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit),color: Colors.white,),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                ),
                ListTile(
                  title: Text('My Favorite'),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          body: ShopAppCubit.get(context)
              .bottomScreens[ShopAppCubit.get(context).currentIndex],
          bottomNavigationBar: SnakeNavigationBar.color(
            backgroundColor: Colors.deepOrange,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.deepOrange,
            snakeViewColor: Colors.white,
            showSelectedLabels: true,
            //showUnselectedLabels: true,
            padding: EdgeInsets.all(15.0),
            height: 40,
            shape: bottomBarShape,
            onTap: (index) {
              ShopAppCubit.get(context).changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.deepOrange),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                  backgroundColor: Colors.deepOrange),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                  backgroundColor: Colors.deepOrange),
            ],
            currentIndex: ShopAppCubit.get(context).currentIndex,
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
