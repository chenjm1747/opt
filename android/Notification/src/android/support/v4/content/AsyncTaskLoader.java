package android.support.v4.content;

import android.content.Context;
import android.os.Handler;
import android.os.SystemClock;
import android.support.v4.util.TimeUtils;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executor;

@Signature({"<D:", "Ljava/lang/Object;", ">", "Landroid/support/v4/content/Loader", "<TD;>;"})
public abstract class AsyncTaskLoader extends Loader
{
  static final boolean DEBUG = false;
  static final String TAG = "AsyncTaskLoader";

  @Signature({"Landroid/support/v4/content/AsyncTaskLoader", "<TD;>.", "LoadTask;"})
  volatile LoadTask mCancellingTask;
  Handler mHandler;
  long mLastLoadCompleteTime = 55536L;

  @Signature({"Landroid/support/v4/content/AsyncTaskLoader", "<TD;>.", "LoadTask;"})
  volatile LoadTask mTask;
  long mUpdateThrottle;

  public AsyncTaskLoader(Context paramContext)
  {
    super(paramContext);
  }

  public boolean cancelLoad()
  {
    int i = 0;
    boolean bool = null;
    if (this.mTask != null)
    {
      if (this.mCancellingTask == null)
        break label60;
      if (this.mTask.waiting)
      {
        this.mTask.waiting = bool;
        Handler localHandler1 = this.mHandler;
        LoadTask localLoadTask1 = this.mTask;
        localHandler1.removeCallbacks(localLoadTask1);
      }
      this.mTask = i;
    }
    while (true)
    {
      return bool;
      label60: if (this.mTask.waiting)
      {
        this.mTask.waiting = bool;
        Handler localHandler2 = this.mHandler;
        LoadTask localLoadTask2 = this.mTask;
        localHandler2.removeCallbacks(localLoadTask2);
        this.mTask = i;
        continue;
      }
      bool = this.mTask.cancel(bool);
      if (bool)
      {
        LoadTask localLoadTask3 = this.mTask;
        this.mCancellingTask = localLoadTask3;
      }
      this.mTask = i;
    }
  }

  @Signature({"(", "Landroid/support/v4/content/AsyncTaskLoader", "<TD;>.", "LoadTask;", "TD;)V"})
  void dispatchOnCancelled(LoadTask paramLoadTask, Object paramObject)
  {
    onCanceled(paramObject);
    if (this.mCancellingTask == paramLoadTask)
    {
      long l = SystemClock.uptimeMillis();
      Object localObject;
      this.mLastLoadCompleteTime = localObject;
      this.mCancellingTask = null;
      executePendingTask();
    }
  }

