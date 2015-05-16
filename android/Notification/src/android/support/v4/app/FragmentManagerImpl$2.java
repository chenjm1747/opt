package android.support.v4.app;

import android.os.Handler;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class FragmentManagerImpl$2
  implements Runnable
{
  public void run()
  {
    FragmentManagerImpl localFragmentManagerImpl = this.this$0;
    Handler localHandler = this.this$0.mActivity.mHandler;
    localFragmentManagerImpl.popBackStackState(localHandler, null, -1, 0);
  }
}