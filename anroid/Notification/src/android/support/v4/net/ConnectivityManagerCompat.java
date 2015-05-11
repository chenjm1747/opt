package android.support.v4.net;

import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build.VERSION;

public class ConnectivityManagerCompat
{
  private static final ConnectivityManagerCompatImpl IMPL;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new JellyBeanConnectivityManagerCompatImpl();
    while (true)
    {
      return;
      if (Build.VERSION.SDK_INT >= 13)
      {
        IMPL = new HoneycombMR2ConnectivityManagerCompatImpl();
        continue;
      }
      if (Build.VERSION.SDK_INT >= 8)
      {
        IMPL = new GingerbreadConnectivityManagerCompatImpl();
        continue;
      }
      IMPL = new BaseConnectivityManagerCompatImpl();
    }
  }

  public static NetworkInfo getNetworkInfoFromBroadcast(ConnectivityManager paramConnectivityManager, Intent paramIntent)
  {
    int i = ((NetworkInfo)paramIntent.getParcelableExtra("networkInfo")).getType();
    return paramConnectivityManager.getNetworkInfo(i);
  }

  public static boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
  {
    return IMPL.isActiveNetworkMetered(paramConnectivityManager);
  }

  class JellyBeanConnectivityManagerCompatImpl
    implements ConnectivityManagerCompat.ConnectivityManagerCompatImpl
  {
    public boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
    {
      return ConnectivityManagerCompatJellyBean.isActiveNetworkMetered(paramConnectivityManager);
    }
  }

  class HoneycombMR2ConnectivityManagerCompatImpl
    implements ConnectivityManagerCompat.ConnectivityManagerCompatImpl
  {
    public boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
    {
      return ConnectivityManagerCompatHoneycombMR2.isActiveNetworkMetered(paramConnectivityManager);
    }
  }

  class GingerbreadConnectivityManagerCompatImpl
    implements ConnectivityManagerCompat.ConnectivityManagerCompatImpl
  {
    public boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
    {
      return ConnectivityManagerCompatGingerbread.isActiveNetworkMetered(paramConnectivityManager);
    }
  }

  class BaseConnectivityManagerCompatImpl
    implements ConnectivityManagerCompat.ConnectivityManagerCompatImpl
  {
    public boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager)
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
        default:
          break;
        case 1:
          Object localObject = null;
        }
      }
    }
  }

  abstract interface ConnectivityManagerCompatImpl
  {
    public abstract boolean isActiveNetworkMetered(ConnectivityManager paramConnectivityManager);
  }
}