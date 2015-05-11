package android.support.v4.view.accessibility;

import android.os.Build.VERSION;
import android.view.accessibility.AccessibilityManager;
import dalvik.annotation.Signature;
import java.util.Collections;
import java.util.List;

public class AccessibilityManagerCompat
{
  private static final AccessibilityManagerVersionImpl IMPL;

  static
  {
    if (Build.VERSION.SDK_INT >= 14)
      IMPL = new AccessibilityManagerIcsImpl();
    while (true)
    {
      return;
      IMPL = new AccessibilityManagerStubImpl();
    }
  }

  public static boolean addAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
  {
    return IMPL.addAccessibilityStateChangeListener(paramAccessibilityManager, paramAccessibilityStateChangeListenerCompat);
  }

  @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", "I)", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
  public static List getEnabledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager, int paramInt)
  {
    return IMPL.getEnabledAccessibilityServiceList(paramAccessibilityManager, paramInt);
  }

  @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", ")", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
  public static List getInstalledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager)
  {
    return IMPL.getInstalledAccessibilityServiceList(paramAccessibilityManager);
  }

  public static boolean isTouchExplorationEnabled(AccessibilityManager paramAccessibilityManager)
  {
    return IMPL.isTouchExplorationEnabled(paramAccessibilityManager);
  }

  public static boolean removeAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
  {
    return IMPL.removeAccessibilityStateChangeListener(paramAccessibilityManager, paramAccessibilityStateChangeListenerCompat);
  }

  public abstract class AccessibilityStateChangeListenerCompat
  {
    final Object mListener;

    public AccessibilityStateChangeListenerCompat()
    {
      this$1 = AccessibilityManagerCompat.IMPL.newAccessiblityStateChangeListener(this);
      this.mListener = this$1;
    }

    public abstract void onAccessibilityStateChanged(boolean paramBoolean);
  }

  class AccessibilityManagerIcsImpl extends AccessibilityManagerCompat.AccessibilityManagerStubImpl
  {
    public boolean addAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      Object localObject = paramAccessibilityStateChangeListenerCompat.mListener;
      return AccessibilityManagerCompatIcs.addAccessibilityStateChangeListener(paramAccessibilityManager, localObject);
    }

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", "I)", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public List getEnabledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager, int paramInt)
    {
      return AccessibilityManagerCompatIcs.getEnabledAccessibilityServiceList(paramAccessibilityManager, paramInt);
    }

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", ")", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public List getInstalledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager)
    {
      return AccessibilityManagerCompatIcs.getInstalledAccessibilityServiceList(paramAccessibilityManager);
    }

    public boolean isTouchExplorationEnabled(AccessibilityManager paramAccessibilityManager)
    {
      return AccessibilityManagerCompatIcs.isTouchExplorationEnabled(paramAccessibilityManager);
    }

    public Object newAccessiblityStateChangeListener(AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      return AccessibilityManagerCompatIcs.newAccessibilityStateChangeListener(new AccessibilityManagerCompat.AccessibilityManagerIcsImpl.1(this, paramAccessibilityStateChangeListenerCompat));
    }

    public boolean removeAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      Object localObject = paramAccessibilityStateChangeListenerCompat.mListener;
      return AccessibilityManagerCompatIcs.removeAccessibilityStateChangeListener(paramAccessibilityManager, localObject);
    }
  }

  class AccessibilityManagerStubImpl
    implements AccessibilityManagerCompat.AccessibilityManagerVersionImpl
  {
    public boolean addAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      return null;
    }

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", "I)", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public List getEnabledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager, int paramInt)
    {
      return Collections.emptyList();
    }

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", ")", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public List getInstalledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager)
    {
      return Collections.emptyList();
    }

    public boolean isTouchExplorationEnabled(AccessibilityManager paramAccessibilityManager)
    {
      return null;
    }

    public Object newAccessiblityStateChangeListener(AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      return null;
    }

    public boolean removeAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat)
    {
      return null;
    }
  }

  abstract interface AccessibilityManagerVersionImpl
  {
    public abstract boolean addAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat);

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", "I)", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public abstract List getEnabledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager, int paramInt);

    @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", ")", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
    public abstract List getInstalledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager);

    public abstract boolean isTouchExplorationEnabled(AccessibilityManager paramAccessibilityManager);

    public abstract Object newAccessiblityStateChangeListener(AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat);

    public abstract boolean removeAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, AccessibilityManagerCompat.AccessibilityStateChangeListenerCompat paramAccessibilityStateChangeListenerCompat);
  }
}