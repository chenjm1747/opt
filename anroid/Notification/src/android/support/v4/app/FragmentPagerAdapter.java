package android.support.v4.app;

import android.os.Parcelable;
import android.support.v4.view.PagerAdapter;
import android.view.View;
import android.view.ViewGroup;

public abstract class FragmentPagerAdapter extends PagerAdapter
{
  private static final boolean DEBUG = false;
  private static final String TAG = "FragmentPagerAdapter";
  private FragmentTransaction mCurTransaction = null;
  private Fragment mCurrentPrimaryItem = null;
  private final FragmentManager mFragmentManager;

  public FragmentPagerAdapter(FragmentManager paramFragmentManager)
  {
    this.mFragmentManager = paramFragmentManager;
  }

  private static String makeFragmentName(int paramInt, long paramLong)
  {
    return "android:switcher:" + paramInt + ":" + paramLong;
  }

  public void destroyItem(ViewGroup paramViewGroup, int paramInt, Object paramObject)
  {
    if (this.mCurTransaction == null)
    {
      FragmentTransaction localFragmentTransaction1 = this.mFragmentManager.beginTransaction();
      this.mCurTransaction = localFragmentTransaction1;
    }
    FragmentTransaction localFragmentTransaction2 = this.mCurTransaction;
    Fragment localFragment = (Fragment)paramObject;
    localFragmentTransaction2.detach(paramObject);
  }

  public void finishUpdate(ViewGroup paramViewGroup)
  {
    if (this.mCurTransaction != null)
    {
      this.mCurTransaction.commitAllowingStateLoss();
      this.mCurTransaction = null;
      this.mFragmentManager.executePendingTransactions();
    }
  }

  public abstract Fragment getItem(int paramInt);

  public long getItemId(int paramInt)
  {
    return paramInt;
  }

  public Object instantiateItem(ViewGroup paramViewGroup, int paramInt)
  {
    boolean bool = null;
    if (this.mCurTransaction == null)
    {
      FragmentTransaction localFragmentTransaction1 = this.mFragmentManager.beginTransaction();
      this.mCurTransaction = localFragmentTransaction1;
    }
    long l = getItemId(paramInt);
    Object localObject;
    String str1 = makeFragmentName(paramViewGroup.getId(), localObject);
    Fragment localFragment1 = this.mFragmentManager.findFragmentByTag(str1);
    if (localFragment1 != null)
      this.mCurTransaction.attach(localFragment1);
    while (true)
    {
      Fragment localFragment2 = this.mCurrentPrimaryItem;
      if (localFragment1 != localFragment2)
      {
        localFragment1.setMenuVisibility(bool);
        localFragment1.setUserVisibleHint(bool);
      }
      return localFragment1;
      localFragment1 = getItem(paramInt);
      FragmentTransaction localFragmentTransaction2 = this.mCurTransaction;
      int i = paramViewGroup.getId();
      String str2 = makeFragmentName(paramViewGroup.getId(), localObject);
      localFragmentTransaction2.add(i, localFragment1, str2);
    }
  }

  public boolean isViewFromObject(View paramView, Object paramObject)
  {
    View localView = ((Fragment)paramObject).getView();
    int i;
    if (localView == paramView)
      i = 1;
    while (true)
    {
      return i;
      Object localObject = null;
    }
  }

  public void restoreState(Parcelable paramParcelable, ClassLoader paramClassLoader)
  {
  }

  public Parcelable saveState()
  {
    return null;
  }

  public void setPrimaryItem(ViewGroup paramViewGroup, int paramInt, Object paramObject)
  {
    boolean bool1 = true;
    boolean bool2 = null;
    Fragment localFragment1 = (Fragment)paramObject;
    Fragment localFragment2 = this.mCurrentPrimaryItem;
    if (localFragment1 != localFragment2)
    {
      if (this.mCurrentPrimaryItem != null)
      {
        this.mCurrentPrimaryItem.setMenuVisibility(bool2);
        this.mCurrentPrimaryItem.setUserVisibleHint(bool2);
      }
      if (localFragment1 != null)
      {
        localFragment1.setMenuVisibility(bool1);
        localFragment1.setUserVisibleHint(bool1);
      }
      this.mCurrentPrimaryItem = localFragment1;
    }
  }

  public void startUpdate(ViewGroup paramViewGroup)
  {
  }
}