  @Signature({"(", "Landroid/support/v4/content/AsyncTaskLoader", "<TD;>.", "LoadTask;", "TD;)V"})
  void dispatchOnLoadComplete(LoadTask paramLoadTask, Object paramObject)
  {
    if (this.mTask != paramLoadTask)
      dispatchOnCancelled(paramLoadTask, paramObject);
    while (true)
    {
      return;
      if (isAbandoned())
      {
        onCanceled(paramObject);
        continue;
      }
      long l = SystemClock.uptimeMillis();
      Object localObject;
      this.mLastLoadCompleteTime = localObject;
      this.mTask = null;
      deliverResult(paramObject);
    }
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    super.dump(paramString, paramFileDescriptor, paramPrintWriter, paramArrayOfString);
    if (this.mTask != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mTask=");
      LoadTask localLoadTask1 = this.mTask;
      paramPrintWriter.print(localLoadTask1);
      paramPrintWriter.print(" waiting=");
      boolean bool1 = this.mTask.waiting;
      paramPrintWriter.println(bool1);
    }
    if (this.mCancellingTask != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mCancellingTask=");
      LoadTask localLoadTask2 = this.mCancellingTask;
      paramPrintWriter.print(localLoadTask2);
      paramPrintWriter.print(" waiting=");
      boolean bool2 = this.mCancellingTask.waiting;
      paramPrintWriter.println(bool2);
    }
    if (this.mUpdateThrottle != 0L)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mUpdateThrottle=");
      TimeUtils.formatDuration(this.mUpdateThrottle, paramPrintWriter);
      paramPrintWriter.print(" mLastLoadCompleteTime=");
      long l1 = this.mLastLoadCompleteTime;
      long l2 = SystemClock.uptimeMillis();
      Object localObject;
      TimeUtils.formatDuration(l1, localObject, paramPrintWriter);
      paramPrintWriter.println();
    }
  }

  void executePendingTask()
  {
    if ((this.mCancellingTask == null) && (this.mTask != null))
    {
      if (this.mTask.waiting)
      {
        this.mTask.waiting = null;
        Handler localHandler1 = this.mHandler;
        LoadTask localLoadTask1 = this.mTask;
        localHandler1.removeCallbacks(localLoadTask1);
      }
      if (this.mUpdateThrottle <= 0L)
        break label139;
      long l1 = SystemClock.uptimeMillis();
      long l2 = this.mLastLoadCompleteTime;
      long l3 = this.mUpdateThrottle;
      long l4 = l2 + l3;
      Object localObject;
      if (localObject >= l4)
        break label139;
      this.mTask.waiting = true;
      Handler localHandler2 = this.mHandler;
      LoadTask localLoadTask2 = this.mTask;
      long l5 = this.mLastLoadCompleteTime;
      long l6 = this.mUpdateThrottle;
      long l7 = l5 + l6;
      localHandler2.postAtTime(localLoadTask2, l7);
    }
    while (true)
    {
      return;
      label139: LoadTask localLoadTask3 = this.mTask;
      Executor localExecutor = ModernAsyncTask.THREAD_POOL_EXECUTOR;
      Void[] arrayOfVoid = (Void[])null;
      localLoadTask3.executeOnExecutor(localExecutor, arrayOfVoid);
    }
  }

  @Signature({"()TD;"})
  public abstract Object loadInBackground();

  @Signature({"(TD;)V"})
  public void onCanceled(Object paramObject)
  {
  }

  protected void onForceLoad()
  {
    super.onForceLoad();
    cancelLoad();
    LoadTask localLoadTask = new LoadTask();
    this.mTask = localLoadTask;
    executePendingTask();
  }

  @Signature({"()TD;"})
  protected Object onLoadInBackground()
  {
    return loadInBackground();
  }

  public void setUpdateThrottle(long paramLong)
  {
    this.mUpdateThrottle = paramLong;
    if (paramLong != 0L)
    {
      Handler localHandler = new Handler();
      this.mHandler = localHandler;
    }
  }

  public void waitForLoader()
  {
    LoadTask localLoadTask = this.mTask;
    if (localLoadTask != null);
    try
    {
      localLoadTask.done.await();
      label16: return;
    }
    catch (InterruptedException localInterruptedException)
    {
      break label16;
    }
  }

  @Signature({"Landroid/support/v4/content/ModernAsyncTask", "<", "Ljava/lang/Void;", "Ljava/lang/Void;", "TD;>;", "Ljava/lang/Runnable;"})
  final class LoadTask extends ModernAsyncTask
    implements Runnable
  {
    private CountDownLatch done;

    @Signature({"TD;"})
    Object result;
    boolean waiting;

    LoadTask()
    {
      CountDownLatch localCountDownLatch = new CountDownLatch(1);
      this.done = localCountDownLatch;
    }

    @Signature({"([", "Ljava/lang/Void;", ")TD;"})
    protected Object doInBackground(Void[] paramArrayOfVoid)
    {
      Object localObject = AsyncTaskLoader.this.onLoadInBackground();
      this.result = localObject;
      return this.result;
    }

    protected void onCancelled()
    {
      try
      {
        AsyncTaskLoader localAsyncTaskLoader = AsyncTaskLoader.this;
        Object localObject1 = this.result;
        localAsyncTaskLoader.dispatchOnCancelled(this, localObject1);
        return;
      }
      finally
      {
        this.done.countDown();
      }
      throw localObject2;
    }

    @Signature({"(TD;)V"})
    protected void onPostExecute(Object paramObject)
    {
      try
      {
        AsyncTaskLoader.this.dispatchOnLoadComplete(this, paramObject);
        return;
      }
      finally
      {
        this.done.countDown();
      }
      throw localObject;
    }

    public void run()
    {
      this.waiting = null;
      AsyncTaskLoader.this.executePendingTask();
    }
  }
}