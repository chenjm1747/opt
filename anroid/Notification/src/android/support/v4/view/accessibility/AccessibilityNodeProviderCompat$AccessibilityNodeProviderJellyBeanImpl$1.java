package android.support.v4.view.accessibility;

import android.os.Bundle;
import dalvik.annotation.EnclosingMethod;
import dalvik.annotation.Signature;
import java.util.ArrayList;
import java.util.List;

@EnclosingMethod
class AccessibilityNodeProviderCompat$AccessibilityNodeProviderJellyBeanImpl$1
  implements AccessibilityNodeProviderCompatJellyBean.AccessibilityNodeInfoBridge
{
  public Object createAccessibilityNodeInfo(int paramInt)
  {
    AccessibilityNodeProviderCompat localAccessibilityNodeProviderCompat = this.val$compat;
    AccessibilityNodeInfoCompat localAccessibilityNodeInfoCompat = localAccessibilityNodeProviderCompat.createAccessibilityNodeInfo(paramInt);
    int i;
    if (localAccessibilityNodeInfoCompat == null)
      i = 0;
    while (true)
    {
      return i;
      Object localObject = localAccessibilityNodeInfoCompat.getInfo();
    }
  }

  @Signature({"(", "Ljava/lang/String;", "I)", "Ljava/util/List", "<", "Ljava/lang/Object;", ">;"})
  public List findAccessibilityNodeInfosByText(String paramString, int paramInt)
  {
    List localList = this.val$compat.findAccessibilityNodeInfosByText(paramString, paramInt);
    ArrayList localArrayList = new ArrayList();
    int i = localList.size();
    for (int j = 0; j < i; j++)
    {
      Object localObject = ((AccessibilityNodeInfoCompat)localList.get(j)).getInfo();
      localArrayList.add(localObject);
    }
    return localArrayList;
  }

  public boolean performAction(int paramInt1, int paramInt2, Bundle paramBundle)
  {
    return this.val$compat.performAction(paramInt1, paramInt2, paramBundle);
  }
}