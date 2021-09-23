
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/home_screen/home_screen.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/cubit/cubit.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/shared/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => navigateTo(context, HomeScreen()),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: defaultFormField(
                      //      labelText: 'Search',
                      paddingContent: 10,
                      curoserHeight: 25,
                      onTap: () {},
                      onSubmit: (String text){
                        SearchCubit.get(context).search(text);
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
              ),
            ],
          ),
          body: Column(
            children: [
              if (state is SearchLoadingState) LinearProgressIndicator(),
              SizedBox(
                height: 10.0,
              ),
              if (state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildSearchItem(
                      SearchCubit.get(context).model.data.data[index],
                      context,
                      isOldPrice: false,
                    ),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount:
                    SearchCubit.get(context).model.data.data.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildSearchItem (model, context, {bool isOldPrice}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3, fontSize: 14.0),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(fontSize: 12.0, color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),

                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                    ShopAppCubit.get(context).favorites[model.id]
                        ? Colors.deepOrange
                        : Colors.grey,
                    child: IconButton(
                      onPressed: () {
                        ShopAppCubit.get(context).changeFavorites(model.id);
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

