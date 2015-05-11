package android.support.v4.app;

import android.os.Handler;
import android.os.Message;

class FragmentActivity$1 extends Handler
{
  public void handleMessage(Message paramMessage)
  {
    switch (paramMessage.what)
    {
    default:
      super.handleMessage(paramMessage);
    case 1:
    case 2:
    }
    while (true)
    {
      return;
      if (!this.this$0.mStopped)
        continue;
      this.this$0.doReallyStop(null);
      continue;
      this.this$0.onResumeFragments();
      this.this$0.mFragments.execPendingActions();
    }
  }
}