import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppChangeBottomNavState extends ShopAppStates {}

class ShopAppLoadingState extends ShopAppStates {}

class ShopAppSuccessState extends ShopAppStates {}

class ShopAppErrorState extends ShopAppStates {
  final String error;

  ShopAppErrorState(this.error);
}

class ShopChangeFavoritesState extends ShopAppStates {}

class ShopSuccessChangeFavoritesState extends ShopAppStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopAppStates {}

class ShopLoadingGetFavoritesState extends ShopAppStates {}

class ShopSuccessGetFavoritesState extends ShopAppStates {}

class ShopErrorGetFavoritesState extends ShopAppStates {}

class ShopSuccessCategoriesState extends ShopAppStates {}


class ShopErrorCategoriesState extends ShopAppStates {}

class ShopLoadingUserDataState extends ShopAppStates {}

class ShopSuccessUserDataState extends ShopAppStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopAppStates {}

class ShopLoadingUpdateUserState extends ShopAppStates {}

class ShopSuccessUpdateUserState extends ShopAppStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopAppStates {}