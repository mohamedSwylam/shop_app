import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: ConditionalBuilder(
           condition: ShopAppCubit.get(context).categoriesModel !=null,
           builder: (context)=> ListView.separated(
             physics: BouncingScrollPhysics(),
             scrollDirection: Axis.vertical,
             itemBuilder: (context,index)=>buildCatItem(ShopAppCubit.get(context).categoriesModel.data.data[index]),
             separatorBuilder: (context,index)=> myDivider(),
             itemCount: ShopAppCubit.get(context).categoriesModel.data.data.length ,
             ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
           ),
        );
      },
    );
  }
  buildCatItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(image: NetworkImage(model.image),height: 120,width: 120,),
          SizedBox(width: 10),
          Text(model.name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios),),
        ],
      ),
    );
    
  }
}
