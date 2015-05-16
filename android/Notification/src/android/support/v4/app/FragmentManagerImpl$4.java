package android.support.v4.app;

import android.os.Handler;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class FragmentManagerImpl$4
  implements Runnable
{
  public void run()
  {
    FragmentManagerImpl localFragmentManagerImpl = this.this$0;
    Handler localHandler = this.this$0.mActivity.mHandler;
    int i = this.val$id;
    int j = this.val$flags;
    localFragmentManagerImpl.popBackStackState(localHandler, null, i, j);
  }
}