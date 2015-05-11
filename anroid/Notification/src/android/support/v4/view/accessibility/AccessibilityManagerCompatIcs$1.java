package android.support.v4.view.accessibility;

import android.view.accessibility.AccessibilityManager.AccessibilityStateChangeListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
final class AccessibilityManagerCompatIcs$1
  implements AccessibilityManager.AccessibilityStateChangeListener
{
  public void onAccessibilityStateChanged(boolean paramBoolean)
  {
    this.val$bridge.onAccessibilityStateChanged(paramBoolean);
  }
}