package android.support.v4.net;

import android.net.ConnectivityManager;
import android.net.NetworkInfo;

class ConnectivityManagerCompatGingerbread
{
  public static boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
  {
    int i = 1;
    NetworkInfo localNetworkInfo = paramConnectivityManager.getActiveNetworkInfo();
    if (localNetworkInfo == null);
    while (true)
    {
      return i;
      switch (localNetworkInfo.getType())
      {
      case 0:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      default:
        break;
      case 1:
        Object localObject = null;
      }
    }
  }
}