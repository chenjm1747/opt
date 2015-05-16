package android.support.v4.app;

import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import dalvik.annotation.EnclosingMethod;

@EnclosingMethod
class FragmentManagerImpl$5
  implements Animation.AnimationListener
{
  public void onAnimationEnd(Animation paramAnimation)
  {
    int i = null;
    if (this.val$fragment.mAnimatingAway != null)
    {
      this.val$fragment.mAnimatingAway = null;
      FragmentManagerImpl localFragmentManagerImpl = this.this$0;
      Fragment localFragment = this.val$fragment;
      int j = this.val$fragment.mStateAfterAnimating;
      int k = i;
      int m = i;
      localFragmentManagerImpl.moveToState(localFragment, j, i, k, m);
    }
  }

  public void onAnimationRepeat(Animation paramAnimation)
  {
  }

  public void onAnimationStart(Animation paramAnimation)
  {
  }
}