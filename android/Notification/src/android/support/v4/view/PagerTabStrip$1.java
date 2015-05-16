package android.support.v4.view;

import android.view.View;
import android.view.View.OnClickListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class PagerTabStrip$1
  implements View.OnClickListener
{
  public void onClick(View paramView)
  {
    ViewPager localViewPager = this.this$0.mPager;
    int i = this.this$0.mPager.getCurrentItem();
    int j;
    j--;
    localViewPager.setCurrentItem(i);
  }
}