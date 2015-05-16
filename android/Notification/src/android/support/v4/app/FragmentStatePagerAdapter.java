package android.support.v4.app;

import android.os.Bundle;
import android.os.Parcelable;
import android.support.v4.view.PagerAdapter;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import dalvik.annotation.Signature;
import java.util.ArrayList;
import java.util.Iterator;

public abstract class FragmentStatePagerAdapter extends PagerAdapter
{
  private static final boolean DEBUG = false;
  private static final String TAG = "FragmentStatePagerAdapter";
  private FragmentTransaction mCurTransaction = null;
  private Fragment mCurrentPrimaryItem;
  private final FragmentManager mFragmentManager;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
  private ArrayList mFragments;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment$SavedState;", ">;"})
  private ArrayList mSavedState;

  public FragmentStatePagerAdapter(FragmentManager paramFragmentManager)
  {
    ArrayList localArrayList1 = new ArrayList();
    this.mSavedState = localArrayList1;
    ArrayList localArrayList2 = new ArrayList();
    this.mFragments = localArrayList2;
    this.mCurrentPrimaryItem = null;
    this.mFragmentManager = paramFragmentManager;
  }

  public void destroyItem(ViewGroup paramViewGroup, int paramInt, Object paramObject)
  {
    Object localObject = null;
    Fragment localFragment = (Fragment)paramObject;
    if (this.mCurTransaction == null)
    {
      FragmentTransaction localFragmentTransaction = this.mFragmentManager.beginTransaction();
      this.mCurTransaction = localFragmentTransaction;
    }
    while (this.mSavedState.size() <= paramInt)
      this.mSavedState.add(localObject);
    ArrayList localArrayList = this.mSavedState;
    Fragment.SavedState localSavedState = this.mFragmentManager.saveFragmentInstanceState(localFragment);
    localArrayList.set(paramInt, localSavedState);
    this.mFragments.set(paramInt, localObject);
    this.mCurTransaction.remove(localFragment);
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

  public Object instantiateItem(ViewGroup paramViewGroup, int paramInt)
  {
    boolean bool = null;
    Object localObject;
    if (this.mFragments.size() > paramInt)
    {
      localObject = (Fragment)this.mFragments.get(paramInt);
      if (localObject == null);
    }
    while (true)
    {
      return localObject;
      if (this.mCurTransaction == null)
      {
        FragmentTransaction localFragmentTransaction1 = this.mFragmentManager.beginTransaction();
        this.mCurTransaction = localFragmentTransaction1;
      }
      Fragment localFragment = getItem(paramInt);
      if (this.mSavedState.size() > paramInt)
      {
        Fragment.SavedState localSavedState = (Fragment.SavedState)this.mSavedState.get(paramInt);
        if (localSavedState != null)
          localFragment.setInitialSavedState(localSavedState);
      }
      while (this.mFragments.size() <= paramInt)
        this.mFragments.add(null);
      localFragment.setMenuVisibility(bool);
      localFragment.setUserVisibleHint(bool);
      this.mFragments.set(paramInt, localFragment);
      FragmentTransaction localFragmentTransaction2 = this.mCurTransaction;
      int i = paramViewGroup.getId();
      localFragmentTransaction2.add(i, localFragment);
      localObject = localFragment;
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
    if (paramParcelable != null)
    {
      Bundle localBundle = (Bundle)paramParcelable;
      localBundle.setClassLoader(paramClassLoader);
      Parcelable[] arrayOfParcelable = localBundle.getParcelableArray("states");
      this.mSavedState.clear();
      this.mFragments.clear();
      if (arrayOfParcelable != null)
      {
        Object localObject = null;
        while (true)
        {
          int i = arrayOfParcelable.length;
          if (localObject >= i)
            break;
          ArrayList localArrayList = this.mSavedState;
          Fragment.SavedState localSavedState = (Fragment.SavedState)arrayOfParcelable[localObject];
          localArrayList.add(localSavedState);
          localObject++;
        }
      }
      Iterator localIterator = localBundle.keySet().iterator();
      while (localIterator.hasNext())
      {
        String str1 = (String)localIterator.next();
        if (!str1.startsWith("f"))
          continue;
        int j = Integer.parseInt(str1.substring(1));
        Fragment localFragment = this.mFragmentManager.getFragment(localBundle, str1);
        if (localFragment != null)
        {
          while (this.mFragments.size() <= j)
            this.mFragments.add(null);
          localFragment.setMenuVisibility(null);
          this.mFragments.set(j, localFragment);
          continue;
        }
        String str2 = "Bad fragment at key " + str1;
        Log.w("FragmentStatePagerAdapter", str2);
      }
    }
  }

  public Parcelable saveState()
  {
    Bundle localBundle = null;
    if (this.mSavedState.size() > 0)
    {
      localBundle = new Bundle();
      Fragment.SavedState[] arrayOfSavedState = new Fragment.SavedState[this.mSavedState.size()];
      this.mSavedState.toArray(arrayOfSavedState);
      localBundle.putParcelableArray("states", arrayOfSavedState);
    }
    for (int i = 0; ; i++)
    {
      int j = this.mFragments.size();
      if (i >= j)
        break;
      Fragment localFragment = (Fragment)this.mFragments.get(i);
      if (localFragment == null)
        continue;
      if (localBundle == null)
        localBundle = new Bundle();
      String str = "f" + i;
      this.mFragmentManager.putFragment(localBundle, str, localFragment);
    }
    return localBundle;
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