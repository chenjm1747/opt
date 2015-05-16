package android.support.v4.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.os.Build.VERSION;

public class EdgeEffectCompat
{
  private static final EdgeEffectImpl IMPL;
  private Object mEdgeEffect;

  static
  {
    if (Build.VERSION.SDK_INT >= 14)
      IMPL = new EdgeEffectIcsImpl();
    while (true)
    {
      return;
      IMPL = new BaseEdgeEffectImpl();
    }
  }

  public EdgeEffectCompat(Context paramContext)
  {
    Object localObject = IMPL.newEdgeEffect(paramContext);
    this.mEdgeEffect = localObject;
  }

  public boolean draw(Canvas paramCanvas)
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    return localEdgeEffectImpl.draw(localObject, paramCanvas);
  }

  public void finish()
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    localEdgeEffectImpl.finish(localObject);
  }

  public boolean isFinished()
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    return localEdgeEffectImpl.isFinished(localObject);
  }

  public boolean onAbsorb(int paramInt)
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    return localEdgeEffectImpl.onAbsorb(localObject, paramInt);
  }

  public boolean onPull(float paramFloat)
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    return localEdgeEffectImpl.onPull(localObject, paramFloat);
  }

  public boolean onRelease()
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    return localEdgeEffectImpl.onRelease(localObject);
  }

  public void setSize(int paramInt1, int paramInt2)
  {
    EdgeEffectImpl localEdgeEffectImpl = IMPL;
    Object localObject = this.mEdgeEffect;
    localEdgeEffectImpl.setSize(localObject, paramInt1, paramInt2);
  }

  class EdgeEffectIcsImpl
    implements EdgeEffectCompat.EdgeEffectImpl
  {
    public boolean draw(Object paramObject, Canvas paramCanvas)
    {
      return EdgeEffectCompatIcs.draw(paramObject, paramCanvas);
    }

    public void finish(Object paramObject)
    {
      EdgeEffectCompatIcs.finish(paramObject);
    }

    public boolean isFinished(Object paramObject)
    {
      return EdgeEffectCompatIcs.isFinished(paramObject);
    }

    public Object newEdgeEffect(Context paramContext)
    {
      return EdgeEffectCompatIcs.newEdgeEffect(paramContext);
    }

    public boolean onAbsorb(Object paramObject, int paramInt)
    {
      return EdgeEffectCompatIcs.onAbsorb(paramObject, paramInt);
    }

    public boolean onPull(Object paramObject, float paramFloat)
    {
      return EdgeEffectCompatIcs.onPull(paramObject, paramFloat);
    }

    public boolean onRelease(Object paramObject)
    {
      return EdgeEffectCompatIcs.onRelease(paramObject);
    }

    public void setSize(Object paramObject, int paramInt1, int paramInt2)
    {
      EdgeEffectCompatIcs.setSize(paramObject, paramInt1, paramInt2);
    }
  }

  class BaseEdgeEffectImpl
    implements EdgeEffectCompat.EdgeEffectImpl
  {
    public boolean draw(Object paramObject, Canvas paramCanvas)
    {
      return null;
    }

    public void finish(Object paramObject)
    {
    }

    public boolean isFinished(Object paramObject)
    {
      return true;
    }

    public Object newEdgeEffect(Context paramContext)
    {
      return null;
    }

    public boolean onAbsorb(Object paramObject, int paramInt)
    {
      return null;
    }

    public boolean onPull(Object paramObject, float paramFloat)
    {
      return null;
    }

    public boolean onRelease(Object paramObject)
    {
      return null;
    }

    public void setSize(Object paramObject, int paramInt1, int paramInt2)
    {
    }
  }

  abstract interface EdgeEffectImpl
  {
    public abstract boolean draw(Object paramObject, Canvas paramCanvas);

    public abstract void finish(Object paramObject);

    public abstract boolean isFinished(Object paramObject);

    public abstract Object newEdgeEffect(Context paramContext);

    public abstract boolean onAbsorb(Object paramObject, int paramInt);

    public abstract boolean onPull(Object paramObject, float paramFloat);

    public abstract boolean onRelease(Object paramObject);

    public abstract void setSize(Object paramObject, int paramInt1, int paramInt2);
  }
}