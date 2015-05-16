package android.support.v4.content;

import android.os.Handler;
import android.os.Message;
import dalvik.annotation.Signature;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.concurrent.FutureTask;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicBoolean;

@Signature({"<Params:", "Ljava/lang/Object;", "Progress:", "Ljava/lang/Object;", "Result:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
abstract class ModernAsyncTask
{
  private static final int CORE_POOL_SIZE = 5;
  private static final int KEEP_ALIVE = 1;
  private static final String LOG_TAG = "AsyncTask";
  private static final int MAXIMUM_POOL_SIZE = 128;
  private static final int MESSAGE_POST_PROGRESS = 2;
  private static final int MESSAGE_POST_RESULT = 1;
  public static final Executor THREAD_POOL_EXECUTOR;
  private static volatile Executor sDefaultExecutor;
  private static final InternalHandler sHandler;

  @Signature({"Ljava/util/concurrent/BlockingQueue", "<", "Ljava/lang/Runnable;", ">;"})
  private static final BlockingQueue sPoolWorkQueue;
  private static final ThreadFactory sThreadFactory = new ModernAsyncTask.1();

  @Signature({"Ljava/util/concurrent/FutureTask", "<TResult;>;"})
  private final FutureTask mFuture;
  private volatile Status mStatus;
  private final AtomicBoolean mTaskInvoked;

  @Signature({"Landroid/support/v4/content/ModernAsyncTask$WorkerRunnable", "<TParams;TResult;>;"})
  private final WorkerRunnable mWorker;

  static
  {
    sPoolWorkQueue = new LinkedBlockingQueue(10);
    TimeUnit localTimeUnit = TimeUnit.SECONDS;
    BlockingQueue localBlockingQueue = sPoolWorkQueue;
    ThreadFactory localThreadFactory = sThreadFactory;
    THREAD_POOL_EXECUTOR = new ThreadPoolExecutor(5, 128, 1L, localTimeUnit, localBlockingQueue, localThreadFactory);
    sHandler = new InternalHandler();
    sDefaultExecutor = THREAD_POOL_EXECUTOR;
  }

  public ModernAsyncTask()
  {
    Status localStatus = Status.PENDING;
    this.mStatus = localStatus;
    AtomicBoolean localAtomicBoolean = new AtomicBoolean();
    this.mTaskInvoked = localAtomicBoolean;
    ModernAsyncTask.2 local2 = new ModernAsyncTask.2(this);
    this.mWorker = local2;
    WorkerRunnable localWorkerRunnable = this.mWorker;
    ModernAsyncTask.3 local3 = new ModernAsyncTask.3(this, localWorkerRunnable);
    this.mFuture = local3;
  }

  public static void execute(Runnable paramRunnable)
  {
    sDefaultExecutor.execute(paramRunnable);
  }

  @Signature({"(TResult;)V"})
  private void finish(Object paramObject)
  {
    if (isCancelled())
      onCancelled(paramObject);
    while (true)
    {
      Status localStatus = Status.FINISHED;
      this.mStatus = localStatus;
      return;
      onPostExecute(paramObject);
    }
  }

  public static void init()
  {
    sHandler.getLooper();
  }

  @Signature({"(TResult;)TResult;"})
  private Object postResult(Object paramObject)
  {
    InternalHandler localInternalHandler = sHandler;
    Object[] arrayOfObject = new Object[1];
    arrayOfObject[0] = paramObject;
    AsyncTaskResult localAsyncTaskResult = new AsyncTaskResult(arrayOfObject);
    localInternalHandler.obtainMessage(1, localAsyncTaskResult).sendToTarget();
    return paramObject;
  }

  @Signature({"(TResult;)V"})
  private void postResultIfNotInvoked(Object paramObject)
  {
    if (!this.mTaskInvoked.get())
      postResult(paramObject);
  }

  public static void setDefaultExecutor(Executor paramExecutor)
  {
    sDefaultExecutor = paramExecutor;
  }

  public final boolean cancel(boolean paramBoolean)
  {
    return this.mFuture.cancel(paramBoolean);
  }

  @Signature({"([TParams;)TResult;"})
  protected abstract Object doInBackground(Object[] paramArrayOfObject);

  @Signature({"([TParams;)", "Landroid/support/v4/content/ModernAsyncTask", "<TParams;TProgress;TResult;>;"})
  public final ModernAsyncTask execute(Object[] paramArrayOfObject)
  {
    Executor localExecutor = sDefaultExecutor;
    return executeOnExecutor(localExecutor, paramArrayOfObject);
  }

  @Signature({"(", "Ljava/util/concurrent/Executor;", "[TParams;)", "Landroid/support/v4/content/ModernAsyncTask", "<TParams;TProgress;TResult;>;"})
  public final ModernAsyncTask executeOnExecutor(Executor paramExecutor, Object[] paramArrayOfObject)
  {
    Status localStatus1 = this.mStatus;
    Status localStatus2 = Status.PENDING;
    int[] arrayOfInt;
    int i;
    if (localStatus1 != localStatus2)
    {
      arrayOfInt = 4.$SwitchMap$android$support$v4$content$ModernAsyncTask$Status;
      i = this.mStatus.ordinal();
    }
    switch (arrayOfInt[i])
    {
    default:
      Status localStatus3 = Status.RUNNING;
      this.mStatus = localStatus3;
      onPreExecute();
      this.mWorker.mParams = paramArrayOfObject;
      FutureTask localFutureTask = this.mFuture;
      paramExecutor.execute(localFutureTask);
      return this;
    case 1:
      throw new IllegalStateException("Cannot execute task: the task is already running.");
    case 2:
    }
    throw new IllegalStateException("Cannot execute task: the task has already been executed (a task can be executed only once)");
  }

  @Signature({"()TResult;"})
  public final Object get()
    throws InterruptedException, ExecutionException
  {
    return this.mFuture.get();
  }

  @Signature({"(J", "Ljava/util/concurrent/TimeUnit;", ")TResult;"})
  public final Object get(long paramLong, TimeUnit paramTimeUnit)
    throws InterruptedException, ExecutionException, TimeoutException
  {
    TimeUnit paramTimeUnit;
    return this.mFuture.get(paramLong, ???);
  }

  public final Status getStatus()
  {
    return this.mStatus;
  }

  public final boolean isCancelled()
  {
    return this.mFuture.isCancelled();
  }

  protected void onCancelled()
  {
  }

  @Signature({"(TResult;)V"})
  protected void onCancelled(Object paramObject)
  {
    onCancelled();
  }

  @Signature({"(TResult;)V"})
  protected void onPostExecute(Object paramObject)
  {
  }

  protected void onPreExecute()
  {
  }

  @Signature({"([TProgress;)V"})
  protected void onProgressUpdate(Object[] paramArrayOfObject)
  {
  }

  @Signature({"([TProgress;)V"})
  protected final void publishProgress(Object[] paramArrayOfObject)
  {
    if (!isCancelled())
    {
      InternalHandler localInternalHandler = sHandler;
      AsyncTaskResult localAsyncTaskResult = new AsyncTaskResult(paramArrayOfObject);
      localInternalHandler.obtainMessage(2, localAsyncTaskResult).sendToTarget();
    }
  }

  @Signature({"<Data:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;"})
  class AsyncTaskResult
  {

    @Signature({"[TData;"})
    final Object[] mData;

    @Signature({"(", "Landroid/support/v4/content/ModernAsyncTask;", "[TData;)V"})
    AsyncTaskResult(Object[] arg2)
    {
      Object localObject;
      this.mData = localObject;
    }
  }

  @Signature({"<Params:", "Ljava/lang/Object;", "Result:", "Ljava/lang/Object;", ">", "Ljava/lang/Object;", "Ljava/util/concurrent/Callable", "<TResult;>;"})
  abstract class WorkerRunnable
    implements Callable
  {

    @Signature({"[TParams;"})
    Object[] mParams;
  }

  class InternalHandler extends Handler
  {
    public void handleMessage(Message paramMessage)
    {
      ModernAsyncTask.AsyncTaskResult localAsyncTaskResult = (ModernAsyncTask.AsyncTaskResult)paramMessage.obj;
      switch (paramMessage.what)
      {
      default:
      case 1:
      case 2:
      }
      while (true)
      {
        return;
        ModernAsyncTask localModernAsyncTask1 = localAsyncTaskResult.mTask;
        Object localObject = localAsyncTaskResult.mData[null];
        localModernAsyncTask1.finish(localObject);
        continue;
        ModernAsyncTask localModernAsyncTask2 = localAsyncTaskResult.mTask;
        Object[] arrayOfObject = localAsyncTaskResult.mData;
        localModernAsyncTask2.onProgressUpdate(arrayOfObject);
      }
    }
  }

  @Signature({"Ljava/lang/Enum", "<", "Landroid/support/v4/content/ModernAsyncTask$Status;", ">;"})
  public enum Status
  {
    static
    {
      FINISHED = new Status("FINISHED", 2);
      Status[] arrayOfStatus = new Status[3];
      Status localStatus1 = PENDING;
      arrayOfStatus[0] = localStatus1;
      Status localStatus2 = RUNNING;
      arrayOfStatus[1] = localStatus2;
      Status localStatus3 = FINISHED;
      arrayOfStatus[2] = localStatus3;
      $VALUES = arrayOfStatus;
    }
  }
}