package android.support.v4.widget;

import android.content.Context;
import android.os.Build.VERSION;
import android.widget.Scroller;

class ScrollerCompat
{
  Scroller mScroller;

  ScrollerCompat(Context paramContext)
  {
    Scroller localScroller = new Scroller(paramContext);
    this.mScroller = localScroller;
  }

  public static ScrollerCompat from(Context paramContext)
  {
    int i = Build.VERSION.SDK_INT;
    if (i >= 14);
    for (Object localObject = new ScrollerCompatImplIcs(); ; localObject = new ScrollerCompat(paramContext))
      return localObject;
  }

  public void abortAnimation()
  {
    this.mScroller.abortAnimation();
  }

  public boolean computeScrollOffset()
  {
    return this.mScroller.computeScrollOffset();
  }

  public void fling(int paramInt1, int paramInt2, int paramInt3, int paramInt4, int paramInt5, int paramInt6, int paramInt7, int paramInt8)
  {
    Scroller localScroller = this.mScroller;
    int i = paramInt1;
    int j = paramInt2;
    int k = paramInt3;
    int m = paramInt4;
    int n = paramInt5;
    int i1 = paramInt6;
    int i2 = paramInt7;
    int i3 = paramInt8;
    localScroller.fling(i, j, k, m, n, i1, i2, i3);
  }

  public float getCurrVelocity()
  {
    return null;
  }

  public int getCurrX()
  {
    return this.mScroller.getCurrX();
  }

  public int getCurrY()
  {
    return this.mScroller.getCurrY();
  }

  public int getDuration()
  {
    return this.mScroller.getDuration();
  }

  public boolean isFinished()
  {
    return this.mScroller.isFinished();
  }

  public void startScroll(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    this.mScroller.startScroll(paramInt1, paramInt2, paramInt3, paramInt4);
  }

  public void startScroll(int paramInt1, int paramInt2, int paramInt3, int paramInt4, int paramInt5)
  {
    Scroller localScroller = this.mScroller;
    int i = paramInt1;
    int j = paramInt2;
    int k = paramInt3;
    int m = paramInt4;
    int n = paramInt5;
    localScroller.startScroll(i, j, k, m, n);
  }

  class ScrollerCompatImplIcs extends ScrollerCompat
  {
    public ScrollerCompatImplIcs()
    {
      super();
    }

    public float getCurrVelocity()
    {
      return ScrollerCompatIcs.getCurrVelocity(this.mScroller);
    }
  }
}