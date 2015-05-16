package android.support.v4.view.accessibility;

import android.os.Bundle;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityNodeProvider;
import dalvik.annotation.EnclosingMethod;
import dalvik.annotation.Signature;
import java.util.List;

@EnclosingMethod
final class AccessibilityNodeProviderCompatJellyBean$1 extends AccessibilityNodeProvider
{
  public AccessibilityNodeInfo createAccessibilityNodeInfo(int paramInt)
  {
    return (AccessibilityNodeInfo)this.val$bridge.createAccessibilityNodeInfo(paramInt);
  }

  @Signature({"(", "Ljava/lang/String;", "I)", "Ljava/util/List", "<", "Landroid/view/accessibility/AccessibilityNodeInfo;", ">;"})
  public List findAccessibilityNodeInfosByText(String paramString, int paramInt)
  {
    return this.val$bridge.findAccessibilityNodeInfosByText(paramString, paramInt);
  }

  public boolean performAction(int paramInt1, int paramInt2, Bundle paramBundle)
  {
    return this.val$bridge.performAction(paramInt1, paramInt2, paramBundle);
  }
}