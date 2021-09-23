import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null&&
                ShopAppCubit.get(context).categoriesModel != null,
            builder: (context) {
              return buildProductItem(ShopAppCubit.get(context).homeModel,
                  ShopAppCubit.get(context).categoriesModel,context);
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget buildProductItem(HomeModel model, CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 150.0,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                initialPage: 0,
                viewportFraction: 1,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlay: true,
                reverse: false,
                pauseAutoPlayOnTouch: true,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: categoriesModel.data.data.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('New Product',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.75,
                children: List.generate(
                  model.data.products.length,
                      (index,) => buildGridItem(model.data.products[index],context),
                ),
              ),
            ),
          ],
        ),
      );
}

Widget buildGridItem(ProductModel model,context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != null)
                Container(
                  color: Colors.red,
                  child: Text(
                    'discount',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                model.name,
                style: TextStyle(fontSize: 14, height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text('${model.price.round()}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.deepOrange,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${model.oldPrice.round()}',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough)),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color:  ShopAppCubit.get(context).favorites[model.id]
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );

Widget buildCategoriesItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
        ),
        Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              model.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
      ],
    );
