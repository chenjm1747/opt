package android.support.v4.view.accessibility;

import android.os.Bundle;
import dalvik.annotation.Signature;
import java.util.List;

class AccessibilityNodeProviderCompatJellyBean
{
  public static Object newAccessibilityNodeProviderBridge(AccessibilityNodeInfoBridge paramAccessibilityNodeInfoBridge)
  {
    return new AccessibilityNodeProviderCompatJellyBean.1(paramAccessibilityNodeInfoBridge);
  }

  abstract interface AccessibilityNodeInfoBridge
  {
    public abstract Object createAccessibilityNodeInfo(int paramInt);

    @Signature({"(", "Ljava/lang/String;", "I)", "Ljava/util/List", "<", "Ljava/lang/Object;", ">;"})
    public abstract List findAccessibilityNodeInfosByText(String paramString, int paramInt);

    public abstract boolean performAction(int paramInt1, int paramInt2, Bundle paramBundle);
  }
}