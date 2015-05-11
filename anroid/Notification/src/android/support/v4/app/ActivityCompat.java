package android.support.v4.app;

import android.app.Activity;
import android.os.Build.VERSION;
import android.support.v4.content.ContextCompat;

public class ActivityCompat extends ContextCompat
{
  public static boolean invalidateOptionsMenu(Activity paramActivity)
  {
    int i = Build.VERSION.SDK_INT;
    if (i >= 11)
    {
      ActivityCompatHoneycomb.invalidateOptionsMenu(paramActivity);
      i = 1;
    }
    while (true)
    {
      return i;
      Object localObject = null;
    }
  }
}