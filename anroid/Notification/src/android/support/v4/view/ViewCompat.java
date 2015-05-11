package android.support.v4.view;

import android.graphics.Paint;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.view.accessibility.AccessibilityNodeProviderCompat;
import android.view.View;
import android.view.accessibility.AccessibilityEvent;

public class ViewCompat
{
  private static final long FAKE_FRAME_TIME = 10L;
  static final ViewCompatImpl IMPL;
  public static final int IMPORTANT_FOR_ACCESSIBILITY_AUTO = 0;
  public static final int IMPORTANT_FOR_ACCESSIBILITY_NO = 2;
  public static final int IMPORTANT_FOR_ACCESSIBILITY_YES = 1;
  public static final int LAYER_TYPE_HARDWARE = 2;
  public static final int LAYER_TYPE_NONE = 0;
  public static final int LAYER_TYPE_SOFTWARE = 1;
  public static final int OVER_SCROLL_ALWAYS = 0;
  public static final int OVER_SCROLL_IF_CONTENT_SCROLLS = 1;
  public static final int OVER_SCROLL_NEVER = 2;

  static
  {
    int i = Build.VERSION.SDK_INT;
    if (i >= 17)
      IMPL = new JbMr1ViewCompatImpl();
    while (true)
    {
      return;
      if (i >= 16)
      {
        IMPL = new JBViewCompatImpl();
        continue;
      }
      if (i >= 14)
      {
        IMPL = new ICSViewCompatImpl();
        continue;
      }
      if (i >= 11)
      {
        IMPL = new HCViewCompatImpl();
        continue;
      }
      if (i >= 9)
      {
        IMPL = new GBViewCompatImpl();
        continue;
      }
      IMPL = new BaseViewCompatImpl();
    }
  }

  public static boolean canScrollHorizontally(View paramView, int paramInt)
  {
    return IMPL.canScrollHorizontally(paramView, paramInt);
  }

  public static boolean canScrollVertically(View paramView, int paramInt)
  {
    return IMPL.canScrollVertically(paramView, paramInt);
  }

  public static AccessibilityNodeProviderCompat getAccessibilityNodeProvider(View paramView)
  {
    return IMPL.getAccessibilityNodeProvider(paramView);
  }

  public static int getImportantForAccessibility(View paramView)
  {
    return IMPL.getImportantForAccessibility(paramView);
  }

  public static int getLabelFor(View paramView)
  {
    return IMPL.getLabelFor(paramView);
  }

  public static int getLayerType(View paramView)
  {
    return IMPL.getLayerType(paramView);
  }

  public static int getOverScrollMode(View paramView)
  {
    return IMPL.getOverScrollMode(paramView);
  }

  public static boolean hasTransientState(View paramView)
  {
    return IMPL.hasTransientState(paramView);
  }

  public static void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    IMPL.onInitializeAccessibilityEvent(paramView, paramAccessibilityEvent);
  }

  public static void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
  {
    IMPL.onInitializeAccessibilityNodeInfo(paramView, paramAccessibilityNodeInfoCompat);
  }

  public static void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    IMPL.onPopulateAccessibilityEvent(paramView, paramAccessibilityEvent);
  }

  public static boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
  {
    return IMPL.performAccessibilityAction(paramView, paramInt, paramBundle);
  }

  public static void postInvalidateOnAnimation(View paramView)
  {
    IMPL.postInvalidateOnAnimation(paramView);
  }

  public static void postInvalidateOnAnimation(View paramView, int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    ViewCompatImpl localViewCompatImpl = IMPL;
    View localView = paramView;
    int i = paramInt1;
    int j = paramInt2;
    int k = paramInt3;
    int m = paramInt4;
    localViewCompatImpl.postInvalidateOnAnimation(localView, i, j, k, m);
  }

  public static void postOnAnimation(View paramView, Runnable paramRunnable)
  {
    IMPL.postOnAnimation(paramView, paramRunnable);
  }

  public static void postOnAnimationDelayed(View paramView, Runnable paramRunnable, long paramLong)
  {
    IMPL.postOnAnimationDelayed(paramView, paramRunnable, paramLong);
  }

  public static void setAccessibilityDelegate(View paramView, AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
  {
    IMPL.setAccessibilityDelegate(paramView, paramAccessibilityDelegateCompat);
  }

  public static void setHasTransientState(View paramView, boolean paramBoolean)
  {
    IMPL.setHasTransientState(paramView, paramBoolean);
  }

  public static void setImportantForAccessibility(View paramView, int paramInt)
  {
    IMPL.setImportantForAccessibility(paramView, paramInt);
  }

  public static void setLabelFor(View paramView, int paramInt)
  {
    IMPL.setLabelFor(paramView, paramInt);
  }

  public static void setLayerType(View paramView, int paramInt, Paint paramPaint)
  {
    IMPL.setLayerType(paramView, paramInt, paramPaint);
  }

  public static void setOverScrollMode(View paramView, int paramInt)
  {
    IMPL.setOverScrollMode(paramView, paramInt);
  }

  class JbMr1ViewCompatImpl extends ViewCompat.JBViewCompatImpl
  {
    public int getLabelFor(View paramView)
    {
      return ViewCompatJellybeanMr1.getLabelFor(paramView);
    }

    public void setLabelFor(View paramView, int paramInt)
    {
      ViewCompatJellybeanMr1.setLabelFor(paramView, paramInt);
    }
  }

  class JBViewCompatImpl extends ViewCompat.ICSViewCompatImpl
  {
    public AccessibilityNodeProviderCompat getAccessibilityNodeProvider(View paramView)
    {
      Object localObject = ViewCompatJB.getAccessibilityNodeProvider(paramView);
      AccessibilityNodeProviderCompat localAccessibilityNodeProviderCompat;
      if (localObject != null)
        localAccessibilityNodeProviderCompat = new AccessibilityNodeProviderCompat(localObject);
      while (true)
      {
        return localAccessibilityNodeProviderCompat;
        int i = 0;
      }
    }

    public int getImportantForAccessibility(View paramView)
    {
      return ViewCompatJB.getImportantForAccessibility(paramView);
    }

    public boolean hasTransientState(View paramView)
    {
      return ViewCompatJB.hasTransientState(paramView);
    }

    public boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
    {
      return ViewCompatJB.performAccessibilityAction(paramView, paramInt, paramBundle);
    }

    public void postInvalidateOnAnimation(View paramView)
    {
      ViewCompatJB.postInvalidateOnAnimation(paramView);
    }

    public void postInvalidateOnAnimation(View paramView, int paramInt1, int paramInt2, int paramInt3, int paramInt4)
    {
      ViewCompatJB.postInvalidateOnAnimation(paramView, paramInt1, paramInt2, paramInt3, paramInt4);
    }

    public void postOnAnimation(View paramView, Runnable paramRunnable)
    {
      ViewCompatJB.postOnAnimation(paramView, paramRunnable);
    }

    public void postOnAnimationDelayed(View paramView, Runnable paramRunnable, long paramLong)
    {
      ViewCompatJB.postOnAnimationDelayed(paramView, paramRunnable, paramLong);
    }

    public void setHasTransientState(View paramView, boolean paramBoolean)
    {
      ViewCompatJB.setHasTransientState(paramView, paramBoolean);
    }

    public void setImportantForAccessibility(View paramView, int paramInt)
    {
      ViewCompatJB.setImportantForAccessibility(paramView, paramInt);
    }
  }

  class ICSViewCompatImpl extends ViewCompat.HCViewCompatImpl
  {
    public boolean canScrollHorizontally(View paramView, int paramInt)
    {
      return ViewCompatICS.canScrollHorizontally(paramView, paramInt);
    }

    public boolean canScrollVertically(View paramView, int paramInt)
    {
      return ViewCompatICS.canScrollVertically(paramView, paramInt);
    }

    public void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      ViewCompatICS.onInitializeAccessibilityEvent(paramView, paramAccessibilityEvent);
    }

    public void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
    {
      Object localObject = paramAccessibilityNodeInfoCompat.getInfo();
      ViewCompatICS.onInitializeAccessibilityNodeInfo(paramView, localObject);
    }

    public void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      ViewCompatICS.onPopulateAccessibilityEvent(paramView, paramAccessibilityEvent);
    }

    public void setAccessibilityDelegate(View paramView, AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
    {
      Object localObject = paramAccessibilityDelegateCompat.getBridge();
      ViewCompatICS.setAccessibilityDelegate(paramView, localObject);
    }
  }

  class HCViewCompatImpl extends ViewCompat.GBViewCompatImpl
  {
    long getFrameTime()
    {
      return ViewCompatHC.getFrameTime();
    }

    public int getLayerType(View paramView)
    {
      return ViewCompatHC.getLayerType(paramView);
    }

    public void setLayerType(View paramView, int paramInt, Paint paramPaint)
    {
      ViewCompatHC.setLayerType(paramView, paramInt, paramPaint);
    }
  }

  class GBViewCompatImpl extends ViewCompat.BaseViewCompatImpl
  {
    public int getOverScrollMode(View paramView)
    {
      return ViewCompatGingerbread.getOverScrollMode(paramView);
    }

    public void setOverScrollMode(View paramView, int paramInt)
    {
      ViewCompatGingerbread.setOverScrollMode(paramView, paramInt);
    }
  }

  class BaseViewCompatImpl
    implements ViewCompat.ViewCompatImpl
  {
    public boolean canScrollHorizontally(View paramView, int paramInt)
    {
      return null;
    }

    public boolean canScrollVertically(View paramView, int paramInt)
    {
      return null;
    }

    public AccessibilityNodeProviderCompat getAccessibilityNodeProvider(View paramView)
    {
      return null;
    }

    long getFrameTime()
    {
      return 10L;
    }

    public int getImportantForAccessibility(View paramView)
    {
      return null;
    }

    public int getLabelFor(View paramView)
    {
      return null;
    }

    public int getLayerType(View paramView)
    {
      return null;
    }

    public int getOverScrollMode(View paramView)
    {
      return 2;
    }

    public boolean hasTransientState(View paramView)
    {
      return null;
    }

    public void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
    }

    public void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
    {
    }

    public void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
    }

    public boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
    {
      return null;
    }

    public void postInvalidateOnAnimation(View paramView)
    {
      long l = getFrameTime();
      Object localObject;
      paramView.postInvalidateDelayed(localObject);
    }

    public void postInvalidateOnAnimation(View paramView, int paramInt1, int paramInt2, int paramInt3, int paramInt4)
    {
      long l = getFrameTime();
      View localView = paramView;
      int i = paramInt1;
      int j = paramInt2;
      int k = paramInt3;
      int m = paramInt4;
      Object localObject;
      localView.postInvalidateDelayed(localObject, i, j, k, m);
    }

    public void postOnAnimation(View paramView, Runnable paramRunnable)
    {
      long l = getFrameTime();
      Object localObject;
      paramView.postDelayed(paramRunnable, localObject);
    }

    public void postOnAnimationDelayed(View paramView, Runnable paramRunnable, long paramLong)
    {
      long l = getFrameTime() + paramLong;
      paramView.postDelayed(paramRunnable, l);
    }

    public void setAccessibilityDelegate(View paramView, AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
    {
    }

    public void setHasTransientState(View paramView, boolean paramBoolean)
    {
    }

    public void setImportantForAccessibility(View paramView, int paramInt)
    {
    }

    public void setLabelFor(View paramView, int paramInt)
    {
    }

    public void setLayerType(View paramView, int paramInt, Paint paramPaint)
    {
    }

    public void setOverScrollMode(View paramView, int paramInt)
    {
    }
  }

  abstract interface ViewCompatImpl
  {
    public abstract boolean canScrollHorizontally(View paramView, int paramInt);

    public abstract boolean canScrollVertically(View paramView, int paramInt);

    public abstract AccessibilityNodeProviderCompat getAccessibilityNodeProvider(View paramView);

    public abstract int getImportantForAccessibility(View paramView);

    public abstract int getLabelFor(View paramView);

    public abstract int getLayerType(View paramView);

    public abstract int getOverScrollMode(View paramView);

    public abstract boolean hasTransientState(View paramView);

    public abstract void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat);

    public abstract void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle);

    public abstract void postInvalidateOnAnimation(View paramView);

    public abstract void postInvalidateOnAnimation(View paramView, int paramInt1, int paramInt2, int paramInt3, int paramInt4);

    public abstract void postOnAnimation(View paramView, Runnable paramRunnable);

    public abstract void postOnAnimationDelayed(View paramView, Runnable paramRunnable, long paramLong);

    public abstract void setAccessibilityDelegate(View paramView, AccessibilityDelegateCompat paramAccessibilityDelegateCompat);

    public abstract void setHasTransientState(View paramView, boolean paramBoolean);

    public abstract void setImportantForAccessibility(View paramView, int paramInt);

    public abstract void setLabelFor(View paramView, int paramInt);

    public abstract void setLayerType(View paramView, int paramInt, Paint paramPaint);

    public abstract void setOverScrollMode(View paramView, int paramInt);
  }
}