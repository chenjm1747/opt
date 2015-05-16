package android.support.v4.content;

import android.os.Process;
import dalvik.annotation.EnclosingMethod;
import dalvik.annotation.Signature;
import java.util.concurrent.atomic.AtomicBoolean;

@EnclosingMethod
@Signature({"Landroid/support/v4/content/ModernAsyncTask$WorkerRunnable", "<TParams;TResult;>;"})
class ModernAsyncTask$2 extends ModernAsyncTask.WorkerRunnable
{
  @Signature({"()TResult;"})
  public Object call()
    throws Exception
  {
    ModernAsyncTask.access$200(this.this$0).set(true);
    Process.setThreadPriority(10);
    ModernAsyncTask localModernAsyncTask1 = this.this$0;
    ModernAsyncTask localModernAsyncTask2 = this.this$0;
    Object[] arrayOfObject = this.mParams;
    Object localObject = localModernAsyncTask2.doInBackground(arrayOfObject);
    return ModernAsyncTask.access$300(localModernAsyncTask1, localObject);
  }
}