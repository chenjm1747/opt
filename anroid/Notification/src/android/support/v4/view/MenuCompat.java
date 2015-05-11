package android.support.v4.view;

import android.os.Build.VERSION;
import android.view.MenuItem;

public class MenuCompat
{
  static final MenuVersionImpl IMPL;

  static
  {
    if (Build.VERSION.SDK_INT >= 11)
      IMPL = new HoneycombMenuVersionImpl();
    while (true)
    {
      return;
      IMPL = new BaseMenuVersionImpl();
    }
  }

  public static boolean setShowAsAction(MenuItem paramMenuItem, int paramInt)
  {
    return IMPL.setShowAsAction(paramMenuItem, paramInt);
  }

  class HoneycombMenuVersionImpl
    implements MenuCompat.MenuVersionImpl
  {
    public boolean setShowAsAction(MenuItem paramMenuItem, int paramInt)
    {
      MenuItemCompatHoneycomb.setShowAsAction(paramMenuItem, paramInt);
      return true;
    }
  }

  class BaseMenuVersionImpl
    implements MenuCompat.MenuVersionImpl
  {
    public boolean setShowAsAction(MenuItem paramMenuItem, int paramInt)
    {
      return null;
    }
  }

  abstract interface MenuVersionImpl
  {
    public abstract boolean setShowAsAction(MenuItem paramMenuItem, int paramInt);
  }
}