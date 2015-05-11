package android.support.v4.view;

import android.os.Build.VERSION;
import android.os.Bundle;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.view.accessibility.AccessibilityNodeProviderCompat;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;

public class AccessibilityDelegateCompat
{
  private static final Object DEFAULT_DELEGATE;
  private static final AccessibilityDelegateImpl IMPL;
  final Object mBridge;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new AccessibilityDelegateJellyBeanImpl();
    while (true)
    {
      DEFAULT_DELEGATE = IMPL.newAccessiblityDelegateDefaultImpl();
      return;
      if (Build.VERSION.SDK_INT >= 14)
      {
        IMPL = new AccessibilityDelegateIcsImpl();
        continue;
      }
      IMPL = new AccessibilityDelegateStubImpl();
    }
  }

  public AccessibilityDelegateCompat()
  {
    Object localObject = IMPL.newAccessiblityDelegateBridge(this);
    this.mBridge = localObject;
  }

  public boolean dispatchPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    return localAccessibilityDelegateImpl.dispatchPopulateAccessibilityEvent(localObject, paramView, paramAccessibilityEvent);
  }

  public AccessibilityNodeProviderCompat getAccessibilityNodeProvider(View paramView)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    return localAccessibilityDelegateImpl.getAccessibilityNodeProvider(localObject, paramView);
  }

  Object getBridge()
  {
    return this.mBridge;
  }

  public void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    localAccessibilityDelegateImpl.onInitializeAccessibilityEvent(localObject, paramView, paramAccessibilityEvent);
  }

  public void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    localAccessibilityDelegateImpl.onInitializeAccessibilityNodeInfo(localObject, paramView, paramAccessibilityNodeInfoCompat);
  }

  public void onPopulateAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    localAccessibilityDelegateImpl.onPopulateAccessibilityEvent(localObject, paramView, paramAccessibilityEvent);
  }

  public boolean onRequestSendAccessibilityEvent(ViewGroup paramViewGroup, View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    return localAccessibilityDelegateImpl.onRequestSendAccessibilityEvent(localObject, paramViewGroup, paramView, paramAccessibilityEvent);
  }

  public boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    return localAccessibilityDelegateImpl.performAccessibilityAction(localObject, paramView, paramInt, paramBundle);
  }

  public void sendAccessibilityEvent(View paramView, int paramInt)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    localAccessibilityDelegateImpl.sendAccessibilityEvent(localObject, paramView, paramInt);
  }

  public void sendAccessibilityEventUnchecked(View paramView, AccessibilityEvent paramAccessibilityEvent)
  {
    AccessibilityDelegateImpl localAccessibilityDelegateImpl = IMPL;
    Object localObject = DEFAULT_DELEGATE;
    localAccessibilityDelegateImpl.sendAccessibilityEventUnchecked(localObject, paramView, paramAccessibilityEvent);
  }

  class AccessibilityDelegateJellyBeanImpl extends AccessibilityDelegateCompat.AccessibilityDelegateIcsImpl
  {
    public AccessibilityNodeProviderCompat getAccessibilityNodeProvider(Object paramObject, View paramView)
    {
      Object localObject = AccessibilityDelegateCompatJellyBean.getAccessibilityNodeProvider(paramObject, paramView);
      AccessibilityNodeProviderCompat localAccessibilityNodeProviderCompat;
      if (localObject != null)
        localAccessibilityNodeProviderCompat = new AccessibilityNodeProviderCompat(localObject);
      while (true)
      {
        return localAccessibilityNodeProviderCompat;
        int i = 0;
      }
    }

    public Object newAccessiblityDelegateBridge(AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
    {
      return AccessibilityDelegateCompatJellyBean.newAccessibilityDelegateBridge(new AccessibilityDelegateCompat.AccessibilityDelegateJellyBeanImpl.1(this, paramAccessibilityDelegateCompat));
    }

    public boolean performAccessibilityAction(Object paramObject, View paramView, int paramInt, Bundle paramBundle)
    {
      return AccessibilityDelegateCompatJellyBean.performAccessibilityAction(paramObject, paramView, paramInt, paramBundle);
    }
  }

  class AccessibilityDelegateIcsImpl extends AccessibilityDelegateCompat.AccessibilityDelegateStubImpl
  {
    public boolean dispatchPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      return AccessibilityDelegateCompatIcs.dispatchPopulateAccessibilityEvent(paramObject, paramView, paramAccessibilityEvent);
    }

    public Object newAccessiblityDelegateBridge(AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
    {
      return AccessibilityDelegateCompatIcs.newAccessibilityDelegateBridge(new AccessibilityDelegateCompat.AccessibilityDelegateIcsImpl.1(this, paramAccessibilityDelegateCompat));
    }

    public Object newAccessiblityDelegateDefaultImpl()
    {
      return AccessibilityDelegateCompatIcs.newAccessibilityDelegateDefaultImpl();
    }

    public void onInitializeAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      AccessibilityDelegateCompatIcs.onInitializeAccessibilityEvent(paramObject, paramView, paramAccessibilityEvent);
    }

    public void onInitializeAccessibilityNodeInfo(Object paramObject, View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
    {
      Object localObject = paramAccessibilityNodeInfoCompat.getInfo();
      AccessibilityDelegateCompatIcs.onInitializeAccessibilityNodeInfo(paramObject, paramView, localObject);
    }

    public void onPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      AccessibilityDelegateCompatIcs.onPopulateAccessibilityEvent(paramObject, paramView, paramAccessibilityEvent);
    }

    public boolean onRequestSendAccessibilityEvent(Object paramObject, ViewGroup paramViewGroup, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      return AccessibilityDelegateCompatIcs.onRequestSendAccessibilityEvent(paramObject, paramViewGroup, paramView, paramAccessibilityEvent);
    }

    public void sendAccessibilityEvent(Object paramObject, View paramView, int paramInt)
    {
      AccessibilityDelegateCompatIcs.sendAccessibilityEvent(paramObject, paramView, paramInt);
    }

    public void sendAccessibilityEventUnchecked(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      AccessibilityDelegateCompatIcs.sendAccessibilityEventUnchecked(paramObject, paramView, paramAccessibilityEvent);
    }
  }

  class AccessibilityDelegateStubImpl
    implements AccessibilityDelegateCompat.AccessibilityDelegateImpl
  {
    public boolean dispatchPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      return null;
    }

    public AccessibilityNodeProviderCompat getAccessibilityNodeProvider(Object paramObject, View paramView)
    {
      return null;
    }

    public Object newAccessiblityDelegateBridge(AccessibilityDelegateCompat paramAccessibilityDelegateCompat)
    {
      return null;
    }

    public Object newAccessiblityDelegateDefaultImpl()
    {
      return null;
    }

    public void onInitializeAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
    }

    public void onInitializeAccessibilityNodeInfo(Object paramObject, View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
    {
    }

    public void onPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
    }

    public boolean onRequestSendAccessibilityEvent(Object paramObject, ViewGroup paramViewGroup, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      return true;
    }

    public boolean performAccessibilityAction(Object paramObject, View paramView, int paramInt, Bundle paramBundle)
    {
      return null;
    }

    public void sendAccessibilityEvent(Object paramObject, View paramView, int paramInt)
    {
    }

    public void sendAccessibilityEventUnchecked(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
    }
  }

  abstract interface AccessibilityDelegateImpl
  {
    public abstract boolean dispatchPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract AccessibilityNodeProviderCompat getAccessibilityNodeProvider(Object paramObject, View paramView);

    public abstract Object newAccessiblityDelegateBridge(AccessibilityDelegateCompat paramAccessibilityDelegateCompat);

    public abstract Object newAccessiblityDelegateDefaultImpl();

    public abstract void onInitializeAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract void onInitializeAccessibilityNodeInfo(Object paramObject, View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat);

    public abstract void onPopulateAccessibilityEvent(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract boolean onRequestSendAccessibilityEvent(Object paramObject, ViewGroup paramViewGroup, View paramView, AccessibilityEvent paramAccessibilityEvent);

    public abstract boolean performAccessibilityAction(Object paramObject, View paramView, int paramInt, Bundle paramBundle);

    public abstract void sendAccessibilityEvent(Object paramObject, View paramView, int paramInt);

    public abstract void sendAccessibilityEventUnchecked(Object paramObject, View paramView, AccessibilityEvent paramAccessibilityEvent);
  }
}