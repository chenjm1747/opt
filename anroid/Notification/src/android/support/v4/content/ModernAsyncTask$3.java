package android.support.v4.content;

import android.util.Log;
import dalvik.annotation.EnclosingMethod;
import dalvik.annotation.Signature;
import java.util.concurrent.Callable;
import java.util.concurrent.CancellationException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

@EnclosingMethod
@Signature({"Ljava/util/concurrent/FutureTask", "<TResult;>;"})
class ModernAsyncTask$3 extends FutureTask
{
  protected void done()
  {
    try
    {
      Object localObject = get();
      ModernAsyncTask.access$400(this.this$0, localObject);
      return;
    }
    catch (InterruptedException localInterruptedException)
    {
      while (true)
        Log.w("AsyncTask", localInterruptedException);
    }
    catch (ExecutionException localExecutionException)
    {
      Throwable localThrowable1 = localExecutionException.getCause();
      throw new RuntimeException("An error occured while executing doInBackground()", localThrowable1);
    }
    catch (CancellationException localCancellationException)
    {
      while (true)
        ModernAsyncTask.access$400(this.this$0, null);
    }
    catch (Throwable localThrowable2)
    {
    }
    throw new RuntimeException("An error occured while executing doInBackground()", localThrowable2);
  }
}