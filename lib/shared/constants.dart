import 'package:shop_app/modules/login_screen/login_screen.dart';

import 'components.dart';
import 'network/local/cache_helper.dart';

String token='';
void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}