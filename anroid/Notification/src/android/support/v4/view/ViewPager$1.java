package android.support.v4.view;

import dalvik.annotation.Signature;
import java.util.Comparator;

@Signature({"Ljava/lang/Object;", "Ljava/util/Comparator", "<", "Landroid/support/v4/view/ViewPager$ItemInfo;", ">;"})
final class ViewPager$1
  implements Comparator
{
  public int compare(ViewPager.ItemInfo paramItemInfo1, ViewPager.ItemInfo paramItemInfo2)
  {
    int i = paramItemInfo1.position;
    int j = paramItemInfo2.position;
    return i - j;
  }
}