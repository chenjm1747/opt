package android.support.v4.content;

import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

final class ModernAsyncTask$1
  implements ThreadFactory
{
  private final AtomicInteger mCount;

  public Thread newThread(Runnable paramRunnable)
  {
    StringBuilder localStringBuilder = new StringBuilder().append("ModernAsyncTask #");
    int i = this.mCount.getAndIncrement();
    String str = i;
    return new Thread(paramRunnable, str);
  }
}