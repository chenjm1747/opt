package android.support.v4.app;

import android.os.Handler;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class FragmentManagerImpl$3
  implements Runnable
{
  public void run()
  {
    FragmentManagerImpl localFragmentManagerImpl = this.this$0;
    Handler localHandler = this.this$0.mActivity.mHandler;
    String str = this.val$name;
    int i = this.val$flags;
    localFragmentManagerImpl.popBackStackState(localHandler, str, -1, i);
  }
}