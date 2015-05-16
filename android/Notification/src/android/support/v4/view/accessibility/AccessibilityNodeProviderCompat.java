package android.support.v4.view.accessibility;

import android.os.Build.VERSION;
import android.os.Bundle;
import dalvik.annotation.Signature;
import java.util.List;

public class AccessibilityNodeProviderCompat
{
  private static final AccessibilityNodeProviderImpl IMPL;
  private final Object mProvider;

  static
  {
    if (Build.VERSION.SDK_INT >= 16)
      IMPL = new AccessibilityNodeProviderJellyBeanImpl();
    while (true)
    {
      return;
      IMPL = new AccessibilityNodeProviderStubImpl();
    }
  }

  public AccessibilityNodeProviderCompat()
  {
    Object localObject = IMPL.newAccessibilityNodeProviderBridge(this);
    this.mProvider = localObject;
  }

  public AccessibilityNodeProviderCompat(Object paramObject)
  {
    this.mProvider = paramObject;
  }

  public AccessibilityNodeInfoCompat createAccessibilityNodeInfo(int paramInt)
  {
    return null;
  }

  @Signature({"(", "Ljava/lang/String;", "I)", "Ljava/util/List", "<", "Landroid/support/v4/view/accessibility/AccessibilityNodeInfoCompat;", ">;"})
  public List findAccessibilityNodeInfosByText(String paramString, int paramInt)
  {
    return null;
  }

  public Object getProvider()
  {
    return this.mProvider;
  }

  public boolean performAction(int paramInt1, int paramInt2, Bundle paramBundle)
  {
    return null;
  }

  class AccessibilityNodeProviderJellyBeanImpl extends AccessibilityNodeProviderCompat.AccessibilityNodeProviderStubImpl
  {
    public Object newAccessibilityNodeProviderBridge(AccessibilityNodeProviderCompat paramAccessibilityNodeProviderCompat)
    {
      return AccessibilityNodeProviderCompatJellyBean.newAccessibilityNodeProviderBridge(new AccessibilityNodeProviderCompat.AccessibilityNodeProviderJellyBeanImpl.1(this, paramAccessibilityNodeProviderCompat));
    }
  }

  class AccessibilityNodeProviderStubImpl
    implements AccessibilityNodeProviderCompat.AccessibilityNodeProviderImpl
  {
    public Object newAccessibilityNodeProviderBridge(AccessibilityNodeProviderCompat paramAccessibilityNodeProviderCompat)
    {
      return null;
    }
  }

  abstract interface AccessibilityNodeProviderImpl
  {
    public abstract Object newAccessibilityNodeProviderBridge(AccessibilityNodeProviderCompat paramAccessibilityNodeProviderCompat);
  }
}