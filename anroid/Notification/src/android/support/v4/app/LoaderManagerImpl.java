package android.support.v4.app;

import Z;
import android.os.Bundle;
import android.support.v4.content.Loader;
import android.support.v4.content.Loader.OnLoadCompleteListener;
import android.support.v4.util.DebugUtils;
import android.support.v4.util.SparseArrayCompat;
import android.util.Log;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.lang.reflect.Modifier;

class LoaderManagerImpl extends LoaderManager
{
  static boolean DEBUG = false;
  static final String TAG = "LoaderManager";
  FragmentActivity mActivity;
  boolean mCreatingLoader;

  @Signature({"Landroid/support/v4/util/SparseArrayCompat", "<", "Landroid/support/v4/app/LoaderManagerImpl$LoaderInfo;", ">;"})
  final SparseArrayCompat mInactiveLoaders;

  @Signature({"Landroid/support/v4/util/SparseArrayCompat", "<", "Landroid/support/v4/app/LoaderManagerImpl$LoaderInfo;", ">;"})
  final SparseArrayCompat mLoaders;
  boolean mRetaining;
  boolean mRetainingStarted;
  boolean mStarted;
  final String mWho;

  static
  {
    boolean bool = DEBUG;
  }

  LoaderManagerImpl(String paramString, FragmentActivity paramFragmentActivity, boolean paramBoolean)
  {
    SparseArrayCompat localSparseArrayCompat1 = new SparseArrayCompat();
    this.mLoaders = localSparseArrayCompat1;
    SparseArrayCompat localSparseArrayCompat2 = new SparseArrayCompat();
    this.mInactiveLoaders = localSparseArrayCompat2;
    this.mWho = paramString;
    this.mActivity = paramFragmentActivity;
    this.mStarted = paramBoolean;
  }

  @Signature({"(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<", "Ljava/lang/Object;", ">;)", "Landroid/support/v4/app/LoaderManagerImpl$LoaderInfo;"})
  private LoaderInfo createAndInstallLoader(int paramInt, Bundle paramBundle, LoaderManager.LoaderCallbacks paramLoaderCallbacks)
  {
    Object localObject1 = null;
    boolean bool = true;
    try
    {
      this.mCreatingLoader = bool;
      LoaderInfo localLoaderInfo = createLoader(paramInt, paramBundle, paramLoaderCallbacks);
      installLoader(localLoaderInfo);
      return localLoaderInfo;
    }
    finally
    {
      this.mCreatingLoader = localObject1;
    }
    throw localObject2;
  }

  @Signature({"(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<", "Ljava/lang/Object;", ">;)", "Landroid/support/v4/app/LoaderManagerImpl$LoaderInfo;"})
  private LoaderInfo createLoader(int paramInt, Bundle paramBundle, LoaderManager.LoaderCallbacks paramLoaderCallbacks)
  {
    LoaderInfo localLoaderInfo = new LoaderInfo(paramInt, paramBundle, paramLoaderCallbacks);
    Loader localLoader = paramLoaderCallbacks.onCreateLoader(paramInt, paramBundle);
    localLoaderInfo.mLoader = localLoader;
    return localLoaderInfo;
  }

  public void destroyLoader(int paramInt)
  {
    boolean bool = this.mCreatingLoader;
    if (bool)
      throw new IllegalStateException("Called while creating a loader");
    DEBUG = bool;
    if (bool)
    {
      String str = "destroyLoader in " + this + " of " + paramInt;
      Log.v("LoaderManager", str);
    }
    int i = this.mLoaders.indexOfKey(paramInt);
    if (i >= 0)
    {
      LoaderInfo localLoaderInfo1 = (LoaderInfo)this.mLoaders.valueAt(i);
      this.mLoaders.removeAt(i);
      localLoaderInfo1.destroy();
    }
    i = this.mInactiveLoaders.indexOfKey(paramInt);
    if (i >= 0)
    {
      LoaderInfo localLoaderInfo2 = (LoaderInfo)this.mInactiveLoaders.valueAt(i);
      this.mInactiveLoaders.removeAt(i);
      localLoaderInfo2.destroy();
    }
    if ((this.mActivity != null) && (!hasRunningLoaders()))
      this.mActivity.mFragments.startPendingDeferredFragments();
  }

  void doDestroy()
  {
    boolean bool = this.mRetaining;
    Object localObject;
    if (!bool)
    {
      DEBUG = bool;
      if (bool)
      {
        localObject = "LoaderManager";
        String str1 = "Destroying Active in " + this;
        Log.v((String)localObject, str1);
      }
      localObject = this.mLoaders.size();
      for (i = localObject + -1; i >= 0; i--)
      {
        localObject = (LoaderInfo)this.mLoaders.valueAt(i);
        ((LoaderInfo)localObject).destroy();
      }
    }
    DEBUG = localObject;
    if (localObject != 0)
    {
      String str2 = "Destroying Inactive in " + this;
      Log.v("LoaderManager", str2);
    }
    for (int i = this.mInactiveLoaders.size() + -1; i >= 0; i--)
      ((LoaderInfo)this.mInactiveLoaders.valueAt(i)).destroy();
    this.mInactiveLoaders.clear();
  }

  void doReportNextStart()
  {
    for (int i = this.mLoaders.size() + -1; i >= 0; i--)
      ((LoaderInfo)this.mLoaders.valueAt(i)).mReportNextStart = true;
  }

  void doReportStart()
  {
    for (int i = this.mLoaders.size() + -1; i >= 0; i--)
      ((LoaderInfo)this.mLoaders.valueAt(i)).reportStart();
  }

  void doRetain()
  {
    boolean bool;
    DEBUG = bool;
    if (bool)
    {
      String str1 = "Retaining in " + this;
      Log.v("LoaderManager", str1);
    }
    if (!this.mStarted)
    {
      RuntimeException localRuntimeException = new RuntimeException("here");
      localRuntimeException.fillInStackTrace();
      String str2 = "Called doRetain when not started: " + this;
      Log.w("LoaderManager", str2, localRuntimeException);
    }
    while (true)
    {
      return;
      this.mRetaining = true;
      this.mStarted = null;
      for (int i = this.mLoaders.size() + -1; i >= 0; i--)
        ((LoaderInfo)this.mLoaders.valueAt(i)).retain();
    }
  }

  void doStart()
  {
    boolean bool;
    DEBUG = bool;
    if (bool)
    {
      String str1 = "Starting in " + this;
      Log.v("LoaderManager", str1);
    }
    if (this.mStarted)
    {
      RuntimeException localRuntimeException = new RuntimeException("here");
      localRuntimeException.fillInStackTrace();
      String str2 = "Called doStart when already started: " + this;
      Log.w("LoaderManager", str2, localRuntimeException);
    }
    while (true)
    {
      return;
      this.mStarted = true;
      for (int i = this.mLoaders.size() + -1; i >= 0; i--)
        ((LoaderInfo)this.mLoaders.valueAt(i)).start();
    }
  }

  void doStop()
  {
    boolean bool;
    DEBUG = bool;
    if (bool)
    {
      String str1 = "Stopping in " + this;
      Log.v("LoaderManager", str1);
    }
    if (!this.mStarted)
    {
      RuntimeException localRuntimeException = new RuntimeException("here");
      localRuntimeException.fillInStackTrace();
      String str2 = "Called doStop when not started: " + this;
      Log.w("LoaderManager", str2, localRuntimeException);
    }
    while (true)
    {
      return;
      for (int i = this.mLoaders.size() + -1; i >= 0; i--)
        ((LoaderInfo)this.mLoaders.valueAt(i)).stop();
      this.mStarted = null;
    }
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    String str1;
    int i;
    if (this.mLoaders.size() > 0)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.println("Active Loaders:");
      str1 = paramString + "    ";
      for (i = 0; ; i++)
      {
        int j = this.mLoaders.size();
        if (i >= j)
          break;
        LoaderInfo localLoaderInfo1 = (LoaderInfo)this.mLoaders.valueAt(i);
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("  #");
        int k = this.mLoaders.keyAt(i);
        paramPrintWriter.print(k);
        paramPrintWriter.print(": ");
        String str2 = localLoaderInfo1.toString();
        paramPrintWriter.println(str2);
        localLoaderInfo1.dump(str1, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
      }
    }
    if (this.mInactiveLoaders.size() > 0)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.println("Inactive Loaders:");
      str1 = paramString + "    ";
      for (i = null; ; i++)
      {
        int m = this.mInactiveLoaders.size();
        if (i >= m)
          break;
        LoaderInfo localLoaderInfo2 = (LoaderInfo)this.mInactiveLoaders.valueAt(i);
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("  #");
        int n = this.mInactiveLoaders.keyAt(i);
        paramPrintWriter.print(n);
        paramPrintWriter.print(": ");
        String str3 = localLoaderInfo2.toString();
        paramPrintWriter.println(str3);
        localLoaderInfo2.dump(str1, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
      }
    }
  }

  void finishRetain()
  {
    boolean bool = this.mRetaining;
    if (bool)
    {
      DEBUG = bool;
      if (bool)
      {
        String str = "Finished Retaining in " + this;
        Log.v("LoaderManager", str);
      }
      this.mRetaining = null;
      for (int i = this.mLoaders.size() + -1; i >= 0; i--)
        ((LoaderInfo)this.mLoaders.valueAt(i)).finishRetain();
    }
  }

  @Signature({"<D:", "Ljava/lang/Object;", ">(I)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public Loader getLoader(int paramInt)
  {
    boolean bool = this.mCreatingLoader;
    if (bool)
      throw new IllegalStateException("Called while creating a loader");
    Object localObject = this.mLoaders;
    LoaderInfo localLoaderInfo = (LoaderInfo)((SparseArrayCompat)localObject).get(paramInt);
    if (localLoaderInfo != null)
    {
      localObject = localLoaderInfo.mPendingLoader;
      if (localObject != null)
        localObject = localLoaderInfo.mPendingLoader.mLoader;
    }
    while (true)
    {
      return localObject;
      localObject = localLoaderInfo.mLoader;
      continue;
      int i = 0;
    }
  }

  public boolean hasRunningLoaders()
  {
    Object localObject1 = null;
    SparseArrayCompat localSparseArrayCompat = this.mLoaders;
    int j = localSparseArrayCompat.size();
    int k = 0;
    int i;
    if (k < j)
    {
      LoaderInfo localLoaderInfo = (LoaderInfo)this.mLoaders.valueAt(k);
      boolean bool = localLoaderInfo.mStarted;
      if (bool)
      {
        bool = localLoaderInfo.mDeliveredData;
        if (!bool)
          bool = true;
      }
      while (true)
      {
        i = localObject1 | bool;
        k++;
        break;
        Object localObject2 = null;
      }
    }
    return i;
  }

  @Signature({"<D:", "Ljava/lang/Object;", ">(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<TD;>;)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public Loader initLoader(int paramInt, Bundle paramBundle, LoaderManager.LoaderCallbacks paramLoaderCallbacks)
  {
    boolean bool = this.mCreatingLoader;
    if (bool)
      throw new IllegalStateException("Called while creating a loader");
    Object localObject1 = this.mLoaders;
    LoaderInfo localLoaderInfo = (LoaderInfo)((SparseArrayCompat)localObject1).get(paramInt);
    DEBUG = (Z)localObject1;
    if (localObject1 != null)
    {
      localObject1 = "LoaderManager";
      String str1 = "initLoader in " + this + ": args=" + paramBundle;
      Log.v((String)localObject1, str1);
    }
    if (localLoaderInfo == null)
    {
      localLoaderInfo = createAndInstallLoader(paramInt, paramBundle, paramLoaderCallbacks);
      DEBUG = (Z)localObject1;
      if (localObject1 != null)
      {
        String str2 = "  Created new loader " + localLoaderInfo;
        Log.v("LoaderManager", str2);
      }
    }
    while (true)
    {
      if ((localLoaderInfo.mHaveData) && (this.mStarted))
      {
        Loader localLoader = localLoaderInfo.mLoader;
        Object localObject2 = localLoaderInfo.mData;
        localLoaderInfo.callOnLoadFinished(localLoader, localObject2);
      }
      return localLoaderInfo.mLoader;
      DEBUG = (Z)localObject1;
      if (localObject1 != null)
      {
        String str3 = "  Re-using existing loader " + localLoaderInfo;
        Log.v("LoaderManager", str3);
      }
      localLoaderInfo.mCallbacks = paramLoaderCallbacks;
    }
  }

  void installLoader(LoaderInfo paramLoaderInfo)
  {
    SparseArrayCompat localSparseArrayCompat = this.mLoaders;
    int i = paramLoaderInfo.mId;
    localSparseArrayCompat.put(i, paramLoaderInfo);
    if (this.mStarted)
      paramLoaderInfo.start();
  }

  @Signature({"<D:", "Ljava/lang/Object;", ">(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<TD;>;)", "Landroid/support/v4/content/Loader", "<TD;>;"})
  public Loader restartLoader(int paramInt, Bundle paramBundle, LoaderManager.LoaderCallbacks paramLoaderCallbacks)
  {
    Object localObject1 = null;
    boolean bool1 = this.mCreatingLoader;
    if (bool1)
      throw new IllegalStateException("Called while creating a loader");
    Object localObject2 = this.mLoaders;
    LoaderInfo localLoaderInfo1 = (LoaderInfo)((SparseArrayCompat)localObject2).get(paramInt);
    DEBUG = (Z)localObject2;
    if (localObject2 != null)
    {
      localObject2 = "LoaderManager";
      String str1 = "restartLoader in " + this + ": args=" + paramBundle;
      Log.v((String)localObject2, str1);
    }
    Object localObject3;
    if (localLoaderInfo1 != null)
    {
      localObject2 = this.mInactiveLoaders;
      LoaderInfo localLoaderInfo2 = (LoaderInfo)((SparseArrayCompat)localObject2).get(paramInt);
      if (localLoaderInfo2 == null)
        break label423;
      boolean bool2 = localLoaderInfo1.mHaveData;
      if (!bool2)
        break label227;
      DEBUG = bool2;
      if (bool2)
      {
        localObject3 = "LoaderManager";
        String str2 = "  Removing last inactive loader: " + localLoaderInfo1;
        Log.v((String)localObject3, str2);
      }
      localLoaderInfo2.mDeliveredData = null;
      localLoaderInfo2.destroy();
      localLoaderInfo1.mLoader.abandon();
      localObject3 = this.mInactiveLoaders;
      ((SparseArrayCompat)localObject3).put(paramInt, localLoaderInfo1);
    }
    while (true)
    {
      for (localObject3 = createAndInstallLoader(paramInt, paramBundle, paramLoaderCallbacks).mLoader; ; localObject4 = localLoaderInfo1.mPendingLoader.mLoader)
      {
        return localObject3;
        label227: boolean bool3 = localLoaderInfo1.mStarted;
        if (!bool3)
        {
          DEBUG = bool3;
          if (bool3)
          {
            localObject4 = "LoaderManager";
            Log.v((String)localObject4, "  Current loader is stopped; replacing");
          }
          localObject4 = this.mLoaders;
          ((SparseArrayCompat)localObject4).put(paramInt, localObject1);
          localLoaderInfo1.destroy();
          break;
        }
        localObject4 = localLoaderInfo1.mPendingLoader;
        if (localObject4 != null)
        {
          DEBUG = (Z)localObject4;
          if (localObject4 != null)
          {
            localObject4 = "LoaderManager";
            StringBuilder localStringBuilder = new StringBuilder().append("  Removing pending loader: ");
            LoaderInfo localLoaderInfo3 = localLoaderInfo1.mPendingLoader;
            String str3 = localLoaderInfo3;
            Log.v((String)localObject4, str3);
          }
          localObject4 = localLoaderInfo1.mPendingLoader;
          ((LoaderInfo)localObject4).destroy();
          localLoaderInfo1.mPendingLoader = localObject1;
        }
        DEBUG = (Z)localObject4;
        if (localObject4 != null)
        {
          localObject4 = "LoaderManager";
          Log.v((String)localObject4, "  Enqueuing as new pending loader");
        }
        localObject4 = createLoader(paramInt, paramBundle, paramLoaderCallbacks);
        localLoaderInfo1.mPendingLoader = ((LoaderInfo)localObject4);
      }
      label423: DEBUG = (Z)localObject4;
      if (localObject4 != null)
      {
        localObject4 = "LoaderManager";
        String str4 = "  Making last loader inactive: " + localLoaderInfo1;
        Log.v((String)localObject4, str4);
      }
      localLoaderInfo1.mLoader.abandon();
      Object localObject4 = this.mInactiveLoaders;
      ((SparseArrayCompat)localObject4).put(paramInt, localLoaderInfo1);
    }
  }

  public String toString()
  {
    StringBuilder localStringBuilder = new StringBuilder(128);
    localStringBuilder.append("LoaderManager{");
    String str = Integer.toHexString(System.identityHashCode(this));
    localStringBuilder.append(str);
    localStringBuilder.append(" in ");
    DebugUtils.buildShortClassTag(this.mActivity, localStringBuilder);
    localStringBuilder.append("}}");
    return localStringBuilder.toString();
  }

  void updateActivity(FragmentActivity paramFragmentActivity)
  {
    this.mActivity = paramFragmentActivity;
  }

  @Signature({"Ljava/lang/Object;", "Landroid/support/v4/content/Loader$OnLoadCompleteListener", "<", "Ljava/lang/Object;", ">;"})
  final class LoaderInfo
    implements Loader.OnLoadCompleteListener
  {
    final Bundle mArgs;

    @Signature({"Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<", "Ljava/lang/Object;", ">;"})
    LoaderManager.LoaderCallbacks mCallbacks;
    Object mData;
    boolean mDeliveredData;
    boolean mDestroyed;
    boolean mHaveData;
    final int mId;
    boolean mListenerRegistered;

    @Signature({"Landroid/support/v4/content/Loader", "<", "Ljava/lang/Object;", ">;"})
    Loader mLoader;
    LoaderInfo mPendingLoader;
    boolean mReportNextStart;
    boolean mRetaining;
    boolean mRetainingStarted;
    boolean mStarted;

    @Signature({"(I", "Landroid/os/Bundle;", "Landroid/support/v4/app/LoaderManager$LoaderCallbacks", "<", "Ljava/lang/Object;", ">;)V"})
    public LoaderInfo(int paramBundle, Bundle paramLoaderCallbacks, LoaderManager.LoaderCallbacks arg4)
    {
      this.mId = paramBundle;
      this.mArgs = paramLoaderCallbacks;
      Object localObject;
      this.mCallbacks = localObject;
    }

    @Signature({"(", "Landroid/support/v4/content/Loader", "<", "Ljava/lang/Object;", ">;", "Ljava/lang/Object;", ")V"})
    void callOnLoadFinished(Loader paramLoader, Object paramObject)
    {
      Object localObject1 = this.mCallbacks;
      String str1;
      if (localObject1 != null)
      {
        int i = 0;
        localObject1 = LoaderManagerImpl.this.mActivity;
        if (localObject1 != null)
        {
          str1 = LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause;
          localObject1 = LoaderManagerImpl.this.mActivity.mFragments;
          ((FragmentManagerImpl)localObject1).mNoTransactionsBecause = "onLoadFinished";
        }
      }
      try
      {
        LoaderManagerImpl.DEBUG = (Z)localObject1;
        if (localObject1 != null)
        {
          localObject1 = "LoaderManager";
          StringBuilder localStringBuilder = new StringBuilder().append("  onLoadFinished in ").append(paramLoader).append(": ");
          String str2 = paramLoader.dataToString(paramObject);
          String str3 = str2;
          Log.v((String)localObject1, str3);
        }
        localObject1 = this.mCallbacks;
        ((LoaderManager.LoaderCallbacks)localObject1).onLoadFinished(paramLoader, paramObject);
        if (LoaderManagerImpl.this.mActivity != null)
          LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause = str1;
        this.mDeliveredData = true;
        return;
      }
      finally
      {
        if (LoaderManagerImpl.this.mActivity != null)
          LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause = str1;
      }
      throw localObject2;
    }

    void destroy()
    {
      int i = 0;
      Object localObject1 = null;
      boolean bool1;
      LoaderManagerImpl.DEBUG = bool1;
      if (bool1)
      {
        localObject2 = "LoaderManager";
        String str1 = "  Destroying: " + this;
        Log.v((String)localObject2, str1);
      }
      this.mDestroyed = true;
      boolean bool3 = this.mDeliveredData;
      this.mDeliveredData = localObject1;
      Object localObject2 = this.mCallbacks;
      Object localObject3;
      String str3;
      if (localObject2 != null)
      {
        localObject2 = this.mLoader;
        if (localObject2 != null)
        {
          boolean bool2 = this.mHaveData;
          if ((bool2) && (bool3))
          {
            LoaderManagerImpl.DEBUG = bool2;
            if (bool2)
            {
              localObject3 = "LoaderManager";
              String str2 = "  Reseting: " + this;
              Log.v((String)localObject3, str2);
            }
            int j = null;
            localObject3 = LoaderManagerImpl.this.mActivity;
            if (localObject3 != null)
            {
              str3 = LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause;
              localObject3 = LoaderManagerImpl.this.mActivity.mFragments;
              ((FragmentManagerImpl)localObject3).mNoTransactionsBecause = "onLoaderReset";
            }
          }
        }
      }
      try
      {
        localObject3 = this.mCallbacks;
        Loader localLoader = this.mLoader;
        ((LoaderManager.LoaderCallbacks)localObject3).onLoaderReset(localLoader);
        if (LoaderManagerImpl.this.mActivity != null)
          LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause = str3;
        this.mCallbacks = i;
        this.mData = i;
        this.mHaveData = localObject1;
        if (this.mLoader != null)
        {
          if (this.mListenerRegistered)
          {
            this.mListenerRegistered = localObject1;
            this.mLoader.unregisterListener(this);
          }
          this.mLoader.reset();
        }
        if (this.mPendingLoader != null)
          this.mPendingLoader.destroy();
        return;
      }
      finally
      {
        if (LoaderManagerImpl.this.mActivity != null)
          LoaderManagerImpl.this.mActivity.mFragments.mNoTransactionsBecause = str3;
      }
      throw localObject4;
    }

    public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mId=");
      int i = this.mId;
      paramPrintWriter.print(i);
      paramPrintWriter.print(" mArgs=");
      Bundle localBundle = this.mArgs;
      paramPrintWriter.println(localBundle);
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mCallbacks=");
      LoaderManager.LoaderCallbacks localLoaderCallbacks = this.mCallbacks;
      paramPrintWriter.println(localLoaderCallbacks);
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mLoader=");
      Loader localLoader1 = this.mLoader;
      paramPrintWriter.println(localLoader1);
      if (this.mLoader != null)
      {
        Loader localLoader2 = this.mLoader;
        String str1 = paramString + "  ";
        localLoader2.dump(str1, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
      }
      if ((this.mHaveData) || (this.mDeliveredData))
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mHaveData=");
        boolean bool1 = this.mHaveData;
        paramPrintWriter.print(bool1);
        paramPrintWriter.print("  mDeliveredData=");
        boolean bool2 = this.mDeliveredData;
        paramPrintWriter.println(bool2);
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mData=");
        Object localObject = this.mData;
        paramPrintWriter.println(localObject);
      }
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mStarted=");
      boolean bool3 = this.mStarted;
      paramPrintWriter.print(bool3);
      paramPrintWriter.print(" mReportNextStart=");
      boolean bool4 = this.mReportNextStart;
      paramPrintWriter.print(bool4);
      paramPrintWriter.print(" mDestroyed=");
      boolean bool5 = this.mDestroyed;
      paramPrintWriter.println(bool5);
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mRetaining=");
      boolean bool6 = this.mRetaining;
      paramPrintWriter.print(bool6);
      paramPrintWriter.print(" mRetainingStarted=");
      boolean bool7 = this.mRetainingStarted;
      paramPrintWriter.print(bool7);
      paramPrintWriter.print(" mListenerRegistered=");
      boolean bool8 = this.mListenerRegistered;
      paramPrintWriter.println(bool8);
      if (this.mPendingLoader != null)
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.println("Pending Loader ");
        LoaderInfo localLoaderInfo1 = this.mPendingLoader;
        paramPrintWriter.print(localLoaderInfo1);
        paramPrintWriter.println(":");
        LoaderInfo localLoaderInfo2 = this.mPendingLoader;
        String str2 = paramString + "  ";
        localLoaderInfo2.dump(str2, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
      }
    }

    void finishRetain()
    {
      boolean bool1 = this.mRetaining;
      if (bool1)
      {
        LoaderManagerImpl.DEBUG = bool1;
        if (bool1)
        {
          String str = "  Finished Retaining: " + this;
          Log.v("LoaderManager", str);
        }
        this.mRetaining = null;
        boolean bool2 = this.mStarted;
        boolean bool3 = this.mRetainingStarted;
        if ((bool2 != bool3) && (!this.mStarted))
          stop();
      }
      if ((this.mStarted) && (this.mHaveData) && (!this.mReportNextStart))
      {
        Loader localLoader = this.mLoader;
        Object localObject = this.mData;
        callOnLoadFinished(localLoader, localObject);
      }
    }

    @Signature({"(", "Landroid/support/v4/content/Loader", "<", "Ljava/lang/Object;", ">;", "Ljava/lang/Object;", ")V"})
    public void onLoadComplete(Loader paramLoader, Object paramObject)
    {
      Object localObject1 = null;
      boolean bool1;
      LoaderManagerImpl.DEBUG = bool1;
      if (bool1)
      {
        String str1 = "LoaderManager";
        String str2 = "onLoadComplete: " + this;
        Log.v(str1, str2);
      }
      boolean bool2 = this.mDestroyed;
      if (bool2)
      {
        LoaderManagerImpl.DEBUG = bool2;
        if (bool2)
          Log.v("LoaderManager", "  Ignoring load complete -- destroyed");
      }
      while (true)
      {
        return;
        Object localObject2 = LoaderManagerImpl.this.mLoaders;
        int i = this.mId;
        localObject2 = ((SparseArrayCompat)localObject2).get(i);
        if (localObject2 != this)
        {
          LoaderManagerImpl.DEBUG = (Z)localObject2;
          if (localObject2 == null)
            continue;
          Log.v("LoaderManager", "  Ignoring load complete -- not active");
          continue;
        }
        LoaderInfo localLoaderInfo1 = this.mPendingLoader;
        if (localLoaderInfo1 != null)
        {
          LoaderManagerImpl.DEBUG = (Z)localObject2;
          if (localObject2 != null)
          {
            String str3 = "  Switching to pending loader: " + localLoaderInfo1;
            Log.v("LoaderManager", str3);
          }
          this.mPendingLoader = localObject1;
          SparseArrayCompat localSparseArrayCompat1 = LoaderManagerImpl.this.mLoaders;
          int j = this.mId;
          localSparseArrayCompat1.put(j, localObject1);
          destroy();
          LoaderManagerImpl.this.installLoader(localLoaderInfo1);
          continue;
        }
        if ((this.mData != paramObject) || (!this.mHaveData))
        {
          this.mData = paramObject;
          this.mHaveData = true;
          if (this.mStarted)
            callOnLoadFinished(paramLoader, paramObject);
        }
        SparseArrayCompat localSparseArrayCompat2 = LoaderManagerImpl.this.mInactiveLoaders;
        int k = this.mId;
        LoaderInfo localLoaderInfo2 = (LoaderInfo)localSparseArrayCompat2.get(k);
        if ((localLoaderInfo2 != null) && (localLoaderInfo2 != this))
        {
          localLoaderInfo2.mDeliveredData = null;
          localLoaderInfo2.destroy();
          SparseArrayCompat localSparseArrayCompat3 = LoaderManagerImpl.this.mInactiveLoaders;
          int m = this.mId;
          localSparseArrayCompat3.remove(m);
        }
        if ((LoaderManagerImpl.this.mActivity == null) || (LoaderManagerImpl.this.hasRunningLoaders()))
          continue;
        LoaderManagerImpl.this.mActivity.mFragments.startPendingDeferredFragments();
      }
    }

    void reportStart()
    {
      if ((this.mStarted) && (this.mReportNextStart))
      {
        this.mReportNextStart = null;
        if (this.mHaveData)
        {
          Loader localLoader = this.mLoader;
          Object localObject = this.mData;
          callOnLoadFinished(localLoader, localObject);
        }
      }
    }

    void retain()
    {
      boolean bool1;
      LoaderManagerImpl.DEBUG = bool1;
      if (bool1)
      {
        String str = "  Retaining: " + this;
        Log.v("LoaderManager", str);
      }
      this.mRetaining = true;
      boolean bool2 = this.mStarted;
      this.mRetainingStarted = bool2;
      this.mStarted = null;
      this.mCallbacks = null;
    }

    void start()
    {
      boolean bool1 = true;
      boolean bool2 = this.mRetaining;
      if (bool2)
      {
        bool2 = this.mRetainingStarted;
        if (bool2)
          this.mStarted = bool1;
      }
      while (true)
      {
        return;
        bool2 = this.mStarted;
        if (bool2)
          continue;
        this.mStarted = bool1;
        LoaderManagerImpl.DEBUG = bool2;
        if (bool2)
        {
          String str1 = "  Starting: " + this;
          Log.v("LoaderManager", str1);
        }
        if ((this.mLoader == null) && (this.mCallbacks != null))
        {
          LoaderManager.LoaderCallbacks localLoaderCallbacks = this.mCallbacks;
          int i = this.mId;
          Bundle localBundle = this.mArgs;
          Loader localLoader1 = localLoaderCallbacks.onCreateLoader(i, localBundle);
          this.mLoader = localLoader1;
        }
        if (this.mLoader == null)
          continue;
        if ((this.mLoader.getClass().isMemberClass()) && (!Modifier.isStatic(this.mLoader.getClass().getModifiers())))
        {
          StringBuilder localStringBuilder = new StringBuilder().append("Object returned from onCreateLoader must not be a non-static inner member class: ");
          Loader localLoader2 = this.mLoader;
          String str2 = localLoader2;
          throw new IllegalArgumentException(str2);
        }
        if (!this.mListenerRegistered)
        {
          Loader localLoader3 = this.mLoader;
          int j = this.mId;
          localLoader3.registerListener(j, this);
          this.mListenerRegistered = bool1;
        }
        this.mLoader.startLoading();
      }
    }

    void stop()
    {
      Object localObject = null;
      boolean bool;
      LoaderManagerImpl.DEBUG = bool;
      if (bool)
      {
        String str = "  Stopping: " + this;
        Log.v("LoaderManager", str);
      }
      this.mStarted = localObject;
      if ((!this.mRetaining) && (this.mLoader != null) && (this.mListenerRegistered))
      {
        this.mListenerRegistered = localObject;
        this.mLoader.unregisterListener(this);
        this.mLoader.stopLoading();
      }
    }

    public String toString()
    {
      StringBuilder localStringBuilder = new StringBuilder(64);
      localStringBuilder.append("LoaderInfo{");
      String str = Integer.toHexString(System.identityHashCode(this));
      localStringBuilder.append(str);
      localStringBuilder.append(" #");
      int i = this.mId;
      localStringBuilder.append(i);
      localStringBuilder.append(" : ");
      DebugUtils.buildShortClassTag(this.mLoader, localStringBuilder);
      localStringBuilder.append("}}");
      return localStringBuilder.toString();
    }
  }
}