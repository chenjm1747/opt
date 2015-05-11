package android.support.v4.app;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.Resources.NotFoundException;
import android.content.res.TypedArray;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.Handler;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

public class FragmentActivity extends Activity
{
  static final String FRAGMENTS_TAG = "android:support:fragments";
  private static final int HONEYCOMB = 11;
  static final int MSG_REALLY_STOPPED = 1;
  static final int MSG_RESUME_PENDING = 2;
  private static final String TAG = "FragmentActivity";

  @Signature({"Ljava/util/HashMap", "<", "Ljava/lang/String;", "Landroid/support/v4/app/LoaderManagerImpl;", ">;"})
  HashMap mAllLoaderManagers;
  boolean mCheckedForLoaderManager;
  final FragmentContainer mContainer;
  boolean mCreated;
  final FragmentManagerImpl mFragments;
  final Handler mHandler;
  LoaderManagerImpl mLoaderManager;
  boolean mLoadersStarted;
  boolean mOptionsMenuInvalidated;
  boolean mReallyStopped;
  boolean mResumed;
  boolean mRetaining;
  boolean mStopped;

  public FragmentActivity()
  {
    FragmentActivity.1 local1 = new FragmentActivity.1(this);
    this.mHandler = local1;
    FragmentManagerImpl localFragmentManagerImpl = new FragmentManagerImpl();
    this.mFragments = localFragmentManagerImpl;
    FragmentActivity.2 local2 = new FragmentActivity.2(this);
    this.mContainer = local2;
  }

  private void dumpViewHierarchy(String paramString, PrintWriter paramPrintWriter, View paramView)
  {
    paramPrintWriter.print(paramString);
    if (paramView == null)
      paramPrintWriter.println("null");
    while (true)
    {
      return;
      String str = viewToString(paramView);
      paramPrintWriter.println(str);
      if (!(paramView instanceof ViewGroup))
        continue;
      ViewGroup localViewGroup = (ViewGroup)paramView;
      int i = localViewGroup.getChildCount();
      if (i <= 0)
        continue;
      paramString = paramString + "  ";
      for (int j = 0; j < i; j++)
      {
        View localView = localViewGroup.getChildAt(j);
        dumpViewHierarchy(paramString, paramPrintWriter, localView);
      }
    }
  }

  private static String viewToString(View paramView)
  {
    boolean bool1 = true;
    Object localObject1 = 70;
    char c1 = ',';
    char c2 = ' ';
    boolean bool2 = true;
    StringBuilder localStringBuilder = new StringBuilder(128);
    Object localObject2 = paramView.getClass().getName();
    localStringBuilder.append((String)localObject2);
    localStringBuilder.append('{');
    localObject2 = Integer.toHexString(System.identityHashCode(paramView));
    localStringBuilder.append((String)localObject2);
    localStringBuilder.append(c2);
    localObject2 = paramView.getVisibility();
    switch (localObject2)
    {
    default:
      localStringBuilder.append(bool2);
    case 0:
    case 4:
    case 8:
    }
    while (true)
    {
      localObject2 = paramView.isFocusable();
      label142: label165: label188: label211: label233: char c7;
      label256: label279: label306: label328: int n;
      Resources localResources;
      if (localObject2 != 0)
      {
        localObject2 = localObject1;
        localStringBuilder.append(localObject2);
        localObject2 = paramView.isEnabled();
        if (localObject2 == 0)
          break label660;
        char c3 = 'E';
        localStringBuilder.append(c3);
        boolean bool3 = paramView.willNotDraw();
        if (!bool3)
          break label667;
        bool3 = bool2;
        localStringBuilder.append(bool3);
        bool3 = paramView.isHorizontalScrollBarEnabled();
        if (!bool3)
          break label674;
        char c4 = 'H';
        localStringBuilder.append(c4);
        boolean bool4 = paramView.isVerticalScrollBarEnabled();
        if (!bool4)
          break label681;
        bool4 = bool1;
        localStringBuilder.append(bool4);
        bool4 = paramView.isClickable();
        if (!bool4)
          break label688;
        char c5 = 'C';
        localStringBuilder.append(c5);
        boolean bool5 = paramView.isLongClickable();
        if (!bool5)
          break label695;
        char c6 = 'L';
        localStringBuilder.append(c6);
        localStringBuilder.append(c2);
        boolean bool6 = paramView.isFocused();
        if (!bool6)
          break label702;
        localStringBuilder.append(localObject1);
        bool6 = paramView.isSelected();
        if (!bool6)
          break label708;
        c7 = 'S';
        localStringBuilder.append(c7);
        if (paramView.isPressed())
          bool2 = true;
        localStringBuilder.append(bool2);
        localStringBuilder.append(c2);
        int i = paramView.getLeft();
        localStringBuilder.append(i);
        localStringBuilder.append(c1);
        int j = paramView.getTop();
        localStringBuilder.append(j);
        localStringBuilder.append('-');
        int k = paramView.getRight();
        localStringBuilder.append(k);
        localStringBuilder.append(c1);
        int m = paramView.getBottom();
        localStringBuilder.append(m);
        n = paramView.getId();
        if (n != -1)
        {
          localStringBuilder.append(" #");
          String str1 = Integer.toHexString(n);
          localStringBuilder.append(str1);
          localResources = paramView.getResources();
          if ((n != 0) && (localResources != null))
            switch (0xFF000000 & n)
            {
            default:
            case 2130706432:
            case 16777216:
            }
        }
      }
      try
      {
        String str2 = localResources.getResourcePackageName(n);
        while (true)
        {
          String str3 = localResources.getResourceTypeName(n);
          String str4 = localResources.getResourceEntryName(n);
          localStringBuilder.append(" ");
          localStringBuilder.append(str2);
          localStringBuilder.append(":");
          localStringBuilder.append(str3);
          localStringBuilder.append("/");
          localStringBuilder.append(str4);
          label599: localStringBuilder.append("}");
          return localStringBuilder.toString();
          localStringBuilder.append(bool1);
          break;
          c7 = 'I';
          localStringBuilder.append(c7);
          break;
          c7 = 'G';
          localStringBuilder.append(c7);
          break;
          c7 = bool2;
          break label142;
          label660: c7 = bool2;
          break label165;
          label667: c7 = 'D';
          break label188;
          label674: c7 = bool2;
          break label211;
          label681: c7 = bool2;
          break label233;
          label688: c7 = bool2;
          break label256;
          label695: c7 = bool2;
          break label279;
          label702: localObject1 = bool2;
          break label306;
          label708: c7 = bool2;
          break label328;
          str2 = "app";
          continue;
          str2 = "android";
        }
      }
      catch (Resources.NotFoundException localNotFoundException)
      {
        break label599;
      }
    }
  }

  void doReallyStop(boolean paramBoolean)
  {
    int i = 1;
    if (!this.mReallyStopped)
    {
      this.mReallyStopped = i;
      this.mRetaining = paramBoolean;
      this.mHandler.removeMessages(i);
      onReallyStop();
    }
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    if (Build.VERSION.SDK_INT >= 11);
    paramPrintWriter.print(paramString);
    paramPrintWriter.print("Local FragmentActivity ");
    String str1 = Integer.toHexString(System.identityHashCode(this));
    paramPrintWriter.print(str1);
    paramPrintWriter.println(" State:");
    String str2 = paramString + "  ";
    paramPrintWriter.print(str2);
    paramPrintWriter.print("mCreated=");
    boolean bool1 = this.mCreated;
    paramPrintWriter.print(bool1);
    paramPrintWriter.print("mResumed=");
    boolean bool2 = this.mResumed;
    paramPrintWriter.print(bool2);
    paramPrintWriter.print(" mStopped=");
    boolean bool3 = this.mStopped;
    paramPrintWriter.print(bool3);
    paramPrintWriter.print(" mReallyStopped=");
    boolean bool4 = this.mReallyStopped;
    paramPrintWriter.println(bool4);
    paramPrintWriter.print(str2);
    paramPrintWriter.print("mLoadersStarted=");
    boolean bool5 = this.mLoadersStarted;
    paramPrintWriter.println(bool5);
    if (this.mLoaderManager != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("Loader Manager ");
      String str3 = Integer.toHexString(System.identityHashCode(this.mLoaderManager));
      paramPrintWriter.print(str3);
      paramPrintWriter.println(":");
      LoaderManagerImpl localLoaderManagerImpl = this.mLoaderManager;
      String str4 = paramString + "  ";
      localLoaderManagerImpl.dump(str4, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
    }
    this.mFragments.dump(paramString, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
    paramPrintWriter.print(paramString);
    paramPrintWriter.println("View Hierarchy:");
    String str5 = paramString + "  ";
    View localView = getWindow().getDecorView();
    dumpViewHierarchy(str5, paramPrintWriter, localView);
  }

  public Object getLastCustomNonConfigurationInstance()
  {
    NonConfigurationInstances localNonConfigurationInstances = (NonConfigurationInstances)getLastNonConfigurationInstance();
    Object localObject;
    if (localNonConfigurationInstances != null)
      localObject = localNonConfigurationInstances.custom;
    while (true)
    {
      return localObject;
      int i = 0;
    }
  }

  LoaderManagerImpl getLoaderManager(String paramString, boolean paramBoolean1, boolean paramBoolean2)
  {
    if (this.mAllLoaderManagers == null)
    {
      HashMap localHashMap = new HashMap();
      this.mAllLoaderManagers = localHashMap;
    }
    LoaderManagerImpl localLoaderManagerImpl = (LoaderManagerImpl)this.mAllLoaderManagers.get(paramString);
    if (localLoaderManagerImpl == null)
      if (paramBoolean2)
      {
        localLoaderManagerImpl = new LoaderManagerImpl(paramString, this, paramBoolean1);
        this.mAllLoaderManagers.put(paramString, localLoaderManagerImpl);
      }
    while (true)
    {
      return localLoaderManagerImpl;
      localLoaderManagerImpl.updateActivity(this);
    }
  }

  public FragmentManager getSupportFragmentManager()
  {
    return this.mFragments;
  }

  public LoaderManager getSupportLoaderManager()
  {
    boolean bool1 = true;
    LoaderManagerImpl localLoaderManagerImpl = this.mLoaderManager;
    if (localLoaderManagerImpl != null);
    for (localLoaderManagerImpl = this.mLoaderManager; ; localLoaderManagerImpl = this.mLoaderManager)
    {
      return localLoaderManagerImpl;
      this.mCheckedForLoaderManager = bool1;
      boolean bool2 = this.mLoadersStarted;
      localLoaderManagerImpl = getLoaderManager(null, bool2, bool1);
      this.mLoaderManager = localLoaderManagerImpl;
    }
  }

  void invalidateSupportFragment(String paramString)
  {
    if (this.mAllLoaderManagers != null)
    {
      LoaderManagerImpl localLoaderManagerImpl = (LoaderManagerImpl)this.mAllLoaderManagers.get(paramString);
      if ((localLoaderManagerImpl != null) && (!localLoaderManagerImpl.mRetaining))
      {
        localLoaderManagerImpl.doDestroy();
        this.mAllLoaderManagers.remove(paramString);
      }
    }
  }

  protected void onActivityResult(int paramInt1, int paramInt2, Intent paramIntent)
  {
    this.mFragments.noteStateNotSaved();
    int i = paramInt1 >> 16;
    if (i != 0)
    {
      i--;
      if ((this.mFragments.mActive != null) && (i >= 0))
      {
        int j = this.mFragments.mActive.size();
        if (i < j);
      }
      else
      {
        StringBuilder localStringBuilder1 = new StringBuilder().append("Activity result fragment index out of range: 0x");
        String str1 = Integer.toHexString(paramInt1);
        String str2 = str1;
        Log.w("FragmentActivity", str2);
      }
    }
    while (true)
    {
      return;
      Fragment localFragment = (Fragment)this.mFragments.mActive.get(i);
      if (localFragment == null)
      {
        StringBuilder localStringBuilder2 = new StringBuilder().append("Activity result no fragment exists for index: 0x");
        String str3 = Integer.toHexString(paramInt1);
        String str4 = str3;
        Log.w("FragmentActivity", str4);
        continue;
      }
      int k = 0xFFFF & paramInt1;
      localFragment.onActivityResult(k, paramInt2, paramIntent);
      continue;
      super.onActivityResult(paramInt1, paramInt2, paramIntent);
    }
  }

  public void onAttachFragment(Fragment paramFragment)
  {
  }

  public void onBackPressed()
  {
    if (!this.mFragments.popBackStackImmediate())
      finish();
  }

  public void onConfigurationChanged(Configuration paramConfiguration)
  {
    super.onConfigurationChanged(paramConfiguration);
    this.mFragments.dispatchConfigurationChanged(paramConfiguration);
  }

  protected void onCreate(Bundle paramBundle)
  {
    Object localObject1 = null;
    Object localObject2 = this.mFragments;
    FragmentContainer localFragmentContainer = this.mContainer;
    ((FragmentManagerImpl)localObject2).attachActivity(this, localFragmentContainer, (Fragment)localObject1);
    localObject2 = getLayoutInflater().getFactory();
    if (localObject2 == null)
    {
      localObject2 = getLayoutInflater();
      ((LayoutInflater)localObject2).setFactory(this);
    }
    super.onCreate(paramBundle);
    NonConfigurationInstances localNonConfigurationInstances = (NonConfigurationInstances)getLastNonConfigurationInstance();
    if (localNonConfigurationInstances != null)
    {
      localObject2 = localNonConfigurationInstances.loaders;
      this.mAllLoaderManagers = ((HashMap)localObject2);
    }
    if (paramBundle != null)
    {
      Parcelable localParcelable = paramBundle.getParcelable("android:support:fragments");
      localObject2 = this.mFragments;
      if (localNonConfigurationInstances != null)
        localObject1 = localNonConfigurationInstances.fragments;
      ((FragmentManagerImpl)localObject2).restoreAllState(localParcelable, (ArrayList)localObject1);
    }
    this.mFragments.dispatchCreate();
  }

  public boolean onCreatePanelMenu(int paramInt, Menu paramMenu)
  {
    boolean bool1;
    if (paramInt == 0)
    {
      bool1 = super.onCreatePanelMenu(paramInt, paramMenu);
      FragmentManagerImpl localFragmentManagerImpl = this.mFragments;
      MenuInflater localMenuInflater = getMenuInflater();
      boolean bool2 = localFragmentManagerImpl.dispatchCreateOptionsMenu(paramMenu, localMenuInflater);
      bool1 |= bool2;
      if (Build.VERSION.SDK_INT < 11);
    }
    while (true)
    {
      return bool1;
      bool1 = true;
      continue;
      bool1 = super.onCreatePanelMenu(paramInt, paramMenu);
    }
  }

  public View onCreateView(String paramString, Context paramContext, AttributeSet paramAttributeSet)
  {
    int i = 0;
    int j = 0;
    int m = 1;
    int n = -1;
    boolean bool1 = "fragment".equals(paramString);
    if (!bool1);
    Fragment localFragment;
    Object localObject3;
    for (Object localObject1 = super.onCreateView(paramString, paramContext, paramAttributeSet); ; localObject3 = localFragment.mView)
    {
      return localObject1;
      String str1 = paramAttributeSet.getAttributeValue(i, "class");
      localObject1 = FragmentTag.Fragment;
      TypedArray localTypedArray = paramContext.obtainStyledAttributes(paramAttributeSet, localObject1);
      if (str1 == null)
        str1 = localTypedArray.getString(j);
      int i3 = localTypedArray.getResourceId(m, n);
      int i1 = 2;
      String str2 = localTypedArray.getString(i1);
      localTypedArray.recycle();
      Object localObject4 = null;
      int k;
      if (localObject4 != null)
        k = localObject4.getId();
      if ((k == n) && (i3 == n) && (str2 == null))
      {
        StringBuilder localStringBuilder1 = new StringBuilder();
        String str3 = paramAttributeSet.getPositionDescription();
        String str4 = str3 + ": Must specify unique android:id, android:tag, or have a parent with an id for " + str1;
        throw new IllegalArgumentException(str4);
      }
      Object localObject2;
      if (i3 != n)
      {
        localObject2 = this.mFragments;
        localFragment = ((FragmentManagerImpl)localObject2).findFragmentById(i3);
      }
      if ((localFragment == 0) && (str2 != null))
      {
        localObject2 = this.mFragments;
        localFragment = ((FragmentManagerImpl)localObject2).findFragmentByTag(str2);
      }
      if ((localFragment == 0) && (k != n))
      {
        localObject2 = this.mFragments;
        localFragment = ((FragmentManagerImpl)localObject2).findFragmentById(k);
      }
      FragmentManagerImpl.DEBUG = localObject2;
      if (localObject2 != 0)
      {
        localObject2 = "FragmentActivity";
        StringBuilder localStringBuilder2 = new StringBuilder().append("onCreateView: id=0x");
        String str5 = Integer.toHexString(i3);
        String str6 = str5 + " fname=" + str1 + " existing=" + localFragment;
        Log.v((String)localObject2, str6);
      }
      if (localFragment == 0)
      {
        localFragment = Fragment.instantiate(this, str1);
        localFragment.mFromLayout = m;
        if (i3 != 0)
        {
          localObject2 = i3;
          localFragment.mFragmentId = localObject2;
          localFragment.mContainerId = k;
          localFragment.mTag = str2;
          localFragment.mInLayout = m;
          localObject2 = this.mFragments;
          localFragment.mFragmentManager = ((FragmentManagerImpl)localObject2);
          localObject2 = localFragment.mSavedFragmentState;
          localFragment.onInflate(this, paramAttributeSet, (Bundle)localObject2);
          localObject2 = this.mFragments;
          ((FragmentManagerImpl)localObject2).addFragment(localFragment, m);
        }
      }
      while (true)
      {
        localObject2 = localFragment.mView;
        if (localObject2 != null)
          break label671;
        String str7 = "Fragment " + str1 + " did not create a view.";
        throw new IllegalStateException(str7);
        int i2 = k;
        break;
        boolean bool2 = localFragment.mInLayout;
        if (bool2)
        {
          StringBuilder localStringBuilder3 = new StringBuilder();
          String str8 = paramAttributeSet.getPositionDescription();
          StringBuilder localStringBuilder4 = localStringBuilder3.append(str8).append(": Duplicate id 0x");
          String str9 = Integer.toHexString(i3);
          StringBuilder localStringBuilder5 = localStringBuilder4.append(str9).append(", tag ").append(str2).append(", or parent id 0x");
          String str10 = Integer.toHexString(k);
          String str11 = str10 + " with another fragment for " + str1;
          throw new IllegalArgumentException(str11);
        }
        localFragment.mInLayout = m;
        bool2 = localFragment.mRetaining;
        if (!bool2)
        {
          localObject3 = localFragment.mSavedFragmentState;
          localFragment.onInflate(this, paramAttributeSet, (Bundle)localObject3);
        }
        localObject3 = this.mFragments;
        ((FragmentManagerImpl)localObject3).moveToState(localFragment);
      }
      label671: if (i3 != 0)
      {
        localObject3 = localFragment.mView;
        ((View)localObject3).setId(i3);
      }
      localObject3 = localFragment.mView.getTag();
      if (localObject3 != null)
        continue;
      localObject3 = localFragment.mView;
      ((View)localObject3).setTag(str2);
    }
  }

  protected void onDestroy()
  {
    super.onDestroy();
    doReallyStop(null);
    this.mFragments.dispatchDestroy();
    if (this.mLoaderManager != null)
      this.mLoaderManager.doDestroy();
  }

  public boolean onKeyDown(int paramInt, KeyEvent paramKeyEvent)
  {
    int i = Build.VERSION.SDK_INT;
    if (i < 5)
    {
      i = 4;
      if (paramInt == i)
      {
        i = paramKeyEvent.getRepeatCount();
        if (i == 0)
        {
          onBackPressed();
          i = 1;
        }
      }
    }
    while (true)
    {
      return i;
      boolean bool = super.onKeyDown(paramInt, paramKeyEvent);
    }
  }

  public void onLowMemory()
  {
    super.onLowMemory();
    this.mFragments.dispatchLowMemory();
  }

  public boolean onMenuItemSelected(int paramInt, MenuItem paramMenuItem)
  {
    boolean bool1 = super.onMenuItemSelected(paramInt, paramMenuItem);
    if (bool1)
      bool1 = true;
    while (true)
    {
      return bool1;
      boolean bool2;
      switch (paramInt)
      {
      default:
        bool2 = null;
        break;
      case 0:
        bool2 = this.mFragments.dispatchOptionsItemSelected(paramMenuItem);
        break;
      case 6:
        bool2 = this.mFragments.dispatchContextItemSelected(paramMenuItem);
      }
    }
  }

  protected void onNewIntent(Intent paramIntent)
  {
    super.onNewIntent(paramIntent);
    this.mFragments.noteStateNotSaved();
  }

  public void onPanelClosed(int paramInt, Menu paramMenu)
  {
    switch (paramInt)
    {
    default:
    case 0:
    }
    while (true)
    {
      super.onPanelClosed(paramInt, paramMenu);
      return;
      this.mFragments.dispatchOptionsMenuClosed(paramMenu);
    }
  }

  protected void onPause()
  {
    int i = 2;
    super.onPause();
    this.mResumed = null;
    if (this.mHandler.hasMessages(i))
    {
      this.mHandler.removeMessages(i);
      onResumeFragments();
    }
    this.mFragments.dispatchPause();
  }

  protected void onPostResume()
  {
    super.onPostResume();
    this.mHandler.removeMessages(2);
    onResumeFragments();
    this.mFragments.execPendingActions();
  }

  public boolean onPreparePanel(int paramInt, View paramView, Menu paramMenu)
  {
    Object localObject = null;
    int i;
    if ((paramInt == 0) && (paramMenu != null))
    {
      if (this.mOptionsMenuInvalidated)
      {
        this.mOptionsMenuInvalidated = localObject;
        paramMenu.clear();
        onCreatePanelMenu(paramInt, paramMenu);
      }
      boolean bool2 = super.onPreparePanel(paramInt, paramView, paramMenu);
      boolean bool3 = this.mFragments.dispatchPrepareOptionsMenu(paramMenu);
      if (((bool2 | bool3)) && (paramMenu.hasVisibleItems()))
        i = 1;
    }
    while (true)
    {
      return i;
      boolean bool1 = super.onPreparePanel(paramInt, paramView, paramMenu);
    }
  }

  void onReallyStop()
  {
    if (this.mLoadersStarted)
    {
      this.mLoadersStarted = null;
      if (this.mLoaderManager != null)
      {
        if (this.mRetaining)
          break label41;
        this.mLoaderManager.doStop();
      }
    }
    while (true)
    {
      this.mFragments.dispatchReallyStop();
      return;
      label41: this.mLoaderManager.doRetain();
    }
  }

  protected void onResume()
  {
    super.onResume();
    this.mHandler.sendEmptyMessage(2);
    this.mResumed = true;
    this.mFragments.execPendingActions();
  }

  protected void onResumeFragments()
  {
    this.mFragments.dispatchResume();
  }

  public Object onRetainCustomNonConfigurationInstance()
  {
    return null;
  }

  public final Object onRetainNonConfigurationInstance()
  {
    int i = 0;
    if (this.mStopped)
      doReallyStop(true);
    Object localObject1 = onRetainCustomNonConfigurationInstance();
    ArrayList localArrayList = this.mFragments.retainNonConfig();
    Object localObject2 = null;
    int j;
    if (this.mAllLoaderManagers != null)
    {
      LoaderManagerImpl[] arrayOfLoaderManagerImpl = new LoaderManagerImpl[this.mAllLoaderManagers.size()];
      this.mAllLoaderManagers.values().toArray(arrayOfLoaderManagerImpl);
      if (arrayOfLoaderManagerImpl != null)
      {
        Object localObject3 = null;
        int k = arrayOfLoaderManagerImpl.length;
        if (localObject3 < k)
        {
          LoaderManagerImpl localLoaderManagerImpl = arrayOfLoaderManagerImpl[localObject3];
          if (localLoaderManagerImpl.mRetaining)
            j = 1;
          while (true)
          {
            localObject3++;
            break;
            localLoaderManagerImpl.doDestroy();
            HashMap localHashMap1 = this.mAllLoaderManagers;
            String str = localLoaderManagerImpl.mWho;
            localHashMap1.remove(str);
          }
        }
      }
    }
    Object localObject4;
    if ((localArrayList == null) && (j == null) && (localObject1 == null))
      localObject4 = i;
    while (true)
    {
      return localObject4;
      localObject4 = new NonConfigurationInstances();
      ((NonConfigurationInstances)localObject4).activity = i;
      ((NonConfigurationInstances)localObject4).custom = localObject1;
      ((NonConfigurationInstances)localObject4).children = i;
      ((NonConfigurationInstances)localObject4).fragments = localArrayList;
      HashMap localHashMap2 = this.mAllLoaderManagers;
      ((NonConfigurationInstances)localObject4).loaders = i;
    }
  }

  protected void onSaveInstanceState(Bundle paramBundle)
  {
    super.onSaveInstanceState(paramBundle);
    Parcelable localParcelable = this.mFragments.saveAllState();
    if (localParcelable != null)
      paramBundle.putParcelable("android:support:fragments", localParcelable);
  }

  protected void onStart()
  {
    boolean bool1 = null;
    int i = 1;
    super.onStart();
    this.mStopped = bool1;
    this.mReallyStopped = bool1;
    this.mHandler.removeMessages(i);
    if (!this.mCreated)
    {
      this.mCreated = i;
      this.mFragments.dispatchActivityCreated();
    }
    this.mFragments.noteStateNotSaved();
    this.mFragments.execPendingActions();
    if (!this.mLoadersStarted)
    {
      this.mLoadersStarted = i;
      if (this.mLoaderManager == null)
        break label170;
      this.mLoaderManager.doStart();
    }
    while (true)
    {
      this.mCheckedForLoaderManager = i;
      this.mFragments.dispatchStart();
      if (this.mAllLoaderManagers == null)
        break;
      LoaderManagerImpl[] arrayOfLoaderManagerImpl = new LoaderManagerImpl[this.mAllLoaderManagers.size()];
      this.mAllLoaderManagers.values().toArray(arrayOfLoaderManagerImpl);
      if (arrayOfLoaderManagerImpl == null)
        break;
      Object localObject = null;
      while (true)
      {
        int j = arrayOfLoaderManagerImpl.length;
        if (localObject >= j)
          break;
        LoaderManagerImpl localLoaderManagerImpl1 = arrayOfLoaderManagerImpl[localObject];
        localLoaderManagerImpl1.finishRetain();
        localLoaderManagerImpl1.doReportStart();
        localObject++;
      }
      label170: if (this.mCheckedForLoaderManager)
        continue;
      boolean bool2 = this.mLoadersStarted;
      LoaderManagerImpl localLoaderManagerImpl2 = getLoaderManager(null, bool2, bool1);
      this.mLoaderManager = localLoaderManagerImpl2;
      if ((this.mLoaderManager == null) || (this.mLoaderManager.mStarted))
        continue;
      this.mLoaderManager.doStart();
    }
  }

  protected void onStop()
  {
    super.onStop();
    this.mStopped = true;
    this.mHandler.sendEmptyMessage(1);
    this.mFragments.dispatchStop();
  }

  public void startActivityForResult(Intent paramIntent, int paramInt)
  {
    if ((paramInt != -1) && ((0xFFFF0000 & paramInt) != 0))
      throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
    super.startActivityForResult(paramIntent, paramInt);
  }

  public void startActivityFromFragment(Fragment paramFragment, Intent paramIntent, int paramInt)
  {
    int i = -1;
    if (paramInt == i)
      super.startActivityForResult(paramIntent, i);
    while (true)
    {
      return;
      if ((0xFFFF0000 & paramInt) != 0)
        throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
      int j = paramFragment.mIndex;
      i++;
      int k = j << 16;
      int m = 0xFFFF & paramInt;
      int n = k + m;
      super.startActivityForResult(paramIntent, n);
    }
  }

  public void supportInvalidateOptionsMenu()
  {
    if (Build.VERSION.SDK_INT >= 11)
      ActivityCompatHoneycomb.invalidateOptionsMenu(this);
    while (true)
    {
      return;
      this.mOptionsMenuInvalidated = true;
    }
  }

  class FragmentTag
  {
    public static final int[] Fragment = { 16842755, 16842960, 16842961 };
    public static final int Fragment_id = 1;
    public static final int Fragment_name = 0;
    public static final int Fragment_tag = 2;
  }

  final class NonConfigurationInstances
  {
    Object activity;

    @Signature({"Ljava/util/HashMap", "<", "Ljava/lang/String;", "Ljava/lang/Object;", ">;"})
    HashMap children;
    Object custom;

    @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
    ArrayList fragments;

    @Signature({"Ljava/util/HashMap", "<", "Ljava/lang/String;", "Landroid/support/v4/app/LoaderManagerImpl;", ">;"})
    HashMap loaders;
  }
}