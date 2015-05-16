package android.support.v4.view;

import android.os.Build.VERSION;
import android.view.KeyEvent;

public class KeyEventCompat
{
  static final KeyEventVersionImpl IMPL;

  static
  {
    if (Build.VERSION.SDK_INT >= 11)
      IMPL = new HoneycombKeyEventVersionImpl();
    while (true)
    {
      return;
      IMPL = new BaseKeyEventVersionImpl();
    }
  }

  public static boolean hasModifiers(KeyEvent paramKeyEvent, int paramInt)
  {
    KeyEventVersionImpl localKeyEventVersionImpl = IMPL;
    int i = paramKeyEvent.getMetaState();
    return localKeyEventVersionImpl.metaStateHasModifiers(i, paramInt);
  }

  public static boolean hasNoModifiers(KeyEvent paramKeyEvent)
  {
    KeyEventVersionImpl localKeyEventVersionImpl = IMPL;
    int i = paramKeyEvent.getMetaState();
    return localKeyEventVersionImpl.metaStateHasNoModifiers(i);
  }

  public static boolean metaStateHasModifiers(int paramInt1, int paramInt2)
  {
    return IMPL.metaStateHasModifiers(paramInt1, paramInt2);
  }

  public static boolean metaStateHasNoModifiers(int paramInt)
  {
    return IMPL.metaStateHasNoModifiers(paramInt);
  }

  public static int normalizeMetaState(int paramInt)
  {
    return IMPL.normalizeMetaState(paramInt);
  }

  class HoneycombKeyEventVersionImpl
    implements KeyEventCompat.KeyEventVersionImpl
  {
    public boolean metaStateHasModifiers(int paramInt1, int paramInt2)
    {
      return KeyEventCompatHoneycomb.metaStateHasModifiers(paramInt1, paramInt2);
    }

    public boolean metaStateHasNoModifiers(int paramInt)
    {
      return KeyEventCompatHoneycomb.metaStateHasNoModifiers(paramInt);
    }

    public int normalizeMetaState(int paramInt)
    {
      return KeyEventCompatHoneycomb.normalizeMetaState(paramInt);
    }
  }

  class BaseKeyEventVersionImpl
    implements KeyEventCompat.KeyEventVersionImpl
  {
    private static final int META_ALL_MASK = 247;
    private static final int META_MODIFIER_MASK = 247;

    private static int metaStateFilterDirectionalModifiers(int paramInt1, int paramInt2, int paramInt3, int paramInt4, int paramInt5)
    {
      int i = 1;
      Object localObject2 = null;
      int j;
      int k;
      if ((paramInt2 & paramInt3) != 0)
      {
        j = i;
        k = paramInt4 | paramInt5;
        if ((paramInt2 & k) == 0)
          break label56;
      }
      label56: Object localObject1;
      while (true)
      {
        if (j == null)
          break label77;
        if (i == null)
          break label63;
        throw new IllegalArgumentException("bad arguments");
        Object localObject3 = localObject2;
        break;
        localObject1 = localObject2;
      }
      label63: int m = k ^ 0xFFFFFFFF;
      paramInt1 &= m;
      while (true)
      {
        return paramInt1;
        label77: if (localObject1 == null)
          continue;
        int n = paramInt3 ^ 0xFFFFFFFF;
        paramInt1 &= n;
      }
    }

    public boolean metaStateHasModifiers(int paramInt1, int paramInt2)
    {
      int i = 1;
      if (metaStateFilterDirectionalModifiers(metaStateFilterDirectionalModifiers(normalizeMetaState(paramInt1) & 0xF7, paramInt2, i, 64, 128), paramInt2, 2, 16, 32) == paramInt2);
      while (true)
      {
        return i;
        Object localObject = null;
      }
    }

    public boolean metaStateHasNoModifiers(int paramInt)
    {
      int i = normalizeMetaState(paramInt) & 0xF7;
      if (i == 0)
        i = 1;
      while (true)
      {
        return i;
        Object localObject = null;
      }
    }

    public int normalizeMetaState(int paramInt)
    {
      if ((paramInt & 0xC0) != 0)
        paramInt |= 1;
      if ((paramInt & 0x30) != 0)
        paramInt |= 2;
      return paramInt & 0xF7;
    }
  }

  abstract interface KeyEventVersionImpl
  {
    public abstract boolean metaStateHasModifiers(int paramInt1, int paramInt2);

    public abstract boolean metaStateHasNoModifiers(int paramInt);

    public abstract int normalizeMetaState(int paramInt);
  }
}