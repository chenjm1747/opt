package android.support.v4.view.accessibility;

import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class AccessibilityManagerCompat$AccessibilityManagerIcsImpl$1
  implements AccessibilityManagerCompatIcs.AccessibilityStateChangeListenerBridge
{
  public void onAccessibilityStateChanged(boolean paramBoolean)
  {
    this.val$listener.onAccessibilityStateChanged(paramBoolean);
  }
}