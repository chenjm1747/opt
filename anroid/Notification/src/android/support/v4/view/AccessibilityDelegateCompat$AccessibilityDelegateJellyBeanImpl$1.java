package android.support.v4.view;

import android.os.Bundle;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.view.accessibility.AccessibilityNodeProviderCompat;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class AccessibilityDelegateCompat$AccessibilityDelegateJellyBeanImpl$1
  implements AccessibilityDelegateCompatJellyBean.AccessibilityDelegateBridgeJellyBean
{
  public boolean dispatchPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    return this.val$compat.dispatchPopulateAccessibilityEvent(paramView, paramAccessibilityEvent);
  }

  public Object getAccessibilityNodeProvider(View paramView)
  {
    Object localObject = this.val$compat;
    AccessibilityNodeProviderCompat localAccessibilityNodeProviderCompat = ((AccessibilityDelegateCompat)localObject).getAccessibilityNodeProvider(paramView);
    if (localAccessibilityNodeProviderCompat != null)
      localObject = localAccessibilityNodeProviderCompat.getProvider();
    while (true)
    {
      return localObject;
      int i = 0;
    }
  }

  public void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    this.val$compat.onInitializeAccessibilityEvent(paramView, paramAccessibilityEvent);
  }

  public void onInitializeAccessibilityNodeInfo(View paramView, Object paramObject)
  {
    AccessibilityDelegateCompat localAccessibilityDelegateCompat = this.val$compat;
    AccessibilityNodeInfoCompat localAccessibilityNodeInfoCompat = new AccessibilityNodeInfoCompat(paramObject);
    localAccessibilityDelegateCompat.onInitializeAccessibilityNodeInfo(paramView, localAccessibilityNodeInfoCompat);
  }

  public void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    this.val$compat.onPopulateAccessibilityEvent(paramView, paramAccessibilityEvent);
  }

  public boolean onRequestSendAccessibilityEvent(ViewGroup paramViewGroup, View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    return this.val$compat.onRequestSendAccessibilityEvent(paramViewGroup, paramView, paramAccessibilityEvent);
  }

  public boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
  {
    return this.val$compat.performAccessibilityAction(paramView, paramInt, paramBundle);
  }

  public void sendAccessibilityEvent(View paramView, int paramInt)
  {
    this.val$compat.sendAccessibilityEvent(paramView, paramInt);
  }

  public void sendAccessibilityEventUnchecked(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    this.val$compat.sendAccessibilityEventUnchecked(paramView, paramAccessibilityEvent);
  }
}