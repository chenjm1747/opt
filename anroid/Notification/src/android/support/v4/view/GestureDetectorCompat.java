package android.support.v4.view;

import android.content.Context;
import android.os.Build.VERSION;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.view.GestureDetector;
import android.view.GestureDetector.OnDoubleTapListener;
import android.view.GestureDetector.OnGestureListener;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.ViewConfiguration;

public class GestureDetectorCompat
{
  private final GestureDetectorCompatImpl mImpl;

  public GestureDetectorCompat(Context paramContext, GestureDetector.OnGestureListener paramOnGestureListener)
  {
    this(paramContext, paramOnGestureListener, null);
  }

  public GestureDetectorCompat(Context paramContext, GestureDetector.OnGestureListener paramOnGestureListener, Handler paramHandler)
  {
    GestureDetectorCompatImplJellybeanMr1 localGestureDetectorCompatImplJellybeanMr1;
    if (Build.VERSION.SDK_INT >= 17)
      localGestureDetectorCompatImplJellybeanMr1 = new GestureDetectorCompatImplJellybeanMr1(paramOnGestureListener, paramHandler);
    GestureDetectorCompatImplBase localGestureDetectorCompatImplBase;
    for (this.mImpl = localGestureDetectorCompatImplJellybeanMr1; ; this.mImpl = localGestureDetectorCompatImplBase)
    {
      return;
      localGestureDetectorCompatImplBase = new GestureDetectorCompatImplBase(paramOnGestureListener, paramHandler);
    }
  }

  public boolean isLongpressEnabled()
  {
    return this.mImpl.isLongpressEnabled();
  }

  public boolean onTouchEvent(MotionEvent paramMotionEvent)
  {
    return this.mImpl.onTouchEvent(paramMotionEvent);
  }

  public void setIsLongpressEnabled(boolean paramBoolean)
  {
    this.mImpl.setIsLongpressEnabled(paramBoolean);
  }

  public void setOnDoubleTapListener(GestureDetector.OnDoubleTapListener paramOnDoubleTapListener)
  {
    this.mImpl.setOnDoubleTapListener(paramOnDoubleTapListener);
  }

  class GestureDetectorCompatImplJellybeanMr1
    implements GestureDetectorCompat.GestureDetectorCompatImpl
  {
    private final GestureDetector mDetector;

    public GestureDetectorCompatImplJellybeanMr1(GestureDetector.OnGestureListener paramHandler, Handler arg3)
    {
      Handler localHandler;
      GestureDetector localGestureDetector = new GestureDetector(this$1, paramHandler, localHandler);
      this.mDetector = localGestureDetector;
    }

    public boolean isLongpressEnabled()
    {
      return this.mDetector.isLongpressEnabled();
    }

    public boolean onTouchEvent(MotionEvent paramMotionEvent)
    {
      return this.mDetector.onTouchEvent(paramMotionEvent);
    }

    public void setIsLongpressEnabled(boolean paramBoolean)
    {
      this.mDetector.setIsLongpressEnabled(paramBoolean);
    }

    public void setOnDoubleTapListener(GestureDetector.OnDoubleTapListener paramOnDoubleTapListener)
    {
      this.mDetector.setOnDoubleTapListener(paramOnDoubleTapListener);
    }
  }

  class GestureDetectorCompatImplBase
    implements GestureDetectorCompat.GestureDetectorCompatImpl
  {
    private static final int DOUBLE_TAP_TIMEOUT = 0;
    private static final int LONGPRESS_TIMEOUT = 0;
    private static final int LONG_PRESS = 2;
    private static final int SHOW_PRESS = 1;
    private static final int TAP = 3;
    private static final int TAP_TIMEOUT = ViewConfiguration.getTapTimeout();
    private boolean mAlwaysInBiggerTapRegion;
    private boolean mAlwaysInTapRegion;
    private MotionEvent mCurrentDownEvent;
    private GestureDetector.OnDoubleTapListener mDoubleTapListener;
    private int mDoubleTapSlopSquare;
    private float mDownFocusX;
    private float mDownFocusY;
    private final Handler mHandler;
    private boolean mInLongPress;
    private boolean mIsDoubleTapping;
    private boolean mIsLongpressEnabled;
    private float mLastFocusX;
    private float mLastFocusY;
    private final GestureDetector.OnGestureListener mListener;
    private int mMaximumFlingVelocity;
    private int mMinimumFlingVelocity;
    private MotionEvent mPreviousUpEvent;
    private boolean mStillDown;
    private int mTouchSlopSquare;
    private VelocityTracker mVelocityTracker;

    static
    {
      DOUBLE_TAP_TIMEOUT = ViewConfiguration.getDoubleTapTimeout();
    }

    public GestureDetectorCompatImplBase(GestureDetector.OnGestureListener paramHandler, Handler arg3)
    {
      Handler localHandler;
      GestureHandler localGestureHandler1;
      if (localHandler != null)
        localGestureHandler1 = new GestureHandler(localHandler);
      GestureHandler localGestureHandler2;
      for (this.mHandler = localGestureHandler1; ; this.mHandler = localGestureHandler2)
      {
        this.mListener = paramHandler;
        if ((paramHandler instanceof GestureDetector.OnDoubleTapListener))
        {
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener = (GestureDetector.OnDoubleTapListener)paramHandler;
          setOnDoubleTapListener(paramHandler);
        }
        init(this$1);
        return;
        localGestureHandler2 = new GestureHandler();
      }
    }

    private void cancel()
    {
      Object localObject = null;
      this.mHandler.removeMessages(1);
      this.mHandler.removeMessages(2);
      this.mHandler.removeMessages(3);
      this.mVelocityTracker.recycle();
      this.mVelocityTracker = null;
      this.mIsDoubleTapping = localObject;
      this.mStillDown = localObject;
      this.mAlwaysInTapRegion = localObject;
      this.mAlwaysInBiggerTapRegion = localObject;
      if (this.mInLongPress)
        this.mInLongPress = localObject;
    }

    private void cancelTaps()
    {
      Object localObject = null;
      this.mHandler.removeMessages(1);
      this.mHandler.removeMessages(2);
      this.mHandler.removeMessages(3);
      this.mIsDoubleTapping = localObject;
      this.mAlwaysInTapRegion = localObject;
      this.mAlwaysInBiggerTapRegion = localObject;
      if (this.mInLongPress)
        this.mInLongPress = localObject;
    }

    private void dispatchLongPress()
    {
      this.mHandler.removeMessages(3);
      this.mInLongPress = true;
      GestureDetector.OnGestureListener localOnGestureListener = this.mListener;
      MotionEvent localMotionEvent = this.mCurrentDownEvent;
      localOnGestureListener.onLongPress(localMotionEvent);
    }

    private void init(Context paramContext)
    {
      if (paramContext == null)
        throw new IllegalArgumentException("Context must not be null");
      if (this.mListener == null)
        throw new IllegalArgumentException("OnGestureListener must not be null");
      this.mIsLongpressEnabled = true;
      ViewConfiguration localViewConfiguration = ViewConfiguration.get(paramContext);
      int i = localViewConfiguration.getScaledTouchSlop();
      int j = localViewConfiguration.getScaledDoubleTapSlop();
      int k = localViewConfiguration.getScaledMinimumFlingVelocity();
      this.mMinimumFlingVelocity = k;
      int m = localViewConfiguration.getScaledMaximumFlingVelocity();
      this.mMaximumFlingVelocity = m;
      int n = i * i;
      this.mTouchSlopSquare = n;
      int i1 = j * j;
      this.mDoubleTapSlopSquare = i1;
    }

    private boolean isConsideredDoubleTap(MotionEvent paramMotionEvent1, MotionEvent paramMotionEvent2, MotionEvent paramMotionEvent3)
    {
      Object localObject1 = null;
      if (!this.mAlwaysInBiggerTapRegion);
      while (true)
      {
        return localObject1;
        long l1 = paramMotionEvent3.getEventTime();
        long l2 = paramMotionEvent2.getEventTime();
        Object localObject2;
        Object localObject3;
        long l3 = localObject2 - localObject3;
        long l4 = DOUBLE_TAP_TIMEOUT;
        if (l3 > l4)
          continue;
        int j = (int)paramMotionEvent1.getX();
        int k = (int)paramMotionEvent3.getX();
        int m = j - k;
        int n = (int)paramMotionEvent1.getY();
        int i1 = (int)paramMotionEvent3.getY();
        int i2 = n - i1;
        int i3 = m * m;
        int i4 = i2 * i2;
        int i5 = i3 + i4;
        int i6 = this.mDoubleTapSlopSquare;
        if (i5 >= i6)
          continue;
        int i = 1;
      }
    }

    public boolean isLongpressEnabled()
    {
      return this.mIsLongpressEnabled;
    }

    public boolean onTouchEvent(MotionEvent paramMotionEvent)
    {
      int i = paramMotionEvent.getAction();
      if (this.mVelocityTracker == null)
      {
        VelocityTracker localVelocityTracker1 = VelocityTracker.obtain();
        this.mVelocityTracker = localVelocityTracker1;
      }
      VelocityTracker localVelocityTracker2 = this.mVelocityTracker;
      MotionEvent localMotionEvent1 = paramMotionEvent;
      localVelocityTracker2.addMovement(localMotionEvent1);
      int j = i & 0xFF;
      int k = 6;
      int n;
      label69: Object localObject2;
      Object localObject3;
      int i1;
      int i2;
      if (j == k)
      {
        int m = 1;
        if (m == null)
          break label118;
        n = MotionEventCompat.getActionIndex(paramMotionEvent);
        localObject2 = null;
        localObject3 = null;
        i1 = MotionEventCompat.getPointerCount(paramMotionEvent);
        i2 = 0;
        label84: if (i2 >= i1)
          break label174;
        int i3 = n;
        int i4 = i2;
        if (i3 != i4)
          break label125;
      }
      Object localObject1;
      label118: label125: float f1;
      float f2;
      while (true)
      {
        i2++;
        break label84;
        localObject1 = null;
        break;
        n = 65535;
        break label69;
        MotionEvent localMotionEvent2 = paramMotionEvent;
        int i5 = i2;
        float f3 = MotionEventCompat.getX(localMotionEvent2, i5);
        f1 = localObject2 + f3;
        MotionEvent localMotionEvent3 = paramMotionEvent;
        int i6 = i2;
        float f4 = MotionEventCompat.getY(localMotionEvent3, i6);
        f2 = localObject3 + f4;
      }
      label174: int i7;
      float f5;
      float f6;
      Object localObject4;
      if (localObject1 != null)
      {
        i7 = i1 + -1;
        int i8 = i7;
        f5 = f1 / i8;
        int i9 = i7;
        f6 = f2 / i9;
        localObject4 = null;
        switch (i & 0xFF)
        {
        case 4:
        default:
        case 5:
        case 6:
        case 0:
        case 2:
        case 1:
        case 3:
        }
      }
      while (true)
      {
        return localObject4;
        i7 = i1;
        break;
        this.mLastFocusX = f5;
        this.mDownFocusX = f5;
        this.mLastFocusY = f6;
        this.mDownFocusY = f6;
        cancelTaps();
        continue;
        this.mLastFocusX = f5;
        this.mDownFocusX = f5;
        this.mLastFocusY = f6;
        this.mDownFocusY = f6;
        VelocityTracker localVelocityTracker3 = this.mVelocityTracker;
        int i12 = this.mMaximumFlingVelocity;
        localVelocityTracker3.computeCurrentVelocity(1000, i12);
        int i13 = MotionEventCompat.getActionIndex(paramMotionEvent);
        MotionEvent localMotionEvent4 = paramMotionEvent;
        int i14 = i13;
        int i15 = MotionEventCompat.getPointerId(localMotionEvent4, i14);
        VelocityTracker localVelocityTracker4 = this.mVelocityTracker;
        int i16 = i15;
        float f7 = VelocityTrackerCompat.getXVelocity(localVelocityTracker4, i16);
        VelocityTracker localVelocityTracker5 = this.mVelocityTracker;
        int i17 = i15;
        float f8 = VelocityTrackerCompat.getYVelocity(localVelocityTracker5, i17);
        i2 = 0;
        if (i2 >= i1)
          continue;
        int i18 = i2;
        int i19 = i13;
        if (i18 == i19);
        float f10;
        float f12;
        do
        {
          i2++;
          break;
          MotionEvent localMotionEvent5 = paramMotionEvent;
          int i20 = i2;
          int i21 = MotionEventCompat.getPointerId(localMotionEvent5, i20);
          VelocityTracker localVelocityTracker6 = this.mVelocityTracker;
          int i22 = i21;
          float f9 = VelocityTrackerCompat.getXVelocity(localVelocityTracker6, i22);
          f10 = f7 * f9;
          VelocityTracker localVelocityTracker7 = this.mVelocityTracker;
          int i23 = i21;
          float f11 = VelocityTrackerCompat.getYVelocity(localVelocityTracker7, i23);
          f12 = f8 * f11;
        }
        while (f10 + f12 >= null);
        this.mVelocityTracker.clear();
        continue;
        boolean bool1;
        if (this.mDoubleTapListener != null)
        {
          boolean bool3 = this.mHandler.hasMessages(3);
          if (bool3)
            this.mHandler.removeMessages(3);
          if ((this.mCurrentDownEvent == null) || (this.mPreviousUpEvent == null) || (!bool3))
            break label900;
          MotionEvent localMotionEvent6 = this.mCurrentDownEvent;
          MotionEvent localMotionEvent7 = this.mPreviousUpEvent;
          GestureDetectorCompatImplBase localGestureDetectorCompatImplBase = this;
          MotionEvent localMotionEvent8 = localMotionEvent6;
          MotionEvent localMotionEvent9 = localMotionEvent7;
          MotionEvent localMotionEvent10 = paramMotionEvent;
          if (!localGestureDetectorCompatImplBase.isConsideredDoubleTap(localMotionEvent8, localMotionEvent9, localMotionEvent10))
            break label900;
          boolean bool4 = true;
          this.mIsDoubleTapping = bool4;
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener1 = this.mDoubleTapListener;
          MotionEvent localMotionEvent11 = this.mCurrentDownEvent;
          boolean bool5 = localOnDoubleTapListener1.onDoubleTap(localMotionEvent11);
          bool1 = localObject4 | bool5;
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener2 = this.mDoubleTapListener;
          MotionEvent localMotionEvent12 = paramMotionEvent;
          boolean bool6 = localOnDoubleTapListener2.onDoubleTapEvent(localMotionEvent12);
          bool1 |= bool6;
        }
        int i10;
        while (true)
        {
          this.mLastFocusX = f5;
          this.mDownFocusX = f5;
          this.mLastFocusY = f6;
          this.mDownFocusY = f6;
          if (this.mCurrentDownEvent != null)
            this.mCurrentDownEvent.recycle();
          MotionEvent localMotionEvent13 = MotionEvent.obtain(paramMotionEvent);
          this.mCurrentDownEvent = localMotionEvent13;
          boolean bool7 = true;
          this.mAlwaysInTapRegion = bool7;
          boolean bool8 = true;
          this.mAlwaysInBiggerTapRegion = bool8;
          boolean bool9 = true;
          this.mStillDown = bool9;
          Object localObject5 = null;
          this.mInLongPress = localObject5;
          if (this.mIsLongpressEnabled)
          {
            this.mHandler.removeMessages(2);
            Handler localHandler1 = this.mHandler;
            long l1 = this.mCurrentDownEvent.getDownTime();
            long l2 = TAP_TIMEOUT;
            Object localObject6;
            long l3 = localObject6 + l2;
            long l4 = LONGPRESS_TIMEOUT;
            long l5 = l3 + l4;
            localHandler1.sendEmptyMessageAtTime(2, l5);
          }
          Handler localHandler2 = this.mHandler;
          long l6 = this.mCurrentDownEvent.getDownTime();
          long l7 = TAP_TIMEOUT;
          Object localObject7;
          long l8 = localObject7 + l7;
          localHandler2.sendEmptyMessageAtTime(1, l8);
          GestureDetector.OnGestureListener localOnGestureListener1 = this.mListener;
          MotionEvent localMotionEvent14 = paramMotionEvent;
          boolean bool10 = localOnGestureListener1.onDown(localMotionEvent14);
          i10 = bool1 | bool10;
          break;
          label900: Handler localHandler3 = this.mHandler;
          long l9 = DOUBLE_TAP_TIMEOUT;
          localHandler3.sendEmptyMessageDelayed(3, l9);
        }
        if (this.mInLongPress)
          continue;
        float f13 = this.mLastFocusX - f5;
        float f14 = this.mLastFocusY - f6;
        if (this.mIsDoubleTapping)
        {
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener3 = this.mDoubleTapListener;
          MotionEvent localMotionEvent15 = paramMotionEvent;
          boolean bool11 = localOnDoubleTapListener3.onDoubleTapEvent(localMotionEvent15);
          int i11 = i10 | bool11;
          continue;
        }
        if (this.mAlwaysInTapRegion)
        {
          int i24 = this.mDownFocusX;
          int i25 = (int)(f5 - i24);
          int i26 = this.mDownFocusY;
          int i27 = (int)(f6 - i26);
          int i28 = i25 * i25;
          int i29 = i27 * i27;
          int i30 = i28 + i29;
          int i31 = this.mTouchSlopSquare;
          if (i30 > i31)
          {
            GestureDetector.OnGestureListener localOnGestureListener2 = this.mListener;
            MotionEvent localMotionEvent16 = this.mCurrentDownEvent;
            GestureDetector.OnGestureListener localOnGestureListener3 = localOnGestureListener2;
            MotionEvent localMotionEvent17 = localMotionEvent16;
            MotionEvent localMotionEvent18 = paramMotionEvent;
            int i32 = f13;
            int i33 = f14;
            bool2 = localOnGestureListener3.onScroll(localMotionEvent17, localMotionEvent18, i32, i33);
            this.mLastFocusX = f5;
            this.mLastFocusY = f6;
            Object localObject8 = null;
            this.mAlwaysInTapRegion = localObject8;
            this.mHandler.removeMessages(3);
            this.mHandler.removeMessages(1);
            this.mHandler.removeMessages(2);
          }
          int i34 = this.mTouchSlopSquare;
          if (i30 <= i34)
            continue;
          Object localObject9 = null;
          this.mAlwaysInBiggerTapRegion = localObject9;
          continue;
        }
        if ((Math.abs(f13) < 1065353216) && (Math.abs(f14) < 1065353216))
          continue;
        GestureDetector.OnGestureListener localOnGestureListener4 = this.mListener;
        MotionEvent localMotionEvent19 = this.mCurrentDownEvent;
        GestureDetector.OnGestureListener localOnGestureListener5 = localOnGestureListener4;
        MotionEvent localMotionEvent20 = localMotionEvent19;
        MotionEvent localMotionEvent21 = paramMotionEvent;
        int i35 = f13;
        int i36 = f14;
        boolean bool2 = localOnGestureListener5.onScroll(localMotionEvent20, localMotionEvent21, i35, i36);
        this.mLastFocusX = f5;
        this.mLastFocusY = f6;
        continue;
        Object localObject10 = null;
        this.mStillDown = localObject10;
        MotionEvent localMotionEvent22 = MotionEvent.obtain(paramMotionEvent);
        if (this.mIsDoubleTapping)
        {
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener4 = this.mDoubleTapListener;
          MotionEvent localMotionEvent23 = paramMotionEvent;
          boolean bool12 = localOnDoubleTapListener4.onDoubleTapEvent(localMotionEvent23);
          bool2 = bool2 | bool12;
        }
        while (true)
        {
          if (this.mPreviousUpEvent != null)
            this.mPreviousUpEvent.recycle();
          this.mPreviousUpEvent = localMotionEvent22;
          if (this.mVelocityTracker != null)
          {
            this.mVelocityTracker.recycle();
            Object localObject11 = null;
            this.mVelocityTracker = localObject11;
          }
          Object localObject12 = null;
          this.mIsDoubleTapping = localObject12;
          this.mHandler.removeMessages(1);
          this.mHandler.removeMessages(2);
          break;
          if (this.mInLongPress)
          {
            this.mHandler.removeMessages(3);
            Object localObject13 = null;
            this.mInLongPress = localObject13;
            continue;
          }
          if (this.mAlwaysInTapRegion)
          {
            GestureDetector.OnGestureListener localOnGestureListener6 = this.mListener;
            MotionEvent localMotionEvent24 = paramMotionEvent;
            bool2 = localOnGestureListener6.onSingleTapUp(localMotionEvent24);
            continue;
          }
          VelocityTracker localVelocityTracker8 = this.mVelocityTracker;
          MotionEvent localMotionEvent25 = paramMotionEvent;
          int i37 = 0;
          int i38 = MotionEventCompat.getPointerId(localMotionEvent25, i37);
          int i39 = this.mMaximumFlingVelocity;
          VelocityTracker localVelocityTracker9 = localVelocityTracker8;
          int i40 = 1000;
          int i41 = i39;
          localVelocityTracker9.computeCurrentVelocity(i40, i41);
          VelocityTracker localVelocityTracker10 = localVelocityTracker8;
          int i42 = i38;
          float f15 = VelocityTrackerCompat.getYVelocity(localVelocityTracker10, i42);
          VelocityTracker localVelocityTracker11 = localVelocityTracker8;
          int i43 = i38;
          float f16 = VelocityTrackerCompat.getXVelocity(localVelocityTracker11, i43);
          float f17 = Math.abs(f15);
          int i44 = this.mMinimumFlingVelocity;
          if (f17 <= i44)
          {
            float f18 = Math.abs(f16);
            int i45 = this.mMinimumFlingVelocity;
            if (f18 <= i45)
              continue;
          }
          GestureDetector.OnGestureListener localOnGestureListener7 = this.mListener;
          MotionEvent localMotionEvent26 = this.mCurrentDownEvent;
          GestureDetector.OnGestureListener localOnGestureListener8 = localOnGestureListener7;
          MotionEvent localMotionEvent27 = localMotionEvent26;
          MotionEvent localMotionEvent28 = paramMotionEvent;
          int i46 = f16;
          int i47 = f15;
          bool2 = localOnGestureListener8.onFling(localMotionEvent27, localMotionEvent28, i46, i47);
        }
        cancel();
      }
    }

    public void setIsLongpressEnabled(boolean paramBoolean)
    {
      this.mIsLongpressEnabled = paramBoolean;
    }

    public void setOnDoubleTapListener(GestureDetector.OnDoubleTapListener paramOnDoubleTapListener)
    {
      this.mDoubleTapListener = paramOnDoubleTapListener;
    }

    class GestureHandler extends Handler
    {
      GestureHandler()
      {
      }

      GestureHandler(Handler arg2)
      {
        super();
      }

      public void handleMessage(Message paramMessage)
      {
        switch (paramMessage.what)
        {
        default:
          String str = "Unknown message " + paramMessage;
          throw new RuntimeException(str);
        case 1:
          GestureDetector.OnGestureListener localOnGestureListener = GestureDetectorCompat.GestureDetectorCompatImplBase.this.mListener;
          MotionEvent localMotionEvent1 = GestureDetectorCompat.GestureDetectorCompatImplBase.this.mCurrentDownEvent;
          localOnGestureListener.onShowPress(localMotionEvent1);
        case 2:
        case 3:
        }
        while (true)
        {
          return;
          GestureDetectorCompat.GestureDetectorCompatImplBase.this.dispatchLongPress();
          continue;
          if ((GestureDetectorCompat.GestureDetectorCompatImplBase.this.mDoubleTapListener == null) || (GestureDetectorCompat.GestureDetectorCompatImplBase.this.mStillDown))
            continue;
          GestureDetector.OnDoubleTapListener localOnDoubleTapListener = GestureDetectorCompat.GestureDetectorCompatImplBase.this.mDoubleTapListener;
          MotionEvent localMotionEvent2 = GestureDetectorCompat.GestureDetectorCompatImplBase.this.mCurrentDownEvent;
          localOnDoubleTapListener.onSingleTapConfirmed(localMotionEvent2);
        }
      }
    }
  }

  abstract interface GestureDetectorCompatImpl
  {
    public abstract boolean isLongpressEnabled();

    public abstract boolean onTouchEvent(MotionEvent paramMotionEvent);

    public abstract void setIsLongpressEnabled(boolean paramBoolean);

    public abstract void setOnDoubleTapListener(GestureDetector.OnDoubleTapListener paramOnDoubleTapListener);
  }
}