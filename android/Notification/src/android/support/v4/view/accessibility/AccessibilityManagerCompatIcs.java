package android.support.v4.view.accessibility;

import android.view.accessibility.AccessibilityManager;
import android.view.accessibility.AccessibilityManager.AccessibilityStateChangeListener;
import dalvik.annotation.Signature;
import java.util.List;

class AccessibilityManagerCompatIcs
{
  public static boolean addAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, Object paramObject)
  {
    AccessibilityManager.AccessibilityStateChangeListener localAccessibilityStateChangeListener = (AccessibilityManager.AccessibilityStateChangeListener)paramObject;
    return paramAccessibilityManager.addAccessibilityStateChangeListener(paramObject);
  }

  @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", "I)", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
  public static List getEnabledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager, int paramInt)
  {
    return paramAccessibilityManager.getEnabledAccessibilityServiceList(paramInt);
  }

  @Signature({"(", "Landroid/view/accessibility/AccessibilityManager;", ")", "Ljava/util/List", "<", "Landroid/accessibilityservice/AccessibilityServiceInfo;", ">;"})
  public static List getInstalledAccessibilityServiceList(AccessibilityManager paramAccessibilityManager)
  {
    return paramAccessibilityManager.getInstalledAccessibilityServiceList();
  }

  public static boolean isTouchExplorationEnabled(AccessibilityManager paramAccessibilityManager)
  {
    return paramAccessibilityManager.isTouchExplorationEnabled();
  }

  public static Object newAccessibilityStateChangeListener(AccessibilityStateChangeListenerBridge paramAccessibilityStateChangeListenerBridge)
  {
    return new AccessibilityManagerCompatIcs.1(paramAccessibilityStateChangeListenerBridge);
  }

  public static boolean removeAccessibilityStateChangeListener(AccessibilityManager paramAccessibilityManager, Object paramObject)
  {
    AccessibilityManager.AccessibilityStateChangeListener localAccessibilityStateChangeListener = (AccessibilityManager.AccessibilityStateChangeListener)paramObject;
    return paramAccessibilityManager.removeAccessibilityStateChangeListener(paramObject);
  }

  abstract interface AccessibilityStateChangeListenerBridge
  {
    public abstract void onAccessibilityStateChanged(boolean paramBoolean);
  }
}