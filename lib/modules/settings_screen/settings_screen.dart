import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/cubit.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
     listener: (context,state){},
      builder: (context,state){
        var model = ShopAppCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
       return Scaffold(
         body: ConditionalBuilder(
           condition: ShopAppCubit.get(context).userModel != null,
           builder: (context){
             return SingleChildScrollView(
               child: Form(
                 key: formKey,
                 child: Column(
                   children: [
                     if(state is ShopLoadingUpdateUserState)
                       LinearProgressIndicator(),
                     SizedBox(
                       height: 20.0,
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: defaultFormField(
                         type: TextInputType.text,
                         controller: nameController,
                         labelText: 'User name',
                         paddingContent: 15,
                         onTap: () {},
                         borderRaduis: 50,
                         borderColor: Colors.deepOrange,
                         errorBorderRaduis: 50,
                         focusedBorderRaduis: 50,
                         focusdborderColor: Colors.deepOrange,
                         cursorColor: Colors.deepOrange,
                         errorBorderColor: Colors.deepOrange,
                         enabledBorderRaduis: 50,
                         enabledBorderColor: Colors.deepOrange,
                         focusColor: Colors.deepOrange,
                         fillcolor: Colors.deepOrange,
                         iconColor: Colors.deepOrange,
                         prefix: Icons.person,
                         validate: (String value) {
                           if (value.isEmpty) {
                             return 'name must not be empty ';
                           } else {
                             return null;
                           }
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: defaultFormField(
                         type: TextInputType.emailAddress,
                         controller: emailController,
                         labelText: 'E-mail address',
                         onTap: () {},
                         paddingContent: 15,
                         borderRaduis: 50,
                         borderColor: Colors.deepOrange,
                         errorBorderRaduis: 50,
                         focusedBorderRaduis: 50,
                         focusdborderColor: Colors.deepOrange,
                         cursorColor: Colors.deepOrange,
                         errorBorderColor: Colors.deepOrange,
                         enabledBorderRaduis: 50,
                         enabledBorderColor: Colors.deepOrange,
                         focusColor: Colors.deepOrange,
                         fillcolor: Colors.deepOrange,
                         iconColor: Colors.deepOrange,
                         prefix: Icons.email,
                         validate: (String value) {
                           if (value.isEmpty) {
                             return 'email address must not be empty';
                           } else {
                             return null;
                           }
                         },
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: defaultFormField(
                         type: TextInputType.phone,
                         controller: phoneController,
                         paddingContent: 15,
                         labelText: 'Phone Number',
                         onTap: () {},
                         borderRaduis: 50,
                         borderColor: Colors.deepOrange,
                         errorBorderRaduis: 50,
                         focusedBorderRaduis: 50,
                         focusdborderColor: Colors.deepOrange,
                         cursorColor: Colors.deepOrange,
                         errorBorderColor: Colors.deepOrange,
                         enabledBorderRaduis: 50,
                         enabledBorderColor: Colors.deepOrange,
                         focusColor: Colors.deepOrange,
                         fillcolor: Colors.deepOrange,
                         iconColor: Colors.deepOrange,
                         prefix: Icons.phone,
                         validate: (String value) {
                           if (value.isEmpty) {
                             return 'Phone Number must not be empty';
                           } else {
                             return null;
                           }
                         },
                       ),
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     defaultButton(
                         function: (){
                           if(formKey.currentState.validate())
                           {
                             ShopAppCubit.get(context).updateUserData(
                               name: nameController.text,
                               phone: phoneController.text,
                               email: emailController.text,
                             );
                           }
                     },
                         text: 'Update'),
                     SizedBox(
                       height: 20.0,
                     ),
                     defaultButton(function: (){
                       signOut(context);
                     }, text: 'Logout'),
                   ],
                 ),
               ),
             );
           },
           fallback: (context) => Center(child: CircularProgressIndicator()),
         ),
       );
      },
    );
  }
}
