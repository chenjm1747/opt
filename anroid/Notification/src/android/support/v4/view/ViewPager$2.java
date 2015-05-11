package android.support.v4.view;

import android.view.animation.Interpolator;

final class ViewPager$2
  implements Interpolator
{
  public float getInterpolation(float paramFloat)
  {
    float f = paramFloat - 1065353216;
    return paramFloat * paramFloat * paramFloat * paramFloat * paramFloat + 1065353216;
  }
}