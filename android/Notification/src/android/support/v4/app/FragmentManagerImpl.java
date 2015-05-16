package android.support.v4.app;

import Z;
import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.Parcelable;
import android.support.v4.util.DebugUtils;
import android.support.v4.util.LogWriter;
import android.util.Log;
import android.util.SparseArray;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager.LayoutParams;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.view.animation.AnimationSet;
import android.view.animation.AnimationUtils;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Interpolator;
import android.view.animation.ScaleAnimation;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;

final class FragmentManagerImpl extends FragmentManager
{
  static final Interpolator ACCELERATE_CUBIC;
  static final Interpolator ACCELERATE_QUINT;
  static final int ANIM_DUR = 220;
  public static final int ANIM_STYLE_CLOSE_ENTER = 3;
  public static final int ANIM_STYLE_CLOSE_EXIT = 4;
  public static final int ANIM_STYLE_FADE_ENTER = 5;
  public static final int ANIM_STYLE_FADE_EXIT = 6;
  public static final int ANIM_STYLE_OPEN_ENTER = 1;
  public static final int ANIM_STYLE_OPEN_EXIT = 2;
  static boolean DEBUG = false;
  static final Interpolator DECELERATE_CUBIC;
  static final Interpolator DECELERATE_QUINT;
  static final boolean HONEYCOMB = false;
  static final String TAG = "FragmentManager";
  static final String TARGET_REQUEST_CODE_STATE_TAG = "android:target_req_state";
  static final String TARGET_STATE_TAG = "android:target_state";
  static final String USER_VISIBLE_HINT_TAG = "android:user_visible_hint";
  static final String VIEW_STATE_TAG = "android:view_state";

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
  ArrayList mActive;
  FragmentActivity mActivity;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
  ArrayList mAdded;

  @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/Integer;", ">;"})
  ArrayList mAvailBackStackIndices;

  @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/Integer;", ">;"})
  ArrayList mAvailIndices;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/BackStackRecord;", ">;"})
  ArrayList mBackStack;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/FragmentManager$OnBackStackChangedListener;", ">;"})
  ArrayList mBackStackChangeListeners;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/BackStackRecord;", ">;"})
  ArrayList mBackStackIndices;
  FragmentContainer mContainer;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
  ArrayList mCreatedMenus;
  int mCurState = null;
  boolean mDestroyed;
  Runnable mExecCommit;
  boolean mExecutingActions;
  boolean mHavePendingDeferredStart;
  boolean mNeedMenuInvalidate;
  String mNoTransactionsBecause;
  Fragment mParent;

  @Signature({"Ljava/util/ArrayList", "<", "Ljava/lang/Runnable;", ">;"})
  ArrayList mPendingActions;

  @Signature({"Landroid/util/SparseArray", "<", "Landroid/os/Parcelable;", ">;"})
  SparseArray mStateArray = null;
  Bundle mStateBundle = null;
  boolean mStateSaved;
  Runnable[] mTmpActions;

  static
  {
    int i = 1075838976;
    int j = 1069547520;
    boolean bool1 = DEBUG;
    if (Build.VERSION.SDK_INT >= 11);
    boolean bool2 = HONEYCOMB;
    DECELERATE_QUINT = new DecelerateInterpolator(i);
    DECELERATE_CUBIC = new DecelerateInterpolator(j);
    ACCELERATE_QUINT = new AccelerateInterpolator(i);
    ACCELERATE_CUBIC = new AccelerateInterpolator(j);
  }

  FragmentManagerImpl()
  {
    FragmentManagerImpl.1 local1 = new FragmentManagerImpl.1(this);
    this.mExecCommit = local1;
  }

  private void checkStateLoss()
  {
    if (this.mStateSaved)
      throw new IllegalStateException("Can not perform this action after onSaveInstanceState");
    if (this.mNoTransactionsBecause != null)
    {
      StringBuilder localStringBuilder = new StringBuilder().append("Can not perform this action inside of ");
      String str1 = this.mNoTransactionsBecause;
      String str2 = str1;
      throw new IllegalStateException(str2);
    }
  }

  static Animation makeFadeAnimation(Context paramContext, float paramFloat1, float paramFloat2)
  {
    AlphaAnimation localAlphaAnimation = new AlphaAnimation(paramFloat1, paramFloat2);
    Interpolator localInterpolator = DECELERATE_CUBIC;
    localAlphaAnimation.setInterpolator(localInterpolator);
    localAlphaAnimation.setDuration(220L);
    return localAlphaAnimation;
  }

  static Animation makeOpenCloseAnimation(Context paramContext, float paramFloat1, float paramFloat2, float paramFloat3, float paramFloat4)
  {
    AnimationSet localAnimationSet = new AnimationSet(null);
    int i = paramFloat1;
    int j = paramFloat2;
    int k = paramFloat1;
    int m = paramFloat2;
    ScaleAnimation localScaleAnimation = new ScaleAnimation(i, j, k, m, 1, 1056964608, 1, 1056964608);
    Interpolator localInterpolator1 = DECELERATE_QUINT;
    localScaleAnimation.setInterpolator(localInterpolator1);
    localScaleAnimation.setDuration(220L);
    localAnimationSet.addAnimation(localScaleAnimation);
    AlphaAnimation localAlphaAnimation = new AlphaAnimation(paramFloat3, paramFloat4);
    Interpolator localInterpolator2 = DECELERATE_CUBIC;
    localAlphaAnimation.setInterpolator(localInterpolator2);
    localAlphaAnimation.setDuration(220L);
    localAnimationSet.addAnimation(localAlphaAnimation);
    return localAnimationSet;
  }

  public static int reverseTransit(int paramInt)
  {
    Object localObject = null;
    switch (paramInt)
    {
    default:
    case 4097:
    case 8194:
    case 4099:
    }
    while (true)
    {
      return localObject;
      int i = 8194;
      continue;
      i = 4097;
      continue;
      i = 4099;
    }
  }

  private void throwException(RuntimeException paramRuntimeException)
  {
    String str = paramRuntimeException.getMessage();
    Log.e("FragmentManager", str);
    Log.e("FragmentManager", "Activity state:");
    LogWriter localLogWriter = new LogWriter("FragmentManager");
    PrintWriter localPrintWriter = new PrintWriter(localLogWriter);
    if (this.mActivity != null);
    while (true)
    {
      try
      {
        FragmentActivity localFragmentActivity = this.mActivity;
        String[] arrayOfString1 = new String[null];
        localFragmentActivity.dump("  ", null, localPrintWriter, arrayOfString1);
        throw paramRuntimeException;
      }
      catch (Exception localException1)
      {
        Log.e("FragmentManager", "Failed dumping state", localException1);
        continue;
      }
      try
      {
        String[] arrayOfString2 = new String[null];
        dump("  ", null, localPrintWriter, arrayOfString2);
      }
      catch (Exception localException2)
      {
        Log.e("FragmentManager", "Failed dumping state", localException2);
      }
    }
  }

  public static int transitToStyleIndex(int paramInt, boolean paramBoolean)
  {
    int i = -1;
    switch (paramInt)
    {
    default:
      return i;
    case 4097:
      if (paramBoolean);
      for (i = 1; ; i = 2)
        break;
    case 8194:
      if (paramBoolean);
      for (i = 3; ; i = 4)
        break;
    case 4099:
    }
    if (paramBoolean);
    for (i = 5; ; i = 6)
      break;
  }

  void addBackStackState(BackStackRecord paramBackStackRecord)
  {
    if (this.mBackStack == null)
    {
      ArrayList localArrayList = new ArrayList();
      this.mBackStack = localArrayList;
    }
    this.mBackStack.add(paramBackStackRecord);
    reportBackStackChanged();
  }

  public void addFragment(Fragment paramFragment, boolean paramBoolean)
  {
    boolean bool = true;
    ArrayList localArrayList = this.mAdded;
    if (localArrayList == null)
    {
      localArrayList = new ArrayList();
      this.mAdded = localArrayList;
    }
    DEBUG = localArrayList;
    if (localArrayList != null)
    {
      String str1 = "add: " + paramFragment;
      Log.v("FragmentManager", str1);
    }
    makeActive(paramFragment);
    if (!paramFragment.mDetached)
    {
      if (this.mAdded.contains(paramFragment))
      {
        String str2 = "Fragment already added: " + paramFragment;
        throw new IllegalStateException(str2);
      }
      this.mAdded.add(paramFragment);
      paramFragment.mAdded = bool;
      paramFragment.mRemoving = null;
      if ((paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
        this.mNeedMenuInvalidate = bool;
      if (paramBoolean)
        moveToState(paramFragment);
    }
  }

  public void addOnBackStackChangedListener(FragmentManager.OnBackStackChangedListener paramOnBackStackChangedListener)
  {
    if (this.mBackStackChangeListeners == null)
    {
      ArrayList localArrayList = new ArrayList();
      this.mBackStackChangeListeners = localArrayList;
    }
    this.mBackStackChangeListeners.add(paramOnBackStackChangedListener);
  }

  public int allocBackStackIndex(BackStackRecord paramBackStackRecord)
  {
    monitorenter;
    try
    {
      Object localObject1 = this.mAvailBackStackIndices;
      if (localObject1 != null)
      {
        localObject1 = this.mAvailBackStackIndices.size();
        if (localObject1 > 0);
      }
      else
      {
        localObject1 = this.mBackStackIndices;
        if (localObject1 == null)
        {
          localObject1 = new ArrayList();
          this.mBackStackIndices = ((ArrayList)localObject1);
        }
        localObject1 = this.mBackStackIndices;
        i = ((ArrayList)localObject1).size();
        DEBUG = (Z)localObject1;
        if (localObject1 != null)
        {
          localObject1 = "FragmentManager";
          String str1 = "Setting back stack index " + i + " to " + paramBackStackRecord;
          Log.v((String)localObject1, str1);
        }
        localObject1 = this.mBackStackIndices;
        ((ArrayList)localObject1).add(paramBackStackRecord);
        monitorexit;
        return j;
      }
      localObject1 = this.mAvailBackStackIndices;
      int k = this.mAvailBackStackIndices.size();
      int m;
      m--;
      localObject1 = (Integer)((ArrayList)localObject1).remove(k);
      int i = ((Integer)localObject1).intValue();
      DEBUG = (Z)localObject1;
      if (localObject1 != null)
      {
        localObject1 = "FragmentManager";
        String str2 = "Adding back stack index " + i + " with " + paramBackStackRecord;
        Log.v((String)localObject1, str2);
      }
      localObject1 = this.mBackStackIndices;
      ((ArrayList)localObject1).set(i, paramBackStackRecord);
      monitorexit;
      int j = i;
    }
    finally
    {
      monitorexit;
    }
  }

  public void attachActivity(FragmentActivity paramFragmentActivity, FragmentContainer paramFragmentContainer, Fragment paramFragment)
  {
    if (this.mActivity != null)
      throw new IllegalStateException("Already attached");
    this.mActivity = paramFragmentActivity;
    this.mContainer = paramFragmentContainer;
    this.mParent = paramFragment;
  }

  public void attachFragment(Fragment paramFragment, int paramInt1, int paramInt2)
  {
    boolean bool1 = true;
    boolean bool2 = null;
    boolean bool3;
    DEBUG = bool3;
    if (bool3)
    {
      String str1 = "FragmentManager";
      String str2 = "attach: " + paramFragment;
      Log.v(str1, str2);
    }
    boolean bool4 = paramFragment.mDetached;
    if (bool4)
    {
      paramFragment.mDetached = bool2;
      bool4 = paramFragment.mAdded;
      if (!bool4)
      {
        Object localObject = this.mAdded;
        if (localObject == null)
        {
          localObject = new ArrayList();
          this.mAdded = ((ArrayList)localObject);
        }
        localObject = this.mAdded.contains(paramFragment);
        if (localObject != 0)
        {
          String str3 = "Fragment already added: " + paramFragment;
          throw new IllegalStateException(str3);
        }
        DEBUG = localObject;
        if (localObject != 0)
        {
          String str4 = "add from attach: " + paramFragment;
          Log.v("FragmentManager", str4);
        }
        this.mAdded.add(paramFragment);
        paramFragment.mAdded = bool1;
        if ((paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
          this.mNeedMenuInvalidate = bool1;
        int i = this.mCurState;
        FragmentManagerImpl localFragmentManagerImpl = this;
        Fragment localFragment = paramFragment;
        int j = paramInt1;
        int k = paramInt2;
        localFragmentManagerImpl.moveToState(localFragment, i, j, k, bool2);
      }
    }
  }

  public FragmentTransaction beginTransaction()
  {
    return new BackStackRecord(this);
  }

  public void detachFragment(Fragment paramFragment, int paramInt1, int paramInt2)
  {
    boolean bool1 = null;
    int i = 1;
    boolean bool2;
    DEBUG = bool2;
    if (bool2)
    {
      String str1 = "FragmentManager";
      String str2 = "detach: " + paramFragment;
      Log.v(str1, str2);
    }
    boolean bool3 = paramFragment.mDetached;
    if (!bool3)
    {
      paramFragment.mDetached = i;
      bool3 = paramFragment.mAdded;
      if (bool3)
      {
        ArrayList localArrayList = this.mAdded;
        if (localArrayList != null)
        {
          DEBUG = localArrayList;
          if (localArrayList != null)
          {
            String str3 = "remove from detach: " + paramFragment;
            Log.v("FragmentManager", str3);
          }
          this.mAdded.remove(paramFragment);
        }
        if ((paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
          this.mNeedMenuInvalidate = i;
        paramFragment.mAdded = bool1;
        FragmentManagerImpl localFragmentManagerImpl = this;
        Fragment localFragment = paramFragment;
        int j = paramInt1;
        int k = paramInt2;
        localFragmentManagerImpl.moveToState(localFragment, i, j, k, bool1);
      }
    }
  }

  public void dispatchActivityCreated()
  {
    this.mStateSaved = null;
    moveToState(2, null);
  }

  public void dispatchConfigurationChanged(Configuration paramConfiguration)
  {
    if (this.mAdded != null)
      for (int i = 0; ; i++)
      {
        int j = this.mAdded.size();
        if (i >= j)
          break;
        Fragment localFragment = (Fragment)this.mAdded.get(i);
        if (localFragment == null)
          continue;
        localFragment.performConfigurationChanged(paramConfiguration);
      }
  }

  public boolean dispatchContextItemSelected(MenuItem paramMenuItem)
  {
    Object localObject1 = this.mAdded;
    Object localObject3;
    int i;
    if (localObject1 != null)
    {
      localObject3 = 0;
      localObject1 = this.mAdded.size();
      if (localObject3 < localObject1)
      {
        localObject1 = this.mAdded;
        Fragment localFragment = (Fragment)((ArrayList)localObject1).get(localObject3);
        if (localFragment != null)
        {
          localObject1 = localFragment.performContextItemSelected(paramMenuItem);
          if (localObject1 != 0)
            i = 1;
        }
      }
    }
    while (true)
    {
      return i;
      localObject3++;
      break;
      Object localObject2 = null;
    }
  }

  public void dispatchCreate()
  {
    this.mStateSaved = null;
    moveToState(1, null);
  }

  public boolean dispatchCreateOptionsMenu(Menu paramMenu, MenuInflater paramMenuInflater)
  {
    Object localObject = null;
    ArrayList localArrayList = null;
    int j;
    Fragment localFragment;
    int i;
    if (this.mAdded != null)
      for (j = 0; ; j++)
      {
        int k = this.mAdded.size();
        if (j >= k)
          break;
        localFragment = (Fragment)this.mAdded.get(j);
        if ((localFragment == null) || (!localFragment.performCreateOptionsMenu(paramMenu, paramMenuInflater)))
          continue;
        i = 1;
        if (localArrayList == null)
          localArrayList = new ArrayList();
        localArrayList.add(localFragment);
      }
    if (this.mCreatedMenus != null)
      for (j = null; ; j++)
      {
        int m = this.mCreatedMenus.size();
        if (j >= m)
          break;
        localFragment = (Fragment)this.mCreatedMenus.get(j);
        if ((localArrayList != null) && (localArrayList.contains(localFragment)))
          continue;
        localFragment.onDestroyOptionsMenu();
      }
    this.mCreatedMenus = localArrayList;
    return i;
  }

  public void dispatchDestroy()
  {
    this.mDestroyed = true;
    execPendingActions();
    moveToState(0, null);
    this.mActivity = null;
    this.mContainer = null;
    this.mParent = null;
  }

  public void dispatchDestroyView()
  {
    moveToState(1, null);
  }

  public void dispatchLowMemory()
  {
    if (this.mAdded != null)
      for (int i = 0; ; i++)
      {
        int j = this.mAdded.size();
        if (i >= j)
          break;
        Fragment localFragment = (Fragment)this.mAdded.get(i);
        if (localFragment == null)
          continue;
        localFragment.performLowMemory();
      }
  }

  public boolean dispatchOptionsItemSelected(MenuItem paramMenuItem)
  {
    Object localObject1 = this.mAdded;
    Object localObject3;
    int i;
    if (localObject1 != null)
    {
      localObject3 = 0;
      localObject1 = this.mAdded.size();
      if (localObject3 < localObject1)
      {
        localObject1 = this.mAdded;
        Fragment localFragment = (Fragment)((ArrayList)localObject1).get(localObject3);
        if (localFragment != null)
        {
          localObject1 = localFragment.performOptionsItemSelected(paramMenuItem);
          if (localObject1 != 0)
            i = 1;
        }
      }
    }
    while (true)
    {
      return i;
      localObject3++;
      break;
      Object localObject2 = null;
    }
  }

  public void dispatchOptionsMenuClosed(Menu paramMenu)
  {
    if (this.mAdded != null)
      for (int i = 0; ; i++)
      {
        int j = this.mAdded.size();
        if (i >= j)
          break;
        Fragment localFragment = (Fragment)this.mAdded.get(i);
        if (localFragment == null)
          continue;
        localFragment.performOptionsMenuClosed(paramMenu);
      }
  }

  public void dispatchPause()
  {
    moveToState(4, null);
  }

  public boolean dispatchPrepareOptionsMenu(Menu paramMenu)
  {
    Object localObject = null;
    int i;
    if (this.mAdded != null)
      for (int j = 0; ; j++)
      {
        int k = this.mAdded.size();
        if (j >= k)
          break;
        Fragment localFragment = (Fragment)this.mAdded.get(j);
        if ((localFragment == null) || (!localFragment.performPrepareOptionsMenu(paramMenu)))
          continue;
        i = 1;
      }
    return i;
  }

  public void dispatchReallyStop()
  {
    moveToState(2, null);
  }

  public void dispatchResume()
  {
    this.mStateSaved = null;
    moveToState(5, null);
  }

  public void dispatchStart()
  {
    this.mStateSaved = null;
    moveToState(4, null);
  }

  public void dispatchStop()
  {
    this.mStateSaved = true;
    moveToState(3, null);
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    String str1 = paramString + "    ";
    Object localObject1 = this.mActive;
    int i;
    int j;
    if (localObject1 != null)
    {
      localObject1 = this.mActive;
      i = ((ArrayList)localObject1).size();
      if (i > 0)
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("Active Fragments in ");
        localObject1 = Integer.toHexString(System.identityHashCode(this));
        paramPrintWriter.print((String)localObject1);
        localObject1 = ":";
        paramPrintWriter.println((String)localObject1);
        for (j = 0; j < i; j++)
        {
          Fragment localFragment1 = (Fragment)this.mActive.get(j);
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("  #");
          paramPrintWriter.print(j);
          localObject1 = ": ";
          paramPrintWriter.print((String)localObject1);
          paramPrintWriter.println(localFragment1);
          if (localFragment1 == null)
            continue;
          localFragment1.dump(str1, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
        }
      }
    }
    localObject1 = this.mAdded;
    if (localObject1 != null)
    {
      localObject1 = this.mAdded;
      i = ((ArrayList)localObject1).size();
      if (i > 0)
      {
        paramPrintWriter.print(paramString);
        localObject1 = "Added Fragments:";
        paramPrintWriter.println((String)localObject1);
        for (j = null; j < i; j++)
        {
          Fragment localFragment2 = (Fragment)this.mAdded.get(j);
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("  #");
          paramPrintWriter.print(j);
          paramPrintWriter.print(": ");
          localObject1 = localFragment2.toString();
          paramPrintWriter.println((String)localObject1);
        }
      }
    }
    localObject1 = this.mCreatedMenus;
    if (localObject1 != null)
    {
      localObject1 = this.mCreatedMenus;
      i = ((ArrayList)localObject1).size();
      if (i > 0)
      {
        paramPrintWriter.print(paramString);
        localObject1 = "Fragments Created Menus:";
        paramPrintWriter.println((String)localObject1);
        for (j = null; j < i; j++)
        {
          Fragment localFragment3 = (Fragment)this.mCreatedMenus.get(j);
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("  #");
          paramPrintWriter.print(j);
          paramPrintWriter.print(": ");
          localObject1 = localFragment3.toString();
          paramPrintWriter.println((String)localObject1);
        }
      }
    }
    localObject1 = this.mBackStack;
    if (localObject1 != null)
    {
      localObject1 = this.mBackStack;
      i = ((ArrayList)localObject1).size();
      if (i > 0)
      {
        paramPrintWriter.print(paramString);
        localObject1 = "Back Stack:";
        paramPrintWriter.println((String)localObject1);
        for (j = null; j < i; j++)
        {
          BackStackRecord localBackStackRecord1 = (BackStackRecord)this.mBackStack.get(j);
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("  #");
          paramPrintWriter.print(j);
          paramPrintWriter.print(": ");
          localObject1 = localBackStackRecord1.toString();
          paramPrintWriter.println((String)localObject1);
          localBackStackRecord1.dump(str1, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
        }
      }
    }
    monitorenter;
    try
    {
      localObject1 = this.mBackStackIndices;
      if (localObject1 != null)
      {
        localObject1 = this.mBackStackIndices;
        i = ((ArrayList)localObject1).size();
        if (i > 0)
        {
          paramPrintWriter.print(paramString);
          localObject1 = "Back Stack Indices:";
          paramPrintWriter.println((String)localObject1);
          for (j = null; j < i; j++)
          {
            BackStackRecord localBackStackRecord2 = (BackStackRecord)this.mBackStackIndices.get(j);
            paramPrintWriter.print(paramString);
            paramPrintWriter.print("  #");
            paramPrintWriter.print(j);
            localObject1 = ": ";
            paramPrintWriter.print((String)localObject1);
            paramPrintWriter.println(localBackStackRecord2);
          }
        }
      }
      localObject1 = this.mAvailBackStackIndices;
      if (localObject1 != null)
      {
        localObject1 = this.mAvailBackStackIndices.size();
        if (localObject1 > 0)
        {
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("mAvailBackStackIndices: ");
          localObject1 = Arrays.toString(this.mAvailBackStackIndices.toArray());
          paramPrintWriter.println((String)localObject1);
        }
      }
      monitorexit;
      if (this.mPendingActions != null)
      {
        i = this.mPendingActions.size();
        if (i > 0)
        {
          paramPrintWriter.print(paramString);
          paramPrintWriter.println("Pending Actions:");
          for (j = null; j < i; j++)
          {
            Runnable localRunnable = (Runnable)this.mPendingActions.get(j);
            paramPrintWriter.print(paramString);
            paramPrintWriter.print("  #");
            paramPrintWriter.print(j);
            paramPrintWriter.print(": ");
            paramPrintWriter.println(localRunnable);
          }
        }
      }
    }
    finally
    {
      monitorexit;
    }
    paramPrintWriter.print(paramString);
    paramPrintWriter.println("FragmentManager misc state:");
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("  mActivity=");
    FragmentActivity localFragmentActivity = this.mActivity;
    paramPrintWriter.println(localFragmentActivity);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("  mContainer=");
    FragmentContainer localFragmentContainer = this.mContainer;
    paramPrintWriter.println(localFragmentContainer);
    if (this.mParent != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("  mParent=");
      Fragment localFragment4 = this.mParent;
      paramPrintWriter.println(localFragment4);
    }
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("  mCurState=");
    int k = this.mCurState;
    paramPrintWriter.print(k);
    paramPrintWriter.print(" mStateSaved=");
    boolean bool1 = this.mStateSaved;
    paramPrintWriter.print(bool1);
    paramPrintWriter.print(" mDestroyed=");
    boolean bool2 = this.mDestroyed;
    paramPrintWriter.println(bool2);
    if (this.mNeedMenuInvalidate)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("  mNeedMenuInvalidate=");
      boolean bool3 = this.mNeedMenuInvalidate;
      paramPrintWriter.println(bool3);
    }
    if (this.mNoTransactionsBecause != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("  mNoTransactionsBecause=");
      String str2 = this.mNoTransactionsBecause;
      paramPrintWriter.println(str2);
    }
    if ((this.mAvailIndices != null) && (this.mAvailIndices.size() > 0))
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("  mAvailIndices: ");
      String str3 = Arrays.toString(this.mAvailIndices.toArray());
      paramPrintWriter.println(str3);
    }
  }

  // ERROR //
  public void enqueueAction(Runnable paramRunnable, boolean paramBoolean)
  {
    // Byte code:
    //   0: iload_2
    //   1: ifne +7 -> 8
    //   4: aload_0
    //   5: invokespecial 514	android/support/v4/app/FragmentManagerImpl:checkStateLoss	()V
    //   8: aload_0
    //   9: monitorenter
    //   10: aload_0
    //   11: getfield 221	android/support/v4/app/FragmentManagerImpl:mActivity	Landroid/support/v4/app/FragmentActivity;
    //   14: astore_3
    //   15: aload_3
    //   16: ifnonnull +21 -> 37
    //   19: new 136	java/lang/IllegalStateException
    //   22: dup
    //   23: ldc_w 516
    //   26: invokespecial 141	java/lang/IllegalStateException:<init>	(Ljava/lang/String;)V
    //   29: astore_3
    //   30: aload_3
    //   31: athrow
    //   32: astore_3
    //   33: aload_0
    //   34: monitorexit
    //   35: aload_3
    //   36: athrow
    //   37: aload_0
    //   38: getfield 480	android/support/v4/app/FragmentManagerImpl:mPendingActions	Ljava/util/ArrayList;
    //   41: astore_3
    //   42: aload_3
    //   43: ifnonnull +16 -> 59
    //   46: new 245	java/util/ArrayList
    //   49: dup
    //   50: invokespecial 246	java/util/ArrayList:<init>	()V
    //   53: astore_3
    //   54: aload_0
    //   55: aload_3
    //   56: putfield 480	android/support/v4/app/FragmentManagerImpl:mPendingActions	Ljava/util/ArrayList;
    //   59: aload_0
    //   60: getfield 480	android/support/v4/app/FragmentManagerImpl:mPendingActions	Ljava/util/ArrayList;
    //   63: aload_1
    //   64: invokevirtual 250	java/util/ArrayList:add	(Ljava/lang/Object;)Z
    //   67: pop
    //   68: aload_0
    //   69: getfield 480	android/support/v4/app/FragmentManagerImpl:mPendingActions	Ljava/util/ArrayList;
    //   72: invokevirtual 307	java/util/ArrayList:size	()I
    //   75: astore_3
    //   76: iload_3
    //   77: iconst_1
    //   78: if_icmpne +44 -> 122
    //   81: aload_0
    //   82: getfield 221	android/support/v4/app/FragmentManagerImpl:mActivity	Landroid/support/v4/app/FragmentActivity;
    //   85: getfield 520	android/support/v4/app/FragmentActivity:mHandler	Landroid/os/Handler;
    //   88: astore_3
    //   89: aload_0
    //   90: getfield 131	android/support/v4/app/FragmentManagerImpl:mExecCommit	Ljava/lang/Runnable;
    //   93: astore 4
    //   95: aload_3
    //   96: aload 4
    //   98: invokevirtual 526	android/os/Handler:removeCallbacks	(Ljava/lang/Runnable;)V
    //   101: aload_0
    //   102: getfield 221	android/support/v4/app/FragmentManagerImpl:mActivity	Landroid/support/v4/app/FragmentActivity;
    //   105: getfield 520	android/support/v4/app/FragmentActivity:mHandler	Landroid/os/Handler;
    //   108: astore_3
    //   109: aload_0
    //   110: getfield 131	android/support/v4/app/FragmentManagerImpl:mExecCommit	Ljava/lang/Runnable;
    //   113: astore 5
    //   115: aload_3
    //   116: aload 5
    //   118: invokevirtual 530	android/os/Handler:post	(Ljava/lang/Runnable;)Z
    //   121: pop
    //   122: aload_0
    //   123: monitorexit
    //   124: return
    //
    // Exception table:
    //   from	to	target	type
    //   10	35	32	finally
    //   37	124	32	finally
  }

  public boolean execPendingActions()
  {
    Object localObject1 = null;
    boolean bool1 = this.mExecutingActions;
    if (bool1)
      throw new IllegalStateException("Recursive entry to executePendingTransactions");
    Object localObject2 = Looper.myLooper();
    Looper localLooper = this.mActivity.mHandler.getLooper();
    if (localObject2 != localLooper)
      throw new IllegalStateException("Must be called from main thread of process");
    Object localObject5 = null;
    int j;
    while (true)
    {
      monitorenter;
      int k;
      try
      {
        localObject2 = this.mPendingActions;
        if (localObject2 != null)
        {
          localObject2 = this.mPendingActions.size();
          if (localObject2 != 0);
        }
        else
        {
          monitorexit;
          if (!this.mHavePendingDeferredStart)
            break;
          Object localObject6 = null;
          for (m = null; ; m++)
          {
            int n = this.mActive.size();
            if (m >= n)
              break;
            Fragment localFragment = (Fragment)this.mActive.get(m);
            if ((localFragment == null) || (localFragment.mLoaderManager == null))
              continue;
            boolean bool3 = localFragment.mLoaderManager.hasRunningLoaders();
            k = localObject6 | bool3;
          }
        }
        int i1 = this.mPendingActions.size();
        localObject2 = this.mTmpActions;
        if (localObject2 != null)
        {
          int i = this.mTmpActions.length;
          if (i >= i1);
        }
        else
        {
          localObject3 = new Runnable[i1];
          this.mTmpActions = ((Runnable)localObject3);
        }
        Object localObject3 = this.mPendingActions;
        Runnable[] arrayOfRunnable2 = this.mTmpActions;
        ((ArrayList)localObject3).toArray(arrayOfRunnable2);
        this.mPendingActions.clear();
        localObject3 = this.mActivity.mHandler;
        Runnable localRunnable = this.mExecCommit;
        ((Handler)localObject3).removeCallbacks(localRunnable);
        monitorexit;
        boolean bool2 = true;
        this.mExecutingActions = bool2;
        for (int m = null; m < i1; m++)
        {
          this.mTmpActions[m].run();
          Runnable[] arrayOfRunnable1 = this.mTmpActions;
          arrayOfRunnable1[m] = null;
        }
      }
      finally
      {
        monitorexit;
      }
      this.mExecutingActions = localObject1;
      j = 1;
      continue;
      if (k != null)
        break;
      this.mHavePendingDeferredStart = localObject1;
      startPendingDeferredFragments();
    }
    return j;
  }

  public boolean executePendingTransactions()
  {
    return execPendingActions();
  }

  public Fragment findFragmentById(int paramInt)
  {
    int i;
    Fragment localFragment;
    if (this.mAdded != null)
    {
      i = this.mAdded.size() + -1;
      if (i >= 0)
      {
        localFragment = (Fragment)this.mAdded.get(i);
        if ((localFragment == null) || (localFragment.mFragmentId != paramInt));
      }
    }
    while (true)
    {
      return localFragment;
      i--;
      break;
      if (this.mActive != null)
        for (i = this.mActive.size() + -1; ; i--)
        {
          if (i < 0)
            break label106;
          localFragment = (Fragment)this.mActive.get(i);
          if ((localFragment != null) && (localFragment.mFragmentId == paramInt))
            break;
        }
      label106: int j = 0;
    }
  }

  public Fragment findFragmentByTag(String paramString)
  {
    int i;
    Fragment localFragment;
    if ((this.mAdded != null) && (paramString != null))
    {
      i = this.mAdded.size() + -1;
      if (i >= 0)
      {
        localFragment = (Fragment)this.mAdded.get(i);
        if (localFragment != null)
        {
          String str1 = localFragment.mTag;
          if (!paramString.equals(str1));
        }
      }
    }
    while (true)
    {
      return localFragment;
      i--;
      break;
      if ((this.mActive != null) && (paramString != null))
        for (i = this.mActive.size() + -1; ; i--)
        {
          if (i < 0)
            break label128;
          localFragment = (Fragment)this.mActive.get(i);
          if (localFragment == null)
            continue;
          String str2 = localFragment.mTag;
          if (paramString.equals(str2))
            break;
        }
      label128: int j = 0;
    }
  }

  public Fragment findFragmentByWho(String paramString)
  {
    int i;
    Fragment localFragment;
    if ((this.mActive != null) && (paramString != null))
    {
      i = this.mActive.size() + -1;
      if (i >= 0)
      {
        localFragment = (Fragment)this.mActive.get(i);
        if (localFragment != null)
        {
          localFragment = localFragment.findFragmentByWho(paramString);
          if (localFragment == null);
        }
      }
    }
    while (true)
    {
      return localFragment;
      i--;
      break;
      int j = 0;
    }
  }

  public void freeBackStackIndex(int paramInt)
  {
    monitorenter;
    try
    {
      this.mBackStackIndices.set(paramInt, null);
      Object localObject1 = this.mAvailBackStackIndices;
      if (localObject1 == null)
      {
        localObject1 = new ArrayList();
        this.mAvailBackStackIndices = ((ArrayList)localObject1);
      }
      DEBUG = (Z)localObject1;
      if (localObject1 != null)
      {
        localObject1 = "FragmentManager";
        String str = "Freeing back stack index " + paramInt;
        Log.v((String)localObject1, str);
      }
      localObject1 = this.mAvailBackStackIndices;
      Integer localInteger = Integer.valueOf(paramInt);
      ((ArrayList)localObject1).add(localInteger);
      monitorexit;
      return;
    }
    finally
    {
      localObject2 = finally;
      monitorexit;
    }
    throw localObject2;
  }

  public FragmentManager.BackStackEntry getBackStackEntryAt(int paramInt)
  {
    return (FragmentManager.BackStackEntry)this.mBackStack.get(paramInt);
  }

  public int getBackStackEntryCount()
  {
    Object localObject = this.mBackStack;
    if (localObject != null);
    for (localObject = this.mBackStack.size(); ; localObject = null)
      return localObject;
  }

  public Fragment getFragment(Bundle paramBundle, String paramString)
  {
    int i = paramBundle.getInt(paramString, -1);
    int j;
    if (i == -1)
      j = 0;
    while (true)
    {
      return j;
      int k = this.mActive.size();
      if (i >= k)
      {
        String str1 = "Fragement no longer exists for key " + paramString + ": index " + i;
        IllegalStateException localIllegalStateException1 = new IllegalStateException(str1);
        throwException(localIllegalStateException1);
      }
      Fragment localFragment = (Fragment)this.mActive.get(i);
      if (localFragment != null)
        continue;
      String str2 = "Fragement no longer exists for key " + paramString + ": index " + i;
      IllegalStateException localIllegalStateException2 = new IllegalStateException(str2);
      throwException(localIllegalStateException2);
    }
  }

  public void hideFragment(Fragment paramFragment, int paramInt1, int paramInt2)
  {
    boolean bool1 = true;
    boolean bool2;
    DEBUG = bool2;
    if (bool2)
    {
      String str = "hide: " + paramFragment;
      Log.v("FragmentManager", str);
    }
    if (!paramFragment.mHidden)
    {
      paramFragment.mHidden = bool1;
      if (paramFragment.mView != null)
      {
        Animation localAnimation = loadAnimation(paramFragment, paramInt1, bool1, paramInt2);
        if (localAnimation != null)
          paramFragment.mView.startAnimation(localAnimation);
        paramFragment.mView.setVisibility(8);
      }
      if ((paramFragment.mAdded) && (paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
        this.mNeedMenuInvalidate = bool1;
      paramFragment.onHiddenChanged(bool1);
    }
  }

  Animation loadAnimation(Fragment paramFragment, int paramInt1, boolean paramBoolean, int paramInt2)
  {
    int i = 1064933786;
    int j = 0;
    float f = null;
    int k = 1065353216;
    int m = paramFragment.mNextAnim;
    Object localObject = paramFragment.onCreateAnimation(paramInt1, paramBoolean, m);
    if (localObject != null);
    while (true)
    {
      return localObject;
      if (paramFragment.mNextAnim != 0)
      {
        FragmentActivity localFragmentActivity = this.mActivity;
        int n = paramFragment.mNextAnim;
        Animation localAnimation = AnimationUtils.loadAnimation(localFragmentActivity, n);
        if (localAnimation != null)
        {
          localObject = localAnimation;
          continue;
        }
      }
      if (paramInt1 == 0)
      {
        localObject = j;
        continue;
      }
      int i1 = transitToStyleIndex(paramInt1, paramBoolean);
      if (i1 < 0)
      {
        localObject = j;
        continue;
      }
      switch (i1)
      {
      default:
        if ((paramInt2 == 0) && (this.mActivity.getWindow() != null))
          paramInt2 = this.mActivity.getWindow().getAttributes().windowAnimations;
        if (paramInt2 == 0)
          localObject = j;
        break;
      case 1:
        localObject = makeOpenCloseAnimation(this.mActivity, 1066401792, k, f, k);
        break;
      case 2:
        localObject = makeOpenCloseAnimation(this.mActivity, k, i, k, f);
        break;
      case 3:
        localObject = makeOpenCloseAnimation(this.mActivity, i, k, f, k);
        break;
      case 4:
        localObject = makeOpenCloseAnimation(this.mActivity, k, 1065982362, k, f);
        break;
      case 5:
        localObject = makeFadeAnimation(this.mActivity, f, k);
        break;
      case 6:
        localObject = makeFadeAnimation(this.mActivity, k, f);
        continue;
        localObject = j;
      }
    }
  }

  void makeActive(Fragment paramFragment)
  {
    int i = paramFragment.mIndex;
    if (i >= 0)
      return;
    Object localObject = this.mAvailIndices;
    if (localObject != null)
    {
      localObject = this.mAvailIndices.size();
      if (localObject > 0);
    }
    else
    {
      localObject = this.mActive;
      if (localObject == null)
      {
        localObject = new ArrayList();
        this.mActive = ((ArrayList)localObject);
      }
      localObject = this.mActive.size();
      Fragment localFragment1 = this.mParent;
      paramFragment.setIndex(localObject, localFragment1);
      localObject = this.mActive;
      ((ArrayList)localObject).add(paramFragment);
    }
    while (true)
    {
      DEBUG = (Z)localObject;
      if (localObject == null)
        break;
      String str = "Allocated fragment index " + paramFragment;
      Log.v("FragmentManager", str);
      break;
      localObject = this.mAvailIndices;
      int j = this.mAvailIndices.size();
      int k;
      k--;
      localObject = ((Integer)((ArrayList)localObject).remove(j)).intValue();
      Fragment localFragment2 = this.mParent;
      paramFragment.setIndex(localObject, localFragment2);
      localObject = this.mActive;
      int m = paramFragment.mIndex;
      ((ArrayList)localObject).set(m, paramFragment);
    }
  }

  void makeInactive(Fragment paramFragment)
  {
    int i = paramFragment.mIndex;
    if (i < 0);
    while (true)
    {
      return;
      DEBUG = i;
      if (i != 0)
      {
        String str1 = "Freeing fragment index " + paramFragment;
        Log.v("FragmentManager", str1);
      }
      ArrayList localArrayList1 = this.mActive;
      int j = paramFragment.mIndex;
      localArrayList1.set(j, null);
      if (this.mAvailIndices == null)
      {
        ArrayList localArrayList2 = new ArrayList();
        this.mAvailIndices = localArrayList2;
      }
      ArrayList localArrayList3 = this.mAvailIndices;
      Integer localInteger = Integer.valueOf(paramFragment.mIndex);
      localArrayList3.add(localInteger);
      FragmentActivity localFragmentActivity = this.mActivity;
      String str2 = paramFragment.mWho;
      localFragmentActivity.invalidateSupportFragment(str2);
      paramFragment.initState();
    }
  }

  void moveToState(int paramInt1, int paramInt2, int paramInt3, boolean paramBoolean)
  {
    boolean bool1 = null;
    if ((this.mActivity == null) && (paramInt1 != 0))
      throw new IllegalStateException("No activity");
    if ((!paramBoolean) && (this.mCurState == paramInt1));
    while (true)
    {
      return;
      this.mCurState = paramInt1;
      if (this.mActive == null)
        continue;
      Object localObject = null;
      int i;
      for (int j = 0; ; j++)
      {
        int k = this.mActive.size();
        if (j >= k)
          break;
        Fragment localFragment = (Fragment)this.mActive.get(j);
        if (localFragment == null)
          continue;
        FragmentManagerImpl localFragmentManagerImpl = this;
        int m = paramInt1;
        int n = paramInt2;
        int i1 = paramInt3;
        localFragmentManagerImpl.moveToState(localFragment, m, n, i1, bool1);
        if (localFragment.mLoaderManager == null)
          continue;
        boolean bool2 = localFragment.mLoaderManager.hasRunningLoaders();
        i = localObject | bool2;
      }
      if (i == null)
        startPendingDeferredFragments();
      if ((!this.mNeedMenuInvalidate) || (this.mActivity == null) || (this.mCurState != 5))
        continue;
      this.mActivity.supportInvalidateOptionsMenu();
      this.mNeedMenuInvalidate = bool1;
    }
  }

  void moveToState(int paramInt, boolean paramBoolean)
  {
    moveToState(paramInt, 0, 0, paramBoolean);
  }

  void moveToState(Fragment paramFragment)
  {
    int i = this.mCurState;
    FragmentManagerImpl localFragmentManagerImpl = this;
    Fragment localFragment = paramFragment;
    int j = 0;
    boolean bool = null;
    localFragmentManagerImpl.moveToState(localFragment, i, 0, j, bool);
  }

  void moveToState(Fragment paramFragment, int paramInt1, int paramInt2, int paramInt3, boolean paramBoolean)
  {
    int i = paramFragment.mAdded;
    if (i != 0)
    {
      i = paramFragment.mDetached;
      if (i == 0);
    }
    else
    {
      i = 1;
      if (paramInt1 > i)
        paramInt1 = 1;
    }
    boolean bool1 = paramFragment.mRemoving;
    if (bool1)
    {
      int j = paramFragment.mState;
      if (paramInt1 > j)
        paramInt1 = paramFragment.mState;
    }
    boolean bool2 = paramFragment.mDeferStart;
    if (bool2)
    {
      k = paramFragment.mState;
      if (k < 4)
      {
        k = 3;
        if (paramInt1 > k)
          paramInt1 = 3;
      }
    }
    int k = paramFragment.mState;
    int m;
    if (k < paramInt1)
    {
      boolean bool3 = paramFragment.mFromLayout;
      if (bool3)
      {
        bool3 = paramFragment.mInLayout;
        if (!bool3)
          return;
      }
      Object localObject1 = paramFragment.mAnimatingAway;
      if (localObject1 != null)
      {
        paramFragment.mAnimatingAway = null;
        int i11 = paramFragment.mStateAfterAnimating;
        localObject1 = this;
        Fragment localFragment1 = paramFragment;
        ((FragmentManagerImpl)localObject1).moveToState(localFragment1, i11, 0, 0, true);
      }
      m = paramFragment.mState;
      switch (m)
      {
      default:
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      }
    }
    while (true)
    {
      paramFragment.mState = paramInt1;
      break;
      DEBUG = m;
      if (m != 0)
      {
        localObject2 = "FragmentManager";
        String str6 = "moveto CREATED: " + paramFragment;
        Log.v((String)localObject2, str6);
      }
      Object localObject2 = paramFragment.mSavedFragmentState;
      if (localObject2 != null)
      {
        localObject2 = paramFragment.mSavedFragmentState.getSparseParcelableArray("android:view_state");
        paramFragment.mSavedViewState = ((SparseArray)localObject2);
        localObject2 = paramFragment.mSavedFragmentState;
        localObject2 = getFragment((Bundle)localObject2, "android:target_state");
        paramFragment.mTarget = ((Fragment)localObject2);
        localObject2 = paramFragment.mTarget;
        if (localObject2 != null)
        {
          localObject2 = paramFragment.mSavedFragmentState.getInt("android:target_req_state", 0);
          paramFragment.mTargetRequestCode = localObject2;
        }
        localObject2 = paramFragment.mSavedFragmentState.getBoolean("android:user_visible_hint", true);
        paramFragment.mUserVisibleHint = localObject2;
        boolean bool4 = paramFragment.mUserVisibleHint;
        if (!bool4)
        {
          paramFragment.mDeferStart = true;
          int n = 3;
          if (paramInt1 > n)
            paramInt1 = 3;
        }
      }
      Object localObject3 = this.mActivity;
      paramFragment.mActivity = ((FragmentActivity)localObject3);
      localObject3 = this.mParent;
      paramFragment.mParentFragment = ((Fragment)localObject3);
      localObject3 = this.mParent;
      if (localObject3 != null);
      for (localObject3 = this.mParent.mChildFragmentManager; ; localObject4 = this.mActivity.mFragments)
      {
        paramFragment.mFragmentManager = ((FragmentManagerImpl)localObject3);
        paramFragment.mCalled = null;
        localObject3 = this.mActivity;
        paramFragment.onAttach((Activity)localObject3);
        boolean bool5 = paramFragment.mCalled;
        if (bool5)
          break;
        String str7 = "Fragment " + paramFragment + " did not call through to super.onAttach()";
        throw new SuperNotCalledException(str7);
      }
      Object localObject4 = paramFragment.mParentFragment;
      if (localObject4 == null)
      {
        localObject4 = this.mActivity;
        ((FragmentActivity)localObject4).onAttachFragment(paramFragment);
      }
      boolean bool6 = paramFragment.mRetaining;
      if (!bool6)
      {
        Bundle localBundle1 = paramFragment.mSavedFragmentState;
        paramFragment.performCreate(localBundle1);
      }
      paramFragment.mRetaining = null;
      boolean bool7 = paramFragment.mFromLayout;
      label697: Animation localAnimation;
      Object localObject7;
      if (bool7)
      {
        Object localObject5 = paramFragment.mSavedFragmentState;
        localObject5 = paramFragment.getLayoutInflater((Bundle)localObject5);
        Bundle localBundle2 = paramFragment.mSavedFragmentState;
        localObject5 = paramFragment.performCreateView((LayoutInflater)localObject5, null, localBundle2);
        paramFragment.mView = ((View)localObject5);
        localObject5 = paramFragment.mView;
        if (localObject5 != null)
        {
          localObject5 = paramFragment.mView;
          paramFragment.mInnerView = ((View)localObject5);
          localObject5 = NoSaveStateFrameLayout.wrap(paramFragment.mView);
          paramFragment.mView = ((View)localObject5);
          boolean bool8 = paramFragment.mHidden;
          if (bool8)
          {
            localView1 = paramFragment.mView;
            localView1.setVisibility(8);
          }
          View localView1 = paramFragment.mView;
          Bundle localBundle3 = paramFragment.mSavedFragmentState;
          paramFragment.onViewCreated(localView1, localBundle3);
        }
      }
      else
      {
        int i1 = 1;
        if (paramInt1 > i1)
        {
          DEBUG = i1;
          if (i1 != 0)
          {
            String str1 = "FragmentManager";
            String str8 = "moveto ACTIVITY_CREATED: " + paramFragment;
            Log.v(str1, str8);
          }
          boolean bool9 = paramFragment.mFromLayout;
          if (!bool9)
          {
            int i12 = 0;
            int i2 = paramFragment.mContainerId;
            ViewGroup localViewGroup;
            if (i2 != 0)
            {
              FragmentContainer localFragmentContainer = this.mContainer;
              int i13 = paramFragment.mContainerId;
              localViewGroup = (ViewGroup)localFragmentContainer.findViewById(i13);
              if (localViewGroup == null)
              {
                boolean bool10 = paramFragment.mRestored;
                if (!bool10)
                {
                  StringBuilder localStringBuilder1 = new StringBuilder().append("No view found for id 0x");
                  String str9 = Integer.toHexString(paramFragment.mContainerId);
                  StringBuilder localStringBuilder2 = localStringBuilder1.append(str9).append(" (");
                  Resources localResources = paramFragment.getResources();
                  int i14 = paramFragment.mContainerId;
                  String str10 = localResources.getResourceName(i14);
                  String str11 = str10 + ") for fragment " + paramFragment;
                  localObject6 = new IllegalArgumentException(str11);
                  throwException((RuntimeException)localObject6);
                }
              }
            }
            paramFragment.mContainer = localViewGroup;
            Object localObject6 = paramFragment.mSavedFragmentState;
            localObject6 = paramFragment.getLayoutInflater((Bundle)localObject6);
            Bundle localBundle4 = paramFragment.mSavedFragmentState;
            localObject6 = paramFragment.performCreateView((LayoutInflater)localObject6, localViewGroup, localBundle4);
            paramFragment.mView = ((View)localObject6);
            localObject6 = paramFragment.mView;
            if (localObject6 == null)
              break label1277;
            localObject6 = paramFragment.mView;
            paramFragment.mInnerView = ((View)localObject6);
            localObject6 = NoSaveStateFrameLayout.wrap(paramFragment.mView);
            paramFragment.mView = ((View)localObject6);
            if (localViewGroup != 0)
            {
              boolean bool11 = true;
              localAnimation = loadAnimation(paramFragment, paramInt2, bool11, paramInt3);
              if (localAnimation != null)
              {
                localView2 = paramFragment.mView;
                localView2.startAnimation(localAnimation);
              }
              View localView2 = paramFragment.mView;
              localViewGroup.addView(localView2);
            }
            boolean bool12 = paramFragment.mHidden;
            if (bool12)
            {
              localObject7 = paramFragment.mView;
              ((View)localObject7).setVisibility(8);
            }
            localObject7 = paramFragment.mView;
            Bundle localBundle5 = paramFragment.mSavedFragmentState;
            paramFragment.onViewCreated((View)localObject7, localBundle5);
          }
        }
      }
      while (true)
      {
        localObject7 = paramFragment.mSavedFragmentState;
        paramFragment.performActivityCreated((Bundle)localObject7);
        localObject7 = paramFragment.mView;
        if (localObject7 != null)
        {
          localObject7 = paramFragment.mSavedFragmentState;
          paramFragment.restoreViewState((Bundle)localObject7);
        }
        localObject7 = null;
        paramFragment.mSavedFragmentState = ((Bundle)localObject7);
        int i3 = 3;
        if (paramInt1 > i3)
        {
          DEBUG = i3;
          if (i3 != 0)
          {
            String str2 = "FragmentManager";
            String str12 = "moveto STARTED: " + paramFragment;
            Log.v(str2, str12);
          }
          paramFragment.performStart();
        }
        i4 = 4;
        if (paramInt1 <= i4)
          break;
        DEBUG = i4;
        if (i4 != 0)
        {
          String str13 = "moveto RESUMED: " + paramFragment;
          Log.v("FragmentManager", str13);
        }
        paramFragment.mResumed = true;
        paramFragment.performResume();
        paramFragment.mSavedFragmentState = null;
        paramFragment.mSavedViewState = null;
        break;
        i4 = 0;
        paramFragment.mInnerView = i4;
        break label697;
        label1277: i4 = 0;
        paramFragment.mInnerView = i4;
      }
      int i4 = paramFragment.mState;
      if (i4 <= paramInt1)
        continue;
      i4 = paramFragment.mState;
      switch (i4)
      {
      default:
        break;
      case 1:
      case 5:
      case 4:
      case 3:
      case 2:
        Object localObject9;
        while (true)
        {
          i4 = 1;
          if (paramInt1 >= i4)
            break;
          boolean bool13 = this.mDestroyed;
          if (bool13)
          {
            View localView3 = paramFragment.mAnimatingAway;
            if (localView3 != null)
            {
              View localView5 = paramFragment.mAnimatingAway;
              int i5 = 0;
              paramFragment.mAnimatingAway = i5;
              localView5.clearAnimation();
            }
          }
          View localView4 = paramFragment.mAnimatingAway;
          if (localView4 == null)
            break label1857;
          paramFragment.mStateAfterAnimating = paramInt1;
          paramInt1 = 1;
          break;
          int i6 = 5;
          if (paramInt1 < i6)
          {
            DEBUG = i6;
            if (i6 != 0)
            {
              str3 = "FragmentManager";
              String str14 = "movefrom RESUMED: " + paramFragment;
              Log.v(str3, str14);
            }
            paramFragment.performPause();
            String str3 = null;
            paramFragment.mResumed = str3;
          }
          int i7 = 4;
          if (paramInt1 < i7)
          {
            DEBUG = i7;
            if (i7 != 0)
            {
              String str4 = "FragmentManager";
              String str15 = "movefrom STARTED: " + paramFragment;
              Log.v(str4, str15);
            }
            paramFragment.performStop();
          }
          int i8 = 3;
          if (paramInt1 < i8)
          {
            DEBUG = i8;
            if (i8 != 0)
            {
              String str5 = "FragmentManager";
              String str16 = "movefrom STOPPED: " + paramFragment;
              Log.v(str5, str16);
            }
            paramFragment.performReallyStop();
          }
          int i9 = 2;
          if (paramInt1 >= i9)
            continue;
          DEBUG = i9;
          if (i9 != 0)
          {
            localObject8 = "FragmentManager";
            String str17 = "movefrom ACTIVITY_CREATED: " + paramFragment;
            Log.v((String)localObject8, str17);
          }
          Object localObject8 = paramFragment.mView;
          if (localObject8 != null)
          {
            localObject8 = this.mActivity.isFinishing();
            if (localObject8 == 0)
            {
              localObject8 = paramFragment.mSavedViewState;
              if (localObject8 == null)
                saveFragmentViewState(paramFragment);
            }
          }
          paramFragment.performDestroyView();
          localObject8 = paramFragment.mView;
          if (localObject8 != null)
          {
            localObject8 = paramFragment.mContainer;
            if (localObject8 != null)
            {
              localAnimation = null;
              int i10 = this.mCurState;
              if (i10 > 0)
              {
                boolean bool14 = this.mDestroyed;
                if (!bool14)
                {
                  boolean bool15 = null;
                  localAnimation = loadAnimation(paramFragment, paramInt2, bool15, paramInt3);
                }
              }
              if (localAnimation != null)
              {
                Fragment localFragment2 = paramFragment;
                localObject9 = paramFragment.mView;
                paramFragment.mAnimatingAway = ((View)localObject9);
                paramFragment.mStateAfterAnimating = paramInt1;
                localObject9 = new FragmentManagerImpl.5(this, localFragment2);
                localAnimation.setAnimationListener((Animation.AnimationListener)localObject9);
                localObject9 = paramFragment.mView;
                ((View)localObject9).startAnimation(localAnimation);
              }
              localObject9 = paramFragment.mContainer;
              View localView6 = paramFragment.mView;
              ((ViewGroup)localObject9).removeView(localView6);
            }
          }
          paramFragment.mContainer = null;
          paramFragment.mView = null;
          localObject9 = null;
          paramFragment.mInnerView = ((View)localObject9);
        }
        label1857: DEBUG = (Z)localObject9;
        if (localObject9 != null)
        {
          String str18 = "movefrom CREATED: " + paramFragment;
          Log.v("FragmentManager", str18);
        }
        if (!paramFragment.mRetaining)
          paramFragment.performDestroy();
        paramFragment.mCalled = null;
        paramFragment.onDetach();
        if (!paramFragment.mCalled)
        {
          String str19 = "Fragment " + paramFragment + " did not call through to super.onDetach()";
          throw new SuperNotCalledException(str19);
        }
        if (paramBoolean)
          continue;
        if (!paramFragment.mRetaining)
        {
          makeInactive(paramFragment);
          continue;
        }
        paramFragment.mActivity = null;
        paramFragment.mFragmentManager = null;
      }
    }
  }

  public void noteStateNotSaved()
  {
    this.mStateSaved = null;
  }

  public void performPendingDeferredStart(Fragment paramFragment)
  {
    int i = null;
    if (paramFragment.mDeferStart)
    {
      if (!this.mExecutingActions)
        break label22;
      this.mHavePendingDeferredStart = true;
    }
    while (true)
    {
      return;
      label22: paramFragment.mDeferStart = i;
      int j = this.mCurState;
      FragmentManagerImpl localFragmentManagerImpl = this;
      Fragment localFragment = paramFragment;
      int k = i;
      int m = i;
      localFragmentManagerImpl.moveToState(localFragment, j, i, k, m);
    }
  }

  public void popBackStack()
  {
    FragmentManagerImpl.2 local2 = new FragmentManagerImpl.2(this);
    enqueueAction(local2, null);
  }

  public void popBackStack(int paramInt1, int paramInt2)
  {
    if (paramInt1 < 0)
    {
      String str = "Bad id: " + paramInt1;
      throw new IllegalArgumentException(str);
    }
    FragmentManagerImpl.4 local4 = new FragmentManagerImpl.4(this, paramInt1, paramInt2);
    enqueueAction(local4, null);
  }

  public void popBackStack(String paramString, int paramInt)
  {
    FragmentManagerImpl.3 local3 = new FragmentManagerImpl.3(this, paramString, paramInt);
    enqueueAction(local3, null);
  }

  public boolean popBackStackImmediate()
  {
    checkStateLoss();
    executePendingTransactions();
    Handler localHandler = this.mActivity.mHandler;
    return popBackStackState(localHandler, null, -1, 0);
  }

  public boolean popBackStackImmediate(int paramInt1, int paramInt2)
  {
    checkStateLoss();
    executePendingTransactions();
    if (paramInt1 < 0)
    {
      String str = "Bad id: " + paramInt1;
      throw new IllegalArgumentException(str);
    }
    Handler localHandler = this.mActivity.mHandler;
    return popBackStackState(localHandler, null, paramInt1, paramInt2);
  }

  public boolean popBackStackImmediate(String paramString, int paramInt)
  {
    checkStateLoss();
    executePendingTransactions();
    Handler localHandler = this.mActivity.mHandler;
    return popBackStackState(localHandler, paramString, -1, paramInt);
  }

  boolean popBackStackState(Handler paramHandler, String paramString, int paramInt1, int paramInt2)
  {
    Object localObject1 = 1;
    Object localObject2 = null;
    ArrayList localArrayList1 = this.mBackStack;
    if (localArrayList1 == null)
      break label159;
    while (true)
    {
      label17: return localObject2;
      if ((paramString != null) || (paramInt1 >= 0))
        break;
      int i = paramInt2 & 0x1;
      if (i != 0)
        break;
      int n = this.mBackStack.size() + -1;
      if (n < 0)
        continue;
      ((BackStackRecord)this.mBackStack.remove(n)).popFromBackStack(localObject1);
      reportBackStackChanged();
    }
    while (true)
    {
      localObject2 = localObject1;
      break label17;
      int i1 = -1;
      if ((paramString != null) || (paramInt1 >= 0))
      {
        int j = this.mBackStack.size();
        for (i1 = j + -1; ; i1--)
        {
          BackStackRecord localBackStackRecord;
          if (i1 >= 0)
          {
            Object localObject3 = this.mBackStack;
            localBackStackRecord = (BackStackRecord)((ArrayList)localObject3).get(i1);
            if (paramString != null)
            {
              localObject3 = localBackStackRecord.getName();
              localObject3 = paramString.equals(localObject3);
              if (localObject3 == 0);
            }
          }
          else
          {
            label159: if (i1 < 0)
              break label17;
            int k = paramInt2 & 0x1;
            if (k == 0)
              break label271;
            i1--;
            while (i1 >= 0)
            {
              Object localObject4 = this.mBackStack;
              localBackStackRecord = (BackStackRecord)((ArrayList)localObject4).get(i1);
              if (paramString != null)
              {
                localObject4 = localBackStackRecord.getName();
                localObject4 = paramString.equals(localObject4);
                if (localObject4 != 0);
              }
              else
              {
                if (paramInt1 < 0)
                  break;
                m = localBackStackRecord.mIndex;
                if (paramInt1 != m)
                  break;
              }
              i1--;
            }
          }
          if (paramInt1 < 0)
            continue;
          m = localBackStackRecord.mIndex;
          if (paramInt1 == m)
            break;
        }
      }
      label271: int m = this.mBackStack.size();
      m--;
      if (i1 == m)
        break label17;
      ArrayList localArrayList2 = new ArrayList();
      m = this.mBackStack.size();
      for (int i2 = m + -1; i2 > i1; i2--)
      {
        localObject5 = this.mBackStack.remove(i2);
        localArrayList2.add(localObject5);
      }
      Object localObject5 = localArrayList2.size();
      int i3 = localObject5 + -1;
      i2 = 0;
      if (i2 <= i3)
      {
        DEBUG = localObject5;
        Object localObject6;
        if (localObject5 != 0)
        {
          localObject5 = "FragmentManager";
          localObject6 = new StringBuilder().append("Popping back stack state: ");
          Object localObject7 = localArrayList2.get(i2);
          localObject6 = localObject7;
          Log.v((String)localObject5, (String)localObject6);
        }
        localObject5 = (BackStackRecord)localArrayList2.get(i2);
        if (i2 == i3)
          localObject6 = localObject1;
        while (true)
        {
          ((BackStackRecord)localObject5).popFromBackStack(localObject6);
          i2++;
          break;
          localObject6 = localObject2;
        }
      }
      reportBackStackChanged();
    }
  }

  public void putFragment(Bundle paramBundle, String paramString, Fragment paramFragment)
  {
    if (paramFragment.mIndex < 0)
    {
      String str = "Fragment " + paramFragment + " is not currently in the FragmentManager";
      IllegalStateException localIllegalStateException = new IllegalStateException(str);
      throwException(localIllegalStateException);
    }
    int i = paramFragment.mIndex;
    paramBundle.putInt(paramString, i);
  }

  public void removeFragment(Fragment paramFragment, int paramInt1, int paramInt2)
  {
    Object localObject1 = 1;
    boolean bool1 = null;
    boolean bool2;
    DEBUG = bool2;
    Object localObject2;
    if (bool2)
    {
      localObject2 = new StringBuilder().append("remove: ").append(paramFragment).append(" nesting=");
      int i = paramFragment.mBackStackNesting;
      localObject2 = i;
      Log.v("FragmentManager", (String)localObject2);
    }
    if (!paramFragment.isInBackStack())
    {
      int j = localObject1;
      if ((!paramFragment.mDetached) || (j != null))
      {
        if (this.mAdded != null)
          this.mAdded.remove(paramFragment);
        if ((paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
          this.mNeedMenuInvalidate = localObject1;
        paramFragment.mAdded = bool1;
        paramFragment.mRemoving = localObject1;
        if (j == null)
          break label182;
        localObject2 = bool1;
      }
    }
    while (true)
    {
      FragmentManagerImpl localFragmentManagerImpl = this;
      Fragment localFragment = paramFragment;
      int k = paramInt1;
      int m = paramInt2;
      localFragmentManagerImpl.moveToState(localFragment, localObject2, k, m, bool1);
      return;
      boolean bool3 = bool1;
      break;
      label182: localObject2 = localObject1;
    }
  }

  public void removeOnBackStackChangedListener(FragmentManager.OnBackStackChangedListener paramOnBackStackChangedListener)
  {
    if (this.mBackStackChangeListeners != null)
      this.mBackStackChangeListeners.remove(paramOnBackStackChangedListener);
  }

  void reportBackStackChanged()
  {
    if (this.mBackStackChangeListeners != null)
      for (int i = 0; ; i++)
      {
        int j = this.mBackStackChangeListeners.size();
        if (i >= j)
          break;
        ((FragmentManager.OnBackStackChangedListener)this.mBackStackChangeListeners.get(i)).onBackStackChanged();
      }
  }

  @Signature({"(", "Landroid/os/Parcelable;", "Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;)V"})
  void restoreAllState(Parcelable paramParcelable, ArrayList paramArrayList)
  {
    boolean bool = null;
    int i = 0;
    if (paramParcelable == null);
    while (true)
    {
      return;
      FragmentManagerState localFragmentManagerState = (FragmentManagerState)paramParcelable;
      Object localObject1 = localFragmentManagerState.mActive;
      if (localObject1 == null)
        continue;
      Fragment localFragment1;
      Object localObject5;
      if (paramArrayList != null)
        for (localObject4 = 0; ; localObject4++)
        {
          localObject1 = paramArrayList.size();
          if (localObject4 >= localObject1)
            break;
          localFragment1 = (Fragment)paramArrayList.get(localObject4);
          DEBUG = localObject1;
          if (localObject1 != 0)
          {
            localObject1 = "FragmentManager";
            String str1 = "restoreAllState: re-attaching retained " + localFragment1;
            Log.v((String)localObject1, str1);
          }
          localObject1 = localFragmentManagerState.mActive;
          int k = localFragment1.mIndex;
          localObject5 = localObject1[k];
          localObject5.mInstance = localFragment1;
          localFragment1.mSavedViewState = i;
          localFragment1.mBackStackNesting = bool;
          localFragment1.mInLayout = bool;
          localFragment1.mAdded = bool;
          localFragment1.mTarget = i;
          localObject1 = localObject5.mSavedFragmentState;
          if (localObject1 == null)
            continue;
          localObject1 = localObject5.mSavedFragmentState;
          ClassLoader localClassLoader = this.mActivity.getClassLoader();
          ((Bundle)localObject1).setClassLoader(localClassLoader);
          localObject1 = localObject5.mSavedFragmentState.getSparseParcelableArray("android:view_state");
          localFragment1.mSavedViewState = ((SparseArray)localObject1);
        }
      int m = localFragmentManagerState.mActive.length;
      localObject1 = new ArrayList(m);
      this.mActive = ((ArrayList)localObject1);
      localObject1 = this.mAvailIndices;
      if (localObject1 != null)
      {
        localObject1 = this.mAvailIndices;
        ((ArrayList)localObject1).clear();
      }
      Object localObject4 = null;
      Object localObject2 = localFragmentManagerState.mActive.length;
      if (localObject4 < localObject2)
      {
        Object localObject3 = localFragmentManagerState.mActive;
        localObject5 = localObject3[localObject4];
        if (localObject5 != null)
        {
          localObject3 = this.mActivity;
          Fragment localFragment2 = this.mParent;
          localFragment1 = localObject5.instantiate((FragmentActivity)localObject3, localFragment2);
          DEBUG = (Z)localObject3;
          if (localObject3 != null)
          {
            localObject3 = "FragmentManager";
            String str2 = "restoreAllState: active #" + localObject4 + ": " + localFragment1;
            Log.v((String)localObject3, str2);
          }
          localObject3 = this.mActive;
          ((ArrayList)localObject3).add(localFragment1);
          localObject5.mInstance = i;
        }
        while (true)
        {
          localObject4++;
          break;
          this.mActive.add(i);
          localObject3 = this.mAvailIndices;
          if (localObject3 == null)
          {
            localObject3 = new ArrayList();
            this.mAvailIndices = ((ArrayList)localObject3);
          }
          DEBUG = (Z)localObject3;
          if (localObject3 != null)
          {
            localObject3 = "FragmentManager";
            String str3 = "restoreAllState: avail #" + localObject4;
            Log.v((String)localObject3, str3);
          }
          localObject3 = this.mAvailIndices;
          Integer localInteger = Integer.valueOf(localObject4);
          ((ArrayList)localObject3).add(localInteger);
        }
      }
      int j;
      if (paramArrayList != null)
      {
        j = 0;
        int n = paramArrayList.size();
        if (j < n)
        {
          localFragment1 = (Fragment)paramArrayList.get(j);
          Fragment localFragment3;
          if (localFragment1.mTargetIndex >= 0)
          {
            int i1 = localFragment1.mTargetIndex;
            int i2 = this.mActive.size();
            if (i1 >= i2)
              break label619;
            ArrayList localArrayList1 = this.mActive;
            int i3 = localFragment1.mTargetIndex;
            localFragment3 = (Fragment)localArrayList1.get(i3);
          }
          for (localFragment1.mTarget = localFragment3; ; localFragment1.mTarget = i)
          {
            j++;
            break;
            label619: StringBuilder localStringBuilder1 = new StringBuilder().append("Re-attaching retained fragment ").append(localFragment1).append(" target no longer exists: ");
            int i4 = localFragment1.mTargetIndex;
            String str4 = i4;
            Log.w("FragmentManager", str4);
          }
        }
      }
      if (localFragmentManagerState.mAdded != null)
      {
        int i5 = localFragmentManagerState.mAdded.length;
        ArrayList localArrayList2 = new ArrayList(i5);
        this.mAdded = localArrayList2;
        for (j = 0; ; j++)
        {
          int i6 = localFragmentManagerState.mAdded.length;
          if (j >= i6)
            break;
          ArrayList localArrayList3 = this.mActive;
          int i7 = localFragmentManagerState.mAdded[j];
          localFragment1 = (Fragment)localArrayList3.get(i7);
          if (localFragment1 == null)
          {
            StringBuilder localStringBuilder2 = new StringBuilder().append("No instantiated fragment for index #");
            int i8 = localFragmentManagerState.mAdded[j];
            String str5 = i8;
            IllegalStateException localIllegalStateException = new IllegalStateException(str5);
            throwException(localIllegalStateException);
          }
          localFragment1.mAdded = true;
          DEBUG = true;
          if (1 != 0)
          {
            String str6 = "restoreAllState: added #" + j + ": " + localFragment1;
            Log.v("FragmentManager", str6);
          }
          if (this.mAdded.contains(localFragment1))
            throw new IllegalStateException("Already added!");
          this.mAdded.add(localFragment1);
        }
      }
      this.mAdded = i;
      if (localFragmentManagerState.mBackStack != null)
      {
        int i9 = localFragmentManagerState.mBackStack.length;
        ArrayList localArrayList4 = new ArrayList(i9);
        this.mBackStack = localArrayList4;
        for (j = 0; ; j++)
        {
          int i10 = localFragmentManagerState.mBackStack.length;
          if (j >= i10)
            break;
          BackStackState localBackStackState = localFragmentManagerState.mBackStack[j];
          BackStackRecord localBackStackRecord = localBackStackState.instantiate(this);
          DEBUG = localBackStackState;
          if (localBackStackState != null)
          {
            StringBuilder localStringBuilder3 = new StringBuilder().append("restoreAllState: back stack #").append(j).append(" (index ");
            int i11 = localBackStackRecord.mIndex;
            String str7 = i11 + "): " + localBackStackRecord;
            Log.v("FragmentManager", str7);
            LogWriter localLogWriter = new LogWriter("FragmentManager");
            PrintWriter localPrintWriter = new PrintWriter(localLogWriter);
            localBackStackRecord.dump("  ", localPrintWriter, bool);
          }
          this.mBackStack.add(localBackStackRecord);
          if (localBackStackRecord.mIndex < 0)
            continue;
          int i12 = localBackStackRecord.mIndex;
          setBackStackIndex(i12, localBackStackRecord);
        }
      }
      this.mBackStack = i;
    }
  }

  @Signature({"()", "Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
  ArrayList retainNonConfig()
  {
    ArrayList localArrayList = null;
    Object localObject1 = this.mActive;
    if (localObject1 != null)
    {
      Object localObject2 = 0;
      localObject1 = this.mActive.size();
      if (localObject2 < localObject1)
      {
        localObject1 = this.mActive;
        Fragment localFragment2 = (Fragment)((ArrayList)localObject1).get(localObject2);
        if (localFragment2 != null)
        {
          boolean bool = localFragment2.mRetainInstance;
          if (bool)
          {
            if (localArrayList == null)
              localArrayList = new ArrayList();
            localArrayList.add(localFragment2);
            localFragment2.mRetaining = true;
            Fragment localFragment1 = localFragment2.mTarget;
            if (localFragment1 == null)
              break label153;
          }
        }
        label153: int j;
        for (int i = localFragment2.mTarget.mIndex; ; j = -1)
        {
          localFragment2.mTargetIndex = i;
          DEBUG = i;
          if (i != 0)
          {
            String str1 = "FragmentManager";
            String str2 = "retainNonConfig: keeping retained " + localFragment2;
            Log.v(str1, str2);
          }
          localObject2++;
          break;
        }
      }
    }
    return (ArrayList)(ArrayList)localArrayList;
  }

  Parcelable saveAllState()
  {
    int i = 0;
    execPendingActions();
    boolean bool;
    HONEYCOMB = bool;
    if (bool)
    {
      bool = true;
      this.mStateSaved = bool;
    }
    Object localObject1 = this.mActive;
    if (localObject1 != null)
    {
      localObject1 = this.mActive.size();
      if (localObject1 > 0)
        break label45;
    }
    while (true)
    {
      return i;
      label45: localObject1 = this.mActive;
      int i2 = ((ArrayList)localObject1).size();
      FragmentState[] arrayOfFragmentState = new FragmentState[i2];
      Object localObject6 = null;
      int i4 = 0;
      int i3;
      if (i4 < i2)
      {
        localObject1 = this.mActive;
        Fragment localFragment1 = (Fragment)((ArrayList)localObject1).get(i4);
        FragmentState localFragmentState;
        if (localFragment1 != null)
        {
          int j = localFragment1.mIndex;
          if (j < 0)
          {
            StringBuilder localStringBuilder1 = new StringBuilder().append("Failure saving state: active ").append(localFragment1).append(" has cleared index: ");
            int i5 = localFragment1.mIndex;
            String str1 = i5;
            IllegalStateException localIllegalStateException = new IllegalStateException(str1);
            throwException(localIllegalStateException);
          }
          i3 = 1;
          localFragmentState = new FragmentState(localFragment1);
          arrayOfFragmentState[i4] = localFragmentState;
          int k = localFragment1.mState;
          if (k <= 0)
            break label447;
          Object localObject2 = localFragmentState.mSavedFragmentState;
          if (localObject2 != null)
            break label447;
          localObject2 = saveFragmentBasicState(localFragment1);
          localFragmentState.mSavedFragmentState = ((Bundle)localObject2);
          localObject2 = localFragment1.mTarget;
          if (localObject2 != null)
          {
            int m = localFragment1.mTarget.mIndex;
            if (m < 0)
            {
              StringBuilder localStringBuilder2 = new StringBuilder().append("Failure saving state: ").append(localFragment1).append(" has target not in fragment manager: ");
              Fragment localFragment2 = localFragment1.mTarget;
              String str2 = localFragment2;
              localObject3 = new IllegalStateException(str2);
              throwException((RuntimeException)localObject3);
            }
            Object localObject3 = localFragmentState.mSavedFragmentState;
            if (localObject3 == null)
            {
              localObject3 = new Bundle();
              localFragmentState.mSavedFragmentState = ((Bundle)localObject3);
            }
            localObject3 = localFragmentState.mSavedFragmentState;
            Fragment localFragment3 = localFragment1.mTarget;
            putFragment((Bundle)localObject3, "android:target_state", localFragment3);
            int n = localFragment1.mTargetRequestCode;
            if (n != 0)
            {
              localObject4 = localFragmentState.mSavedFragmentState;
              int i6 = localFragment1.mTargetRequestCode;
              ((Bundle)localObject4).putInt("android:target_req_state", i6);
            }
          }
        }
        while (true)
        {
          DEBUG = (Z)localObject4;
          if (localObject4 != null)
          {
            localObject4 = "FragmentManager";
            StringBuilder localStringBuilder3 = new StringBuilder().append("Saved state of ").append(localFragment1).append(": ");
            Bundle localBundle = localFragmentState.mSavedFragmentState;
            String str3 = localBundle;
            Log.v((String)localObject4, str3);
          }
          i4++;
          break;
          label447: localObject4 = localFragment1.mSavedFragmentState;
          localFragmentState.mSavedFragmentState = ((Bundle)localObject4);
        }
      }
      if (i3 == null)
      {
        DEBUG = (Z)localObject4;
        if (localObject4 == null)
          continue;
        Log.v("FragmentManager", "saveAllState: no fragments!");
        continue;
      }
      int i7 = null;
      int i8 = null;
      Object localObject4 = this.mAdded;
      int[] arrayOfInt;
      if (localObject4 != null)
      {
        localObject4 = this.mAdded;
        i2 = ((ArrayList)localObject4).size();
        if (i2 > 0)
        {
          arrayOfInt = new int[i2];
          for (i4 = 0; i4 < i2; i4++)
          {
            int i1 = ((Fragment)this.mAdded.get(i4)).mIndex;
            arrayOfInt[i4] = i1;
            i1 = arrayOfInt[i4];
            if (i1 < 0)
            {
              StringBuilder localStringBuilder4 = new StringBuilder().append("Failure saving state: active ");
              Object localObject7 = this.mAdded.get(i4);
              StringBuilder localStringBuilder5 = localStringBuilder4.append(localObject7).append(" has cleared index: ");
              int i9 = arrayOfInt[i4];
              String str4 = i9;
              localObject5 = new IllegalStateException(str4);
              throwException((RuntimeException)localObject5);
            }
            DEBUG = localObject5;
            if (localObject5 == 0)
              continue;
            Object localObject5 = "FragmentManager";
            StringBuilder localStringBuilder6 = new StringBuilder().append("saveAllState: adding fragment #").append(i4).append(": ");
            Object localObject8 = this.mAdded.get(i4);
            String str5 = localObject8;
            Log.v((String)localObject5, str5);
          }
        }
      }
      BackStackState[] arrayOfBackStackState;
      if (this.mBackStack != null)
      {
        i2 = this.mBackStack.size();
        if (i2 > 0)
        {
          arrayOfBackStackState = new BackStackState[i2];
          for (i4 = null; i4 < i2; i4++)
          {
            BackStackRecord localBackStackRecord = (BackStackRecord)this.mBackStack.get(i4);
            BackStackState localBackStackState = new BackStackState(this, localBackStackRecord);
            arrayOfBackStackState[i4] = localBackStackState;
            DEBUG = localBackStackRecord;
            if (localBackStackRecord == null)
              continue;
            StringBuilder localStringBuilder7 = new StringBuilder().append("saveAllState: adding back stack #").append(i4).append(": ");
            Object localObject9 = this.mBackStack.get(i4);
            String str6 = localObject9;
            Log.v("FragmentManager", str6);
          }
        }
      }
      FragmentManagerState localFragmentManagerState = new FragmentManagerState();
      localFragmentManagerState.mActive = arrayOfFragmentState;
      localFragmentManagerState.mAdded = arrayOfInt;
      localFragmentManagerState.mBackStack = arrayOfBackStackState;
    }
  }

  Bundle saveFragmentBasicState(Fragment paramFragment)
  {
    Bundle localBundle1 = null;
    if (this.mStateBundle == null)
    {
      Bundle localBundle2 = new Bundle();
      this.mStateBundle = localBundle2;
    }
    Bundle localBundle3 = this.mStateBundle;
    paramFragment.performSaveInstanceState(localBundle3);
    if (!this.mStateBundle.isEmpty())
    {
      localBundle1 = this.mStateBundle;
      this.mStateBundle = null;
    }
    if (paramFragment.mView != null)
      saveFragmentViewState(paramFragment);
    if (paramFragment.mSavedViewState != null)
    {
      if (localBundle1 == null)
        localBundle1 = new Bundle();
      SparseArray localSparseArray = paramFragment.mSavedViewState;
      localBundle1.putSparseParcelableArray("android:view_state", localSparseArray);
    }
    if (!paramFragment.mUserVisibleHint)
    {
      if (localBundle1 == null)
        localBundle1 = new Bundle();
      boolean bool = paramFragment.mUserVisibleHint;
      localBundle1.putBoolean("android:user_visible_hint", bool);
    }
    return localBundle1;
  }

  public Fragment.SavedState saveFragmentInstanceState(Fragment paramFragment)
  {
    int i = 0;
    if (paramFragment.mIndex < 0)
    {
      String str = "Fragment " + paramFragment + " is not currently in the FragmentManager";
      IllegalStateException localIllegalStateException = new IllegalStateException(str);
      throwException(localIllegalStateException);
    }
    Fragment.SavedState localSavedState;
    if (paramFragment.mState > 0)
    {
      Bundle localBundle = saveFragmentBasicState(paramFragment);
      if (localBundle != null)
        localSavedState = new Fragment.SavedState(localBundle);
    }
    return localSavedState;
  }

  void saveFragmentViewState(Fragment paramFragment)
  {
    if (paramFragment.mInnerView == null)
      return;
    if (this.mStateArray == null)
    {
      SparseArray localSparseArray1 = new SparseArray();
      this.mStateArray = localSparseArray1;
    }
    while (true)
    {
      View localView = paramFragment.mInnerView;
      SparseArray localSparseArray2 = this.mStateArray;
      localView.saveHierarchyState(localSparseArray2);
      if (this.mStateArray.size() <= 0)
        break;
      SparseArray localSparseArray3 = this.mStateArray;
      paramFragment.mSavedViewState = localSparseArray3;
      this.mStateArray = null;
      break;
      this.mStateArray.clear();
    }
  }

  public void setBackStackIndex(int paramInt, BackStackRecord paramBackStackRecord)
  {
    monitorenter;
    try
    {
      Object localObject1 = this.mBackStackIndices;
      if (localObject1 == null)
      {
        localObject1 = new ArrayList();
        this.mBackStackIndices = ((ArrayList)localObject1);
      }
      localObject1 = this.mBackStackIndices;
      int i = ((ArrayList)localObject1).size();
      if (paramInt < i)
      {
        DEBUG = (Z)localObject1;
        if (localObject1 != null)
        {
          localObject1 = "FragmentManager";
          String str1 = "Setting back stack index " + paramInt + " to " + paramBackStackRecord;
          Log.v((String)localObject1, str1);
        }
        localObject1 = this.mBackStackIndices;
        ((ArrayList)localObject1).set(paramInt, paramBackStackRecord);
        return;
      }
      while (i < paramInt)
      {
        this.mBackStackIndices.add(null);
        localObject1 = this.mAvailBackStackIndices;
        if (localObject1 == null)
        {
          localObject1 = new ArrayList();
          this.mAvailBackStackIndices = ((ArrayList)localObject1);
        }
        DEBUG = (Z)localObject1;
        if (localObject1 != null)
        {
          localObject1 = "FragmentManager";
          String str2 = "Adding available back stack index " + i;
          Log.v((String)localObject1, str2);
        }
        localObject1 = this.mAvailBackStackIndices;
        Integer localInteger = Integer.valueOf(i);
        ((ArrayList)localObject1).add(localInteger);
        i++;
      }
      DEBUG = (Z)localObject1;
      if (localObject1 != null)
      {
        localObject1 = "FragmentManager";
        String str3 = "Adding back stack index " + paramInt + " with " + paramBackStackRecord;
        Log.v((String)localObject1, str3);
      }
      localObject1 = this.mBackStackIndices;
      ((ArrayList)localObject1).add(paramBackStackRecord);
    }
    finally
    {
      monitorexit;
    }
  }

  public void showFragment(Fragment paramFragment, int paramInt1, int paramInt2)
  {
    boolean bool1 = true;
    int i = 0;
    boolean bool2;
    DEBUG = bool2;
    if (bool2)
    {
      String str = "show: " + paramFragment;
      Log.v("FragmentManager", str);
    }
    if (paramFragment.mHidden)
    {
      paramFragment.mHidden = i;
      if (paramFragment.mView != null)
      {
        Animation localAnimation = loadAnimation(paramFragment, paramInt1, bool1, paramInt2);
        if (localAnimation != null)
          paramFragment.mView.startAnimation(localAnimation);
        paramFragment.mView.setVisibility(i);
      }
      if ((paramFragment.mAdded) && (paramFragment.mHasMenu) && (paramFragment.mMenuVisible))
        this.mNeedMenuInvalidate = bool1;
      paramFragment.onHiddenChanged(i);
    }
  }

  void startPendingDeferredFragments()
  {
    if (this.mActive == null)
      return;
    for (int i = 0; ; i++)
    {
      int j = this.mActive.size();
      if (i >= j)
        break;
      Fragment localFragment = (Fragment)this.mActive.get(i);
      if (localFragment == null)
        continue;
      performPendingDeferredStart(localFragment);
    }
  }

  public String toString()
  {
    StringBuilder localStringBuilder = new StringBuilder(128);
    localStringBuilder.append("FragmentManager{");
    String str = Integer.toHexString(System.identityHashCode(this));
    localStringBuilder.append(str);
    localStringBuilder.append(" in ");
    if (this.mParent != null)
      DebugUtils.buildShortClassTag(this.mParent, localStringBuilder);
    while (true)
    {
      localStringBuilder.append("}}");
      return localStringBuilder.toString();
      DebugUtils.buildShortClassTag(this.mActivity, localStringBuilder);
    }
  }
}