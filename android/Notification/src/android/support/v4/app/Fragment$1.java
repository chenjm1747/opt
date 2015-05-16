package android.support.v4.app;

import android.view.View;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class Fragment$1
  implements FragmentContainer
{
  public View findViewById(int paramInt)
  {
    if (this.this$0.mView == null)
      throw new IllegalStateException("Fragment does not have a view");
    return this.this$0.mView.findViewById(paramInt);
  }
}