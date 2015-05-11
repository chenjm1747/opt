package android.support.v4.view;

import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.os.IBinder;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.os.SystemClock;
import android.support.v4.os.ParcelableCompat;
import android.support.v4.view.accessibility.AccessibilityNodeInfoCompat;
import android.support.v4.widget.EdgeEffectCompat;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.FocusFinder;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.SoundEffectConstants;
import android.view.VelocityTracker;
import android.view.View;
import android.view.View.BaseSavedState;
import android.view.View.MeasureSpec;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.view.ViewParent;
import android.view.accessibility.AccessibilityEvent;
import android.view.animation.Interpolator;
import android.widget.Scroller;
import dalvik.annotation.Signature;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class ViewPager extends ViewGroup
{
  private static final int CLOSE_ENOUGH = 2;

  @Signature({"Ljava/util/Comparator", "<", "Landroid/support/v4/view/ViewPager$ItemInfo;", ">;"})
  private static final Comparator COMPARATOR;
  private static final boolean DEBUG = false;
  private static final int DEFAULT_GUTTER_SIZE = 16;
  private static final int DEFAULT_OFFSCREEN_PAGES = 1;
  private static final int DRAW_ORDER_DEFAULT = 0;
  private static final int DRAW_ORDER_FORWARD = 1;
  private static final int DRAW_ORDER_REVERSE = 2;
  private static final int INVALID_POINTER = 255;
  private static final int[] LAYOUT_ATTRS;
  private static final int MAX_SETTLE_DURATION = 600;
  private static final int MIN_DISTANCE_FOR_FLING = 25;
  private static final int MIN_FLING_VELOCITY = 400;
  public static final int SCROLL_STATE_DRAGGING = 1;
  public static final int SCROLL_STATE_IDLE = 0;
  public static final int SCROLL_STATE_SETTLING = 2;
  private static final String TAG = "ViewPager";
  private static final boolean USE_CACHE;
  private static final Interpolator sInterpolator;
  private static final ViewPositionComparator sPositionComparator;
  private int mActivePointerId;
  private PagerAdapter mAdapter;
  private OnAdapterChangeListener mAdapterChangeListener;
  private int mBottomPageBounds;
  private boolean mCalledSuper;
  private int mChildHeightMeasureSpec;
  private int mChildWidthMeasureSpec;
  private int mCloseEnough;
  private int mCurItem;
  private int mDecorChildCount;
  private int mDefaultGutterSize;
  private int mDrawingOrder;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/view/View;", ">;"})
  private ArrayList mDrawingOrderedChildren;
  private final Runnable mEndScrollRunnable;
  private long mFakeDragBeginTime;
  private boolean mFakeDragging;
  private boolean mFirstLayout;
  private float mFirstOffset;
  private int mFlingDistance;
  private int mGutterSize;
  private boolean mIgnoreGutter;
  private boolean mInLayout;
  private float mInitialMotionX;
  private float mInitialMotionY;
  private OnPageChangeListener mInternalPageChangeListener;
  private boolean mIsBeingDragged;
  private boolean mIsUnableToDrag;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/view/ViewPager$ItemInfo;", ">;"})
  private final ArrayList mItems;
  private float mLastMotionX;
  private float mLastMotionY;
  private float mLastOffset;
  private EdgeEffectCompat mLeftEdge;
  private Drawable mMarginDrawable;
  private int mMaximumVelocity;
  private int mMinimumVelocity;
  private boolean mNeedCalculatePageOffsets;
  private PagerObserver mObserver;
  private int mOffscreenPageLimit;
  private OnPageChangeListener mOnPageChangeListener;
  private int mPageMargin;
  private PageTransformer mPageTransformer;
  private boolean mPopulatePending;
  private Parcelable mRestoredAdapterState;
  private ClassLoader mRestoredClassLoader;
  private int mRestoredCurItem;
  private EdgeEffectCompat mRightEdge;
  private int mScrollState;
  private Scroller mScroller;
  private boolean mScrollingCacheEnabled;
  private Method mSetChildrenDrawingOrderEnabled;
  private final ItemInfo mTempItem;
  private final Rect mTempRect;
  private int mTopPageBounds;
  private int mTouchSlop;
  private VelocityTracker mVelocityTracker;

  static
  {
    int[] arrayOfInt = new int[1];
    arrayOfInt[0] = 16842931;
    LAYOUT_ATTRS = arrayOfInt;
    COMPARATOR = new ViewPager.1();
    sInterpolator = new ViewPager.2();
    sPositionComparator = new ViewPositionComparator();
  }

  public ViewPager(Context paramContext)
  {
    super(paramContext);
    ArrayList localArrayList = new ArrayList();
    this.mItems = localArrayList;
    ItemInfo localItemInfo = new ItemInfo();
    this.mTempItem = localItemInfo;
    Rect localRect = new Rect();
    this.mTempRect = localRect;
    this.mRestoredCurItem = -1;
    this.mRestoredAdapterState = null;
    this.mRestoredClassLoader = null;
    this.mFirstOffset = -8388609;
    this.mLastOffset = 2139095039;
    this.mOffscreenPageLimit = 1;
    this.mActivePointerId = -1;
    this.mFirstLayout = true;
    this.mNeedCalculatePageOffsets = null;
    ViewPager.3 local3 = new ViewPager.3(this);
    this.mEndScrollRunnable = local3;
    this.mScrollState = null;
    initViewPager();
  }

  public ViewPager(Context paramContext, AttributeSet paramAttributeSet)
  {
    super(paramContext, paramAttributeSet);
    ArrayList localArrayList = new ArrayList();
    this.mItems = localArrayList;
    ItemInfo localItemInfo = new ItemInfo();
    this.mTempItem = localItemInfo;
    Rect localRect = new Rect();
    this.mTempRect = localRect;
    this.mRestoredCurItem = -1;
    this.mRestoredAdapterState = null;
    this.mRestoredClassLoader = null;
    this.mFirstOffset = -8388609;
    this.mLastOffset = 2139095039;
    this.mOffscreenPageLimit = 1;
    this.mActivePointerId = -1;
    this.mFirstLayout = true;
    this.mNeedCalculatePageOffsets = null;
    ViewPager.3 local3 = new ViewPager.3(this);
    this.mEndScrollRunnable = local3;
    this.mScrollState = null;
    initViewPager();
  }

  private void calculatePageOffsets(ItemInfo paramItemInfo1, int paramInt, ItemInfo paramItemInfo2)
  {
    PagerAdapter localPagerAdapter1 = this.mAdapter;
    int i12 = localPagerAdapter1.getCount();
    int i13 = getWidth();
    int i14;
    int i15;
    ItemInfo localItemInfo;
    float f8;
    Object localObject;
    if (i13 > 0)
    {
      float f1 = this.mPageMargin;
      float f6 = i13;
      float f7 = f1 / f6;
      if (paramItemInfo2 == null)
        break label480;
      i14 = paramItemInfo2.position;
      int i = paramItemInfo1.position;
      if (i14 < i)
      {
        i15 = 0;
        localItemInfo = null;
        int j = paramItemInfo2.offset;
        int i16 = paramItemInfo2.widthFactor;
        float f2;
        j += i16;
        f8 = f2 + f7;
      }
    }
    else
    {
      for (i19 = i14 + 1; ; i19++)
      {
        int k = paramItemInfo1.position;
        if (i19 > k)
          break label480;
        int m = this.mItems.size();
        if (i15 >= m)
          break label480;
        ArrayList localArrayList1 = this.mItems;
        localItemInfo = (ItemInfo)localArrayList1.get(i15);
        while (true)
        {
          int n = localItemInfo.position;
          if (i19 > n)
          {
            int i1 = this.mItems.size();
            i1--;
            if (i15 < i1)
            {
              i15++;
              ArrayList localArrayList2 = this.mItems;
              localItemInfo = (ItemInfo)localArrayList2.get(i15);
              continue;
              localObject = null;
              break;
            }
          }
        }
        while (true)
        {
          int i2 = localItemInfo.position;
          if (i19 >= i2)
            break;
          f3 = this.mAdapter.getPageWidth(i19) + localObject;
          f8 += f3;
          i19++;
        }
        localItemInfo.offset = f8;
        float f3 = localItemInfo.widthFactor + localObject;
        f8 += f3;
      }
    }
    int i3 = paramItemInfo1.position;
    if (i14 > i3)
    {
      int i4 = this.mItems.size();
      i15 = i4 + -1;
      localItemInfo = null;
      int i17 = paramItemInfo2.offset;
      for (i19 = i14 + -1; ; i19--)
      {
        i4 = paramItemInfo1.position;
        if ((i19 < i4) || (i15 < 0))
          break;
        ArrayList localArrayList3 = this.mItems;
        ArrayList localArrayList4;
        for (localItemInfo = (ItemInfo)localArrayList3.get(i15); ; localItemInfo = (ItemInfo)localArrayList4.get(i15))
        {
          int i5 = localItemInfo.position;
          if ((i19 >= i5) || (i15 <= 0))
            break;
          i15--;
          localArrayList4 = this.mItems;
        }
        float f9;
        while (true)
        {
          int i6 = localItemInfo.position;
          if (i19 <= i6)
            break;
          f4 = this.mAdapter.getPageWidth(i19) + localObject;
          i17 -= f4;
          i19--;
        }
        float f4 = localItemInfo.widthFactor + localObject;
        f9 -= f4;
        localItemInfo.offset = f9;
      }
    }
    label480: int i20 = this.mItems.size();
    int i18 = paramItemInfo1.offset;
    int i19 = paramItemInfo1.position + -1;
    int i7 = paramItemInfo1.position;
    if (i7 == 0)
    {
      int i8 = paramItemInfo1.offset;
      this.mFirstOffset = i8;
      int i9 = paramItemInfo1.position;
      int i21 = i12 + -1;
      if (i9 != i21)
        break label661;
      int i10 = paramItemInfo1.offset;
      int i22 = paramItemInfo1.widthFactor;
      float f5 = i10 + i22 - 1065353216;
      label570: this.mLastOffset = f5;
      i23 = paramInt + -1;
    }
    while (true)
    {
      if (i23 < 0)
        break label715;
      localItemInfo = (ItemInfo)this.mItems.get(i23);
      while (true)
      {
        int i24 = localItemInfo.position;
        if (i19 > i24)
        {
          PagerAdapter localPagerAdapter2 = this.mAdapter;
          int i25 = i19 + -1;
          float f11 = localPagerAdapter2.getPageWidth(i19) + localObject;
          i18 -= f11;
          i19 = i25;
          continue;
          int i11 = -8388609;
          break;
          label661: i11 = 2139095039;
          break label570;
        }
      }
      float f12 = localItemInfo.widthFactor + localObject;
      f10 -= f12;
      localItemInfo.offset = f10;
      if (localItemInfo.position == 0)
        this.mFirstOffset = f10;
      i23--;
      i19--;
    }
    label715: int i26 = paramItemInfo1.offset;
    int i27 = paramItemInfo1.widthFactor;
    float f10 = i26 + i27 + localObject;
    i19 = paramItemInfo1.position + 1;
    int i23 = paramInt + 1;
    while (i23 < i20)
    {
      localItemInfo = (ItemInfo)this.mItems.get(i23);
      while (true)
      {
        int i28 = localItemInfo.position;
        if (i19 >= i28)
          break;
        PagerAdapter localPagerAdapter3 = this.mAdapter;
        int i29 = i19 + 1;
        float f13 = localPagerAdapter3.getPageWidth(i19) + localObject;
        f10 += f13;
        i19 = i29;
      }
      int i30 = localItemInfo.position;
      int i31 = i12 + -1;
      if (i30 == i31)
      {
        float f14 = localItemInfo.widthFactor + f10 - 1065353216;
        this.mLastOffset = f14;
      }
      localItemInfo.offset = f10;
      float f15 = localItemInfo.widthFactor + localObject;
      f10 += f15;
      i23++;
      i19++;
    }
    this.mNeedCalculatePageOffsets = null;
  }

  private void completeScroll(boolean paramBoolean)
  {
    boolean bool1 = null;
    int i;
    if (this.mScrollState == 2)
      i = 1;
    boolean bool2;
    while (true)
    {
      if (i != null)
      {
        setScrollingCacheEnabled(bool1);
        this.mScroller.abortAnimation();
        int j = getScrollX();
        int k = getScrollY();
        int m = this.mScroller.getCurrX();
        int n = this.mScroller.getCurrY();
        if ((j != m) || (k != n))
          scrollTo(m, n);
      }
      this.mPopulatePending = bool1;
      for (int i1 = 0; ; i1++)
      {
        int i2 = this.mItems.size();
        if (i1 >= i2)
          break;
        ItemInfo localItemInfo = (ItemInfo)this.mItems.get(i1);
        if (!localItemInfo.scrolling)
          continue;
        i = 1;
        localItemInfo.scrolling = bool1;
      }
      bool2 = bool1;
    }
    if (bool2 != null)
    {
      if (!paramBoolean)
        break label166;
      Runnable localRunnable = this.mEndScrollRunnable;
      ViewCompat.postOnAnimation(this, localRunnable);
    }
    while (true)
    {
      return;
      label166: this.mEndScrollRunnable.run();
    }
  }

  private int determineTargetPage(int paramInt1, float paramFloat, int paramInt2, int paramInt3)
  {
    int i = Math.abs(paramInt3);
    int j = this.mFlingDistance;
    int i1;
    if (i > j)
    {
      int k = Math.abs(paramInt2);
      int m = this.mMinimumVelocity;
      if (k > m)
      {
        if (paramInt2 > 0);
        for (int n = paramInt1; ; i1 = paramInt1 + 1)
        {
          if (this.mItems.size() > 0)
          {
            ItemInfo localItemInfo1 = (ItemInfo)this.mItems.get(null);
            ArrayList localArrayList = this.mItems;
            int i2 = this.mItems.size();
            int i3;
            i3--;
            ItemInfo localItemInfo2 = (ItemInfo)localArrayList.get(i2);
            int i4 = localItemInfo1.position;
            int i5 = localItemInfo2.position;
            int i6 = Math.min(n, i5);
            i1 = Math.max(i4, i6);
          }
          return i1;
        }
      }
    }
    int i7 = this.mCurItem;
    if (paramInt1 >= i7);
    for (int i8 = 1053609165; ; i8 = 1058642330)
    {
      i1 = (int)(paramInt1 + paramFloat + i8);
      break;
    }
  }

  private void enableLayers(boolean paramBoolean)
  {
    int i = getChildCount();
    int j = 0;
    if (j < i)
    {
      if (paramBoolean);
      for (int k = 2; ; k = null)
      {
        ViewCompat.setLayerType(getChildAt(j), k, null);
        j++;
        break;
      }
    }
  }

  private void endDrag()
  {
    this.mIsBeingDragged = null;
    this.mIsUnableToDrag = null;
    if (this.mVelocityTracker != null)
    {
      this.mVelocityTracker.recycle();
      this.mVelocityTracker = null;
    }
  }

  private Rect getChildRectInPagerCoordinates(Rect paramRect, View paramView)
  {
    int i = 0;
    if (paramRect == null)
      paramRect = new Rect();
    if (paramView == null)
      paramRect.set(i, i, i, i);
    while (true)
    {
      return paramRect;
      int j = paramView.getLeft();
      paramRect.left = j;
      int k = paramView.getRight();
      paramRect.right = k;
      int m = paramView.getTop();
      paramRect.top = m;
      int n = paramView.getBottom();
      paramRect.bottom = n;
      ViewGroup localViewGroup;
      for (ViewParent localViewParent = paramView.getParent(); ((localViewParent instanceof ViewGroup)) && (localViewParent != this); localViewParent = localViewGroup.getParent())
      {
        localViewGroup = (ViewGroup)localViewParent;
        int i1 = paramRect.left;
        int i2 = localViewGroup.getLeft();
        int i3 = i1 + i2;
        paramRect.left = i3;
        int i4 = paramRect.right;
        int i5 = localViewGroup.getRight();
        int i6 = i4 + i5;
        paramRect.right = i6;
        int i7 = paramRect.top;
        int i8 = localViewGroup.getTop();
        int i9 = i7 + i8;
        paramRect.top = i9;
        int i10 = paramRect.bottom;
        int i11 = localViewGroup.getBottom();
        int i12 = i10 + i11;
        paramRect.bottom = i12;
      }
    }
  }

  private ItemInfo infoForCurrentScrollPosition()
  {
    Object localObject1 = null;
    int i = getWidth();
    float f4;
    float f1;
    int j;
    Object localObject2;
    Object localObject3;
    int m;
    if (i > 0)
    {
      float f2 = getScrollX();
      float f3 = i;
      f4 = f2 / f3;
      if (i > 0)
      {
        float f5 = this.mPageMargin;
        float f6 = i;
        f1 = f5 / f6;
      }
      j = -1;
      localObject2 = null;
      localObject3 = null;
      m = 1;
      int n = 0;
    }
    for (int i1 = 0; ; i1++)
    {
      int i2 = this.mItems.size();
      ItemInfo localItemInfo;
      Object localObject6;
      if (i1 < i2)
      {
        localItemInfo = (ItemInfo)this.mItems.get(i1);
        if (m == null)
        {
          int i3 = localItemInfo.position;
          int i4 = j + 1;
          if (i3 != i4)
          {
            localItemInfo = this.mTempItem;
            float f7 = localObject2 + localObject3 + f1;
            localItemInfo.offset = f7;
            int i5 = j + 1;
            localItemInfo.position = i5;
            PagerAdapter localPagerAdapter = this.mAdapter;
            int i6 = localItemInfo.position;
            float f8 = localPagerAdapter.getPageWidth(i6);
            localItemInfo.widthFactor = f8;
            i1--;
          }
        }
        localObject6 = localItemInfo.offset;
        int i7 = localObject6;
        float f9 = localItemInfo.widthFactor + localObject6 + f1;
        if ((m != null) || (f4 >= i7))
        {
          if (f4 >= f9)
          {
            int i8 = this.mItems.size();
            int i9;
            i9--;
            if (i1 != i8)
              break label265;
          }
          localObject5 = localItemInfo;
        }
      }
      return localObject5;
      f4 = f1;
      break;
      label265: Object localObject4 = null;
      j = localItemInfo.position;
      localObject2 = localObject6;
      int k = localItemInfo.widthFactor;
      Object localObject5 = localItemInfo;
    }
  }

  private boolean isGutterDrag(float paramFloat1, float paramFloat2)
  {
    Object localObject1 = null;
    float f1 = this.mGutterSize;
    f1 = paramFloat1 < f1;
    if (f1 < 0)
    {
      f1 = paramFloat2 < localObject1;
      if (f1 > 0);
    }
    else
    {
      int i = getWidth();
      int k = this.mGutterSize;
      float f2 = i - k;
      f2 = paramFloat1 < f2;
      if (f2 <= 0)
        break label77;
      f2 = paramFloat2 < localObject1;
      if (f2 >= 0)
        break label77;
    }
    int j = 1;
    while (true)
    {
      return j;
      label77: Object localObject2 = null;
    }
  }

  private void onSecondaryPointerUp(MotionEvent paramMotionEvent)
  {
    int i = MotionEventCompat.getActionIndex(paramMotionEvent);
    int j = MotionEventCompat.getPointerId(paramMotionEvent, i);
    int k = this.mActivePointerId;
    if (j == k)
      if (i != 0)
        break label73;
    label73: for (int m = 1; ; m = 0)
    {
      float f = MotionEventCompat.getX(paramMotionEvent, m);
      this.mLastMotionX = f;
      int n = MotionEventCompat.getPointerId(paramMotionEvent, m);
      this.mActivePointerId = n;
      if (this.mVelocityTracker != null)
        this.mVelocityTracker.clear();
      return;
    }
  }

  private boolean pageScrolled(int paramInt)
  {
    int i = 0;
    boolean bool;
    if (this.mItems.size() == 0)
    {
      this.mCalledSuper = i;
      onPageScrolled(i, null, i);
      if (!this.mCalledSuper)
        throw new IllegalStateException("onPageScrolled did not call superclass implementation");
    }
    else
    {
      ItemInfo localItemInfo = infoForCurrentScrollPosition();
      int j = getWidth();
      int k = this.mPageMargin;
      int m = j + k;
      float f1 = this.mPageMargin;
      float f2 = j;
      float f3 = f1 / f2;
      int n = localItemInfo.position;
      float f4 = paramInt;
      float f5 = j;
      float f6 = f4 / f5;
      int i1 = localItemInfo.offset;
      float f7 = f6 - i1;
      float f8 = localItemInfo.widthFactor + f3;
      float f9 = f7 / f8;
      int i2 = (int)(m * f9);
      this.mCalledSuper = i;
      onPageScrolled(n, f9, i2);
      bool = this.mCalledSuper;
      if (!bool)
        throw new IllegalStateException("onPageScrolled did not call superclass implementation");
      bool = true;
    }
    return bool;
  }

  private boolean performDrag(float paramFloat)
  {
    boolean bool = null;
    float f1 = this.mLastMotionX - paramFloat;
    int i = paramFloat;
    this.mLastMotionX = i;
    float f2 = getScrollX() + f1;
    int j = getWidth();
    float f3 = j;
    int k = this.mFirstOffset;
    float f4 = f3 * k;
    float f5 = j;
    int m = this.mLastOffset;
    float f6 = f5 * m;
    int n = 1;
    int i1 = 1;
    ItemInfo localItemInfo1 = (ItemInfo)this.mItems.get(0);
    ArrayList localArrayList = this.mItems;
    int i2 = this.mItems.size();
    int i3;
    i3--;
    ItemInfo localItemInfo2 = (ItemInfo)localArrayList.get(i2);
    Object localObject1;
    if (localItemInfo1.position != 0)
    {
      localObject1 = null;
      int i4 = localItemInfo1.offset;
      float f7 = j;
      f4 = i4 * f7;
    }
    int i5 = localItemInfo2.position;
    int i6 = this.mAdapter.getCount();
    i3--;
    Object localObject2;
    if (i5 != i6)
    {
      localObject2 = null;
      int i7 = localItemInfo2.offset;
      float f8 = j;
      f6 = i7 * f8;
    }
    if (f2 < f4)
    {
      if (localObject1 != null)
      {
        float f9 = f4 - f2;
        EdgeEffectCompat localEdgeEffectCompat1 = this.mLeftEdge;
        float f10 = Math.abs(f9);
        int i8 = j;
        float f11 = f10 / i8;
        bool = localEdgeEffectCompat1.onPull(f11);
      }
      f2 = f4;
    }
    while (true)
    {
      int i9 = this.mLastMotionX;
      float f12 = (int)f2;
      float f13 = f2 - f12;
      float f14 = i9 + f13;
      this.mLastMotionX = f14;
      int i10 = (int)f2;
      int i11 = getScrollY();
      scrollTo(i10, i11);
      int i12 = (int)f2;
      pageScrolled(i12);
      return bool;
      if (f2 <= f6)
        continue;
      if (localObject2 != null)
      {
        float f15 = f2 - f6;
        EdgeEffectCompat localEdgeEffectCompat2 = this.mRightEdge;
        float f16 = Math.abs(f15);
        int i13 = j;
        float f17 = f16 / i13;
        bool = localEdgeEffectCompat2.onPull(f17);
      }
      f2 = f6;
    }
  }

  private void recomputeScrollPosition(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    if ((paramInt2 > 0) && (!this.mItems.isEmpty()))
    {
      int i = paramInt1 + paramInt3;
      int j = paramInt2 + paramInt4;
      float f1 = getScrollX();
      float f2 = j;
      float f3 = f1 / f2;
      int k = (int)(i * f3);
      int m = getScrollY();
      scrollTo(k, m);
      if (!this.mScroller.isFinished())
      {
        int n = this.mScroller.getDuration();
        int i1 = this.mScroller.timePassed();
        int i2 = n - i1;
        int i3 = this.mCurItem;
        ItemInfo localItemInfo1 = infoForPosition(i3);
        Scroller localScroller = this.mScroller;
        int i4 = localItemInfo1.offset;
        float f4 = paramInt1;
        int i5 = (int)(i4 * f4);
        localScroller.startScroll(k, 0, i5, 0, i2);
      }
      return;
    }
    int i6 = this.mCurItem;
    ItemInfo localItemInfo2 = infoForPosition(i6);
    int i7;
    int i8;
    if (localItemInfo2 != null)
    {
      i7 = localItemInfo2.offset;
      i8 = this.mLastOffset;
    }
    Object localObject;
    for (float f5 = Math.min(i7, i8); ; localObject = null)
    {
      int i9 = (int)(paramInt1 * f5);
      int i10 = getScrollX();
      if (i9 == i10)
        break;
      completeScroll(null);
      int i11 = getScrollY();
      scrollTo(i9, i11);
      break;
    }
  }

  private void removeNonDecorViews()
  {
    for (int i = 0; ; i++)
    {
      int j = getChildCount();
      if (i >= j)
        break;
      if (((LayoutParams)getChildAt(i).getLayoutParams()).isDecor)
        continue;
      removeViewAt(i);
      i--;
    }
  }

  private void scrollToItem(int paramInt1, boolean paramBoolean1, int paramInt2, boolean paramBoolean2)
  {
    int i = 0;
    ItemInfo localItemInfo = infoForPosition(paramInt1);
    int j = 0;
    if (localItemInfo != null)
    {
      float f1 = getWidth();
      int k = this.mFirstOffset;
      int m = localItemInfo.offset;
      int n = this.mLastOffset;
      float f2 = Math.min(m, n);
      float f3 = Math.max(k, f2);
      j = (int)(f1 * f3);
    }
    if (paramBoolean1)
    {
      smoothScrollTo(j, i, paramInt2);
      if ((paramBoolean2) && (this.mOnPageChangeListener != null))
        this.mOnPageChangeListener.onPageSelected(paramInt1);
      if ((paramBoolean2) && (this.mInternalPageChangeListener != null))
        this.mInternalPageChangeListener.onPageSelected(paramInt1);
    }
    while (true)
    {
      return;
      if ((paramBoolean2) && (this.mOnPageChangeListener != null))
        this.mOnPageChangeListener.onPageSelected(paramInt1);
      if ((paramBoolean2) && (this.mInternalPageChangeListener != null))
        this.mInternalPageChangeListener.onPageSelected(paramInt1);
      completeScroll(i);
      scrollTo(j, i);
    }
  }

  private void setScrollState(int paramInt)
  {
    int i = this.mScrollState;
    if (i == paramInt)
      return;
    this.mScrollState = paramInt;
    PageTransformer localPageTransformer = this.mPageTransformer;
    int j;
    if (localPageTransformer != null)
    {
      if (paramInt == 0)
        break label56;
      j = 1;
    }
    while (true)
    {
      enableLayers(j);
      if (this.mOnPageChangeListener == null)
        break;
      this.mOnPageChangeListener.onPageScrollStateChanged(paramInt);
      break;
      label56: Object localObject = null;
    }
  }

  private void setScrollingCacheEnabled(boolean paramBoolean)
  {
    if (this.mScrollingCacheEnabled != paramBoolean)
      this.mScrollingCacheEnabled = paramBoolean;
  }

  @Signature({"(", "Ljava/util/ArrayList", "<", "Landroid/view/View;", ">;II)V"})
  public void addFocusables(ArrayList paramArrayList, int paramInt1, int paramInt2)
  {
    int i = paramArrayList.size();
    int j = getDescendantFocusability();
    if (j != 393216)
      for (int k = 0; ; k++)
      {
        int m = getChildCount();
        if (k >= m)
          break;
        View localView = getChildAt(k);
        if (localView.getVisibility() != 0)
          continue;
        ItemInfo localItemInfo = infoForChild(localView);
        if (localItemInfo == null)
          continue;
        int n = localItemInfo.position;
        int i1 = this.mCurItem;
        if (n != i1)
          continue;
        localView.addFocusables(paramArrayList, paramInt1, paramInt2);
      }
    if (j == 262144)
    {
      int i2 = paramArrayList.size();
      if (i != i2);
    }
    else
    {
      if (isFocusable())
        break label128;
    }
    while (true)
    {
      return;
      label128: if ((((paramInt2 & 0x1) != 1) || (!isInTouchMode()) || (isFocusableInTouchMode())) && (paramArrayList != null))
      {
        paramArrayList.add(this);
        continue;
      }
    }
  }

  ItemInfo addNewItem(int paramInt1, int paramInt2)
  {
    ItemInfo localItemInfo = new ItemInfo();
    localItemInfo.position = paramInt1;
    Object localObject = this.mAdapter.instantiateItem(this, paramInt1);
    localItemInfo.object = localObject;
    float f = this.mAdapter.getPageWidth(paramInt1);
    localItemInfo.widthFactor = f;
    if (paramInt2 >= 0)
    {
      int i = this.mItems.size();
      if (paramInt2 < i);
    }
    else
    {
      this.mItems.add(localItemInfo);
    }
    while (true)
    {
      return localItemInfo;
      this.mItems.add(paramInt2, localItemInfo);
    }
  }

  @Signature({"(", "Ljava/util/ArrayList", "<", "Landroid/view/View;", ">;)V"})
  public void addTouchables(ArrayList paramArrayList)
  {
    for (int i = 0; ; i++)
    {
      int j = getChildCount();
      if (i >= j)
        break;
      View localView = getChildAt(i);
      if (localView.getVisibility() != 0)
        continue;
      ItemInfo localItemInfo = infoForChild(localView);
      if (localItemInfo == null)
        continue;
      int k = localItemInfo.position;
      int m = this.mCurItem;
      if (k != m)
        continue;
      localView.addTouchables(paramArrayList);
    }
  }

  public void addView(View paramView, int paramInt, ViewGroup.LayoutParams paramLayoutParams)
  {
    if (!checkLayoutParams(paramLayoutParams))
      paramLayoutParams = generateLayoutParams(paramLayoutParams);
    LayoutParams localLayoutParams = (LayoutParams)paramLayoutParams;
    boolean bool1 = localLayoutParams.isDecor;
    boolean bool2 = paramView instanceof Decor;
    boolean bool3 = bool1 | bool2;
    localLayoutParams.isDecor = bool3;
    if (this.mInLayout)
    {
      if ((localLayoutParams != null) && (localLayoutParams.isDecor))
        throw new IllegalStateException("Cannot add pager decor view during layout");
      localLayoutParams.needsMeasure = true;
      addViewInLayout(paramView, paramInt, paramLayoutParams);
    }
    while (true)
    {
      return;
      super.addView(paramView, paramInt, paramLayoutParams);
    }
  }

  public boolean arrowScroll(int paramInt)
  {
    int i = 66;
    int j = 17;
    View localView1 = findFocus();
    int k;
    if (localView1 == this)
      k = 0;
    boolean bool = null;
    View localView2 = FocusFinder.getInstance().findNextFocus(this, k, paramInt);
    int m;
    int n;
    if ((localView2 != null) && (localView2 != k))
      if (paramInt == j)
      {
        Rect localRect1 = this.mTempRect;
        m = getChildRectInPagerCoordinates(localRect1, localView2).left;
        Rect localRect2 = this.mTempRect;
        n = getChildRectInPagerCoordinates(localRect2, k).left;
        if ((k != null) && (m >= n))
          bool = pageLeft();
      }
    while (true)
    {
      if (bool != null)
      {
        int i1 = SoundEffectConstants.getContantForFocusDirection(paramInt);
        playSoundEffect(i1);
      }
      return bool;
      bool = localView2.requestFocus();
      continue;
      if (paramInt != i)
        continue;
      Rect localRect3 = this.mTempRect;
      m = getChildRectInPagerCoordinates(localRect3, localView2).left;
      Rect localRect4 = this.mTempRect;
      n = getChildRectInPagerCoordinates(localRect4, k).left;
      if ((k != null) && (m <= n))
      {
        bool = pageRight();
        continue;
      }
      bool = localView2.requestFocus();
      continue;
      if ((paramInt == j) || (paramInt == 1))
      {
        bool = pageLeft();
        continue;
      }
      if ((paramInt != i) && (paramInt != 2))
        continue;
      bool = pageRight();
    }
  }

  public boolean beginFakeDrag()
  {
    int i = 1;
    int j = 0;
    float f1 = null;
    if (this.mIsBeingDragged)
      return j;
    this.mFakeDragging = i;
    setScrollState(i);
    this.mLastMotionX = f1;
    this.mInitialMotionX = f1;
    if (this.mVelocityTracker == null)
    {
      VelocityTracker localVelocityTracker = VelocityTracker.obtain();
      this.mVelocityTracker = localVelocityTracker;
    }
    while (true)
    {
      long l1 = SystemClock.uptimeMillis();
      Object localObject;
      long l2 = localObject;
      float f2 = f1;
      int k = j;
      MotionEvent localMotionEvent = MotionEvent.obtain(localObject, l2, j, f1, f2, k);
      this.mVelocityTracker.addMovement(localMotionEvent);
      localMotionEvent.recycle();
      this.mFakeDragBeginTime = localObject;
      j = i;
      break;
      this.mVelocityTracker.clear();
    }
  }

  protected boolean canScroll(View paramView, boolean paramBoolean, int paramInt1, int paramInt2, int paramInt3)
  {
    boolean bool1 = paramView instanceof ViewGroup;
    int n;
    int j;
    if (bool1)
    {
      ViewGroup localViewGroup = (ViewGroup)paramView;
      int k = paramView.getScrollX();
      int m = paramView.getScrollY();
      n = localViewGroup.getChildCount() + -1;
      if (n >= 0)
      {
        View localView = localViewGroup.getChildAt(n);
        int i = paramInt2 + k;
        int i1 = localView.getLeft();
        if (i >= i1)
        {
          i = paramInt2 + k;
          int i2 = localView.getRight();
          if (i < i2)
          {
            i = paramInt3 + m;
            int i3 = localView.getTop();
            if (i >= i3)
            {
              i = paramInt3 + m;
              int i4 = localView.getBottom();
              if (i < i4)
              {
                i = paramInt2 + k;
                int i5 = localView.getLeft();
                int i6 = i - i5;
                i = paramInt3 + m;
                int i7 = localView.getTop();
                int i8 = i - i7;
                Object localObject1 = this;
                int i9 = paramInt1;
                localObject1 = ((ViewPager)localObject1).canScroll(localView, true, i9, i6, i8);
                if (localObject1 != 0)
                  j = 1;
              }
            }
          }
        }
      }
    }
    while (true)
    {
      return j;
      n--;
      break;
      if (paramBoolean)
      {
        j = -paramInt1;
        boolean bool2 = ViewCompat.canScrollHorizontally(paramView, j);
        if (bool2)
        {
          bool2 = true;
          continue;
        }
      }
      Object localObject2 = null;
    }
  }

  protected boolean checkLayoutParams(ViewGroup.LayoutParams paramLayoutParams)
  {
    boolean bool1 = paramLayoutParams instanceof LayoutParams;
    boolean bool2;
    if (bool1)
    {
      bool2 = super.checkLayoutParams(paramLayoutParams);
      if (bool2)
        bool2 = true;
    }
    while (true)
    {
      return bool2;
      Object localObject = null;
    }
  }

  public void computeScroll()
  {
    if ((!this.mScroller.isFinished()) && (this.mScroller.computeScrollOffset()))
    {
      int i = getScrollX();
      int j = getScrollY();
      int k = this.mScroller.getCurrX();
      int m = this.mScroller.getCurrY();
      if ((i != k) || (j != m))
      {
        scrollTo(k, m);
        if (!pageScrolled(k))
        {
          this.mScroller.abortAnimation();
          scrollTo(0, m);
        }
      }
      ViewCompat.postInvalidateOnAnimation(this);
    }
    while (true)
    {
      return;
      completeScroll(true);
    }
  }

  void dataSetChanged()
  {
    boolean bool1 = true;
    int i = 0;
    int j = this.mItems.size();
    int k = this.mOffscreenPageLimit * 2;
    int m;
    m++;
    boolean bool2;
    Object localObject1;
    int i5;
    label69: ItemInfo localItemInfo;
    int i7;
    if (j < k)
    {
      int n = this.mItems.size();
      int i1 = this.mAdapter.getCount();
      if (n < i1)
      {
        bool2 = bool1;
        int i2 = this.mCurItem;
        localObject1 = null;
        i5 = 0;
        int i6 = this.mItems.size();
        if (i5 >= i6)
          break label317;
        localItemInfo = (ItemInfo)this.mItems.get(i5);
        PagerAdapter localPagerAdapter1 = this.mAdapter;
        Object localObject2 = localItemInfo.object;
        i7 = localPagerAdapter1.getItemPosition(localObject2);
        if (i7 != -1)
          break label140;
      }
    }
    label140: int i4;
    int i3;
    while (true)
    {
      i5++;
      break label69;
      bool2 = i;
      break;
      if (i7 == -1)
      {
        this.mItems.remove(i5);
        i5--;
        if (localObject1 == null)
        {
          this.mAdapter.startUpdate(this);
          i4 = 1;
        }
        PagerAdapter localPagerAdapter2 = this.mAdapter;
        int i8 = localItemInfo.position;
        Object localObject3 = localItemInfo.object;
        localPagerAdapter2.destroyItem(this, i8, localObject3);
        bool2 = true;
        int i9 = this.mCurItem;
        int i10 = localItemInfo.position;
        if (i9 != i10)
          continue;
        int i11 = this.mCurItem;
        int i12 = this.mAdapter.getCount();
        m--;
        int i13 = Math.min(i11, i12);
        i3 = Math.max(i, i13);
        bool2 = true;
        continue;
      }
      if (localItemInfo.position == i7)
        continue;
      int i14 = localItemInfo.position;
      int i15 = this.mCurItem;
      if (i14 == i15)
        i3 = i7;
      localItemInfo.position = i7;
      bool2 = true;
    }
    label317: if (i4 != null)
      this.mAdapter.finishUpdate(this);
    ArrayList localArrayList = this.mItems;
    Comparator localComparator = COMPARATOR;
    Collections.sort(localArrayList, localComparator);
    if (bool2)
    {
      int i16 = getChildCount();
      for (i5 = 0; i5 < i16; i5++)
      {
        LayoutParams localLayoutParams = (LayoutParams)getChildAt(i5).getLayoutParams();
        if (localLayoutParams.isDecor)
          continue;
        localLayoutParams.widthFactor = null;
      }
      setCurrentItemInternal(i3, i, bool1);
      requestLayout();
    }
  }

  public boolean dispatchKeyEvent(KeyEvent paramKeyEvent)
  {
    boolean bool = super.dispatchKeyEvent(paramKeyEvent);
    if (!bool)
    {
      bool = executeKeyEvent(paramKeyEvent);
      if (!bool);
    }
    else
    {
      bool = true;
    }
    while (true)
    {
      return bool;
      Object localObject = null;
    }
  }

  public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent paramAccessibilityEvent)
  {
    int i = getChildCount();
    int j = 0;
    boolean bool;
    if (j < i)
    {
      View localView = getChildAt(j);
      int k = localView.getVisibility();
      if (k == 0)
      {
        ItemInfo localItemInfo = infoForChild(localView);
        if (localItemInfo != null)
        {
          k = localItemInfo.position;
          int m = this.mCurItem;
          if (k == m)
          {
            bool = localView.dispatchPopulateAccessibilityEvent(paramAccessibilityEvent);
            if (bool)
              bool = true;
          }
        }
      }
    }
    while (true)
    {
      return bool;
      j++;
      break;
      Object localObject = null;
    }
  }

  float distanceInfluenceForSnapDuration(float paramFloat)
  {
    return (float)Math.sin((float)((paramFloat - 1056964608) * 4602160705557665991L));
  }

  public void draw(Canvas paramCanvas)
  {
    int i = 1;
    super.draw(paramCanvas);
    Object localObject = null;
    int m = ViewCompat.getOverScrollMode(this);
    int k;
    if ((m == 0) || ((m == i) && (this.mAdapter != null) && (this.mAdapter.getCount() > i)))
    {
      int j;
      if (!this.mLeftEdge.isFinished())
      {
        int n = paramCanvas.save();
        int i1 = getHeight();
        int i2 = getPaddingTop();
        int i3 = i1 - i2;
        int i4 = getPaddingBottom();
        int i5 = i3 - i4;
        int i6 = getWidth();
        paramCanvas.rotate(1132920832);
        int i7 = -i5;
        int i8 = getPaddingTop();
        float f1 = i7 + i8;
        int i9 = this.mFirstOffset;
        float f2 = i6;
        float f3 = i9 * f2;
        paramCanvas.translate(f1, f3);
        this.mLeftEdge.setSize(i5, i6);
        boolean bool1 = this.mLeftEdge.draw(paramCanvas);
        j = localObject | bool1;
        paramCanvas.restoreToCount(n);
      }
      if (!this.mRightEdge.isFinished())
      {
        int i10 = paramCanvas.save();
        int i11 = getWidth();
        int i12 = getHeight();
        int i13 = getPaddingTop();
        int i14 = i12 - i13;
        int i15 = getPaddingBottom();
        int i16 = i14 - i15;
        paramCanvas.rotate(1119092736);
        float f4 = -getPaddingTop();
        int i17 = -(this.mLastOffset + 1065353216);
        float f5 = i11;
        float f6 = i17 * f5;
        paramCanvas.translate(f4, f6);
        this.mRightEdge.setSize(i16, i11);
        boolean bool2 = this.mRightEdge.draw(paramCanvas);
        k = j | bool2;
        paramCanvas.restoreToCount(i10);
      }
    }
    while (true)
    {
      if (k != null)
        ViewCompat.postInvalidateOnAnimation(this);
      return;
      this.mLeftEdge.finish();
      this.mRightEdge.finish();
    }
  }

  protected void drawableStateChanged()
  {
    super.drawableStateChanged();
    Drawable localDrawable = this.mMarginDrawable;
    if ((localDrawable != null) && (localDrawable.isStateful()))
    {
      int[] arrayOfInt = getDrawableState();
      localDrawable.setState(arrayOfInt);
    }
  }

  public void endFakeDrag()
  {
    boolean bool = true;
    if (!this.mFakeDragging)
      throw new IllegalStateException("No fake drag in progress. Call beginFakeDrag first.");
    VelocityTracker localVelocityTracker = this.mVelocityTracker;
    float f1 = this.mMaximumVelocity;
    localVelocityTracker.computeCurrentVelocity(1000, f1);
    int i = this.mActivePointerId;
    int j = (int)VelocityTrackerCompat.getXVelocity(localVelocityTracker, i);
    this.mPopulatePending = bool;
    int k = getWidth();
    int m = getScrollX();
    ItemInfo localItemInfo = infoForCurrentScrollPosition();
    int n = localItemInfo.position;
    float f2 = m;
    float f3 = k;
    float f4 = f2 / f3;
    int i1 = localItemInfo.offset;
    float f5 = f4 - i1;
    int i2 = localItemInfo.widthFactor;
    float f6 = f5 / i2;
    int i3 = this.mLastMotionX;
    int i4 = this.mInitialMotionX;
    int i5 = (int)(i3 - i4);
    int i6 = determineTargetPage(n, f6, j, i5);
    setCurrentItemInternal(i6, bool, bool, j);
    endDrag();
    this.mFakeDragging = null;
  }

  public boolean executeKeyEvent(KeyEvent paramKeyEvent)
  {
    int i = 1;
    boolean bool = null;
    if (paramKeyEvent.getAction() == 0)
      switch (paramKeyEvent.getKeyCode())
      {
      default:
      case 21:
      case 22:
      case 61:
      }
    while (true)
    {
      return bool;
      bool = arrowScroll(17);
      continue;
      bool = arrowScroll(66);
      continue;
      if (Build.VERSION.SDK_INT < 11)
        continue;
      if (KeyEventCompat.hasNoModifiers(paramKeyEvent))
      {
        bool = arrowScroll(2);
        continue;
      }
      if (!KeyEventCompat.hasModifiers(paramKeyEvent, i))
        continue;
      bool = arrowScroll(i);
    }
  }

  public void fakeDragBy(float paramFloat)
  {
    if (!this.mFakeDragging)
      throw new IllegalStateException("No fake drag in progress. Call beginFakeDrag first.");
    float f1 = this.mLastMotionX + paramFloat;
    this.mLastMotionX = f1;
    float f2 = getScrollX() - paramFloat;
    int i = getWidth();
    float f3 = i;
    int j = this.mFirstOffset;
    float f4 = f3 * j;
    float f5 = i;
    int k = this.mLastOffset;
    float f6 = f5 * k;
    ItemInfo localItemInfo1 = (ItemInfo)this.mItems.get(0);
    ArrayList localArrayList = this.mItems;
    int m = this.mItems.size();
    int n;
    n--;
    ItemInfo localItemInfo2 = (ItemInfo)localArrayList.get(m);
    if (localItemInfo1.position != 0)
    {
      int i1 = localItemInfo1.offset;
      float f7 = i;
      f4 = i1 * f7;
    }
    int i2 = localItemInfo2.position;
    int i3 = this.mAdapter.getCount();
    n--;
    if (i2 != i3)
    {
      int i4 = localItemInfo2.offset;
      float f8 = i;
      f6 = i4 * f8;
    }
    if (f2 < f4)
      f2 = f4;
    while (true)
    {
      int i5 = this.mLastMotionX;
      float f9 = (int)f2;
      float f10 = f2 - f9;
      float f11 = i5 + f10;
      this.mLastMotionX = f11;
      int i6 = (int)f2;
      int i7 = getScrollY();
      scrollTo(i6, i7);
      int i8 = (int)f2;
      pageScrolled(i8);
      long l1 = SystemClock.uptimeMillis();
      long l2 = this.mFakeDragBeginTime;
      int i9 = this.mLastMotionX;
      Object localObject;
      MotionEvent localMotionEvent = MotionEvent.obtain(l2, localObject, 2, i9, null, 0);
      this.mVelocityTracker.addMovement(localMotionEvent);
      localMotionEvent.recycle();
      return;
      if (f2 <= f6)
        continue;
      f2 = f6;
    }
  }

  protected ViewGroup.LayoutParams generateDefaultLayoutParams()
  {
    return new LayoutParams();
  }

  public ViewGroup.LayoutParams generateLayoutParams(AttributeSet paramAttributeSet)
  {
    Context localContext = getContext();
    return new LayoutParams(paramAttributeSet);
  }

  protected ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams paramLayoutParams)
  {
    return generateDefaultLayoutParams();
  }

  public PagerAdapter getAdapter()
  {
    return this.mAdapter;
  }

  protected int getChildDrawingOrder(int paramInt1, int paramInt2)
  {
    if (this.mDrawingOrder == 2);
    for (int i = paramInt1 + -1 - paramInt2; ; i = paramInt2)
      return ((LayoutParams)((View)this.mDrawingOrderedChildren.get(i)).getLayoutParams()).childIndex;
  }

  public int getCurrentItem()
  {
    return this.mCurItem;
  }

  public int getOffscreenPageLimit()
  {
    return this.mOffscreenPageLimit;
  }

  public int getPageMargin()
  {
    return this.mPageMargin;
  }

  ItemInfo infoForAnyChild(View paramView)
  {
    ViewParent localViewParent = paramView.getParent();
    boolean bool;
    if (localViewParent != this)
      if (localViewParent != null)
      {
        bool = localViewParent instanceof View;
        if (bool);
      }
      else
      {
        bool = false;
      }
    while (true)
    {
      return bool;
      paramView = (View)localViewParent;
      break;
      ItemInfo localItemInfo = infoForChild(paramView);
    }
  }

  ItemInfo infoForChild(View paramView)
  {
    int i = 0;
    int j = this.mItems.size();
    ItemInfo localItemInfo;
    if (i < j)
    {
      localItemInfo = (ItemInfo)this.mItems.get(i);
      PagerAdapter localPagerAdapter = this.mAdapter;
      Object localObject = localItemInfo.object;
      if (!localPagerAdapter.isViewFromObject(paramView, localObject));
    }
    while (true)
    {
      return localItemInfo;
      i++;
      break;
      int k = 0;
    }
  }

  ItemInfo infoForPosition(int paramInt)
  {
    int i = 0;
    int j = this.mItems.size();
    ItemInfo localItemInfo;
    if (i < j)
    {
      localItemInfo = (ItemInfo)this.mItems.get(i);
      if (localItemInfo.position != paramInt);
    }
    while (true)
    {
      return localItemInfo;
      i++;
      break;
      int k = 0;
    }
  }

  void initViewPager()
  {
    int i = 1;
    setWillNotDraw(null);
    setDescendantFocusability(262144);
    setFocusable(i);
    Context localContext = getContext();
    Interpolator localInterpolator = sInterpolator;
    Scroller localScroller = new Scroller(localContext, localInterpolator);
    this.mScroller = localScroller;
    ViewConfiguration localViewConfiguration = ViewConfiguration.get(localContext);
    int j = localContext.getResources().getDisplayMetrics().density;
    int k = ViewConfigurationCompat.getScaledPagingTouchSlop(localViewConfiguration);
    this.mTouchSlop = k;
    int m = (int)(1137180672 * j);
    this.mMinimumVelocity = m;
    int n = localViewConfiguration.getScaledMaximumFlingVelocity();
    this.mMaximumVelocity = n;
    EdgeEffectCompat localEdgeEffectCompat1 = new EdgeEffectCompat(localContext);
    this.mLeftEdge = localEdgeEffectCompat1;
    EdgeEffectCompat localEdgeEffectCompat2 = new EdgeEffectCompat(localContext);
    this.mRightEdge = localEdgeEffectCompat2;
    int i1 = (int)(1103626240 * j);
    this.mFlingDistance = i1;
    int i2 = (int)(1073741824 * j);
    this.mCloseEnough = i2;
    int i3 = (int)(1098907648 * j);
    this.mDefaultGutterSize = i3;
    MyAccessibilityDelegate localMyAccessibilityDelegate = new MyAccessibilityDelegate();
    ViewCompat.setAccessibilityDelegate(this, localMyAccessibilityDelegate);
    if (ViewCompat.getImportantForAccessibility(this) == 0)
      ViewCompat.setImportantForAccessibility(this, i);
  }

  public boolean isFakeDragging()
  {
    return this.mFakeDragging;
  }

  protected void onAttachedToWindow()
  {
    super.onAttachedToWindow();
    this.mFirstLayout = true;
  }

  protected void onDetachedFromWindow()
  {
    Runnable localRunnable = this.mEndScrollRunnable;
    removeCallbacks(localRunnable);
    super.onDetachedFromWindow();
  }

  protected void onDraw(Canvas paramCanvas)
  {
    super.onDraw(paramCanvas);
    int i;
    int j;
    float f3;
    Object localObject;
    ItemInfo localItemInfo;
    int m;
    int n;
    int i2;
    if ((this.mPageMargin > 0) && (this.mMarginDrawable != null) && (this.mItems.size() > 0) && (this.mAdapter != null))
    {
      i = getScrollX();
      j = getWidth();
      float f1 = this.mPageMargin;
      float f2 = j;
      f3 = f1 / f2;
      localObject = null;
      localItemInfo = (ItemInfo)this.mItems.get(0);
      int k = localItemInfo.offset;
      m = this.mItems.size();
      n = localItemInfo.position;
      ArrayList localArrayList1 = this.mItems;
      int i1 = m + -1;
      i2 = ((ItemInfo)localArrayList1.get(i1)).position;
    }
    for (int i3 = n; ; i3++)
    {
      float f7;
      float f4;
      if (i3 < i2)
      {
        while (true)
        {
          int i4 = localItemInfo.position;
          if ((i3 <= i4) || (localObject >= m))
            break;
          ArrayList localArrayList2 = this.mItems;
          localObject++;
          localItemInfo = (ItemInfo)localArrayList2.get(localObject);
        }
        int i5 = localItemInfo.position;
        if (i3 != i5)
          break label361;
        int i6 = localItemInfo.offset;
        int i7 = localItemInfo.widthFactor;
        float f5 = i6 + i7;
        float f6 = j;
        f7 = f5 * f6;
        int i8 = localItemInfo.offset;
        int i9 = localItemInfo.widthFactor;
        f4 = i8 + i9 + f3;
      }
      while (true)
      {
        float f8 = this.mPageMargin + f7;
        float f9 = i;
        if (f8 > f9)
        {
          Drawable localDrawable1 = this.mMarginDrawable;
          int i10 = (int)f7;
          int i11 = this.mTopPageBounds;
          int i12 = (int)(this.mPageMargin + f7 + 1056964608);
          int i13 = this.mBottomPageBounds;
          localDrawable1.setBounds(i10, i11, i12, i13);
          Drawable localDrawable2 = this.mMarginDrawable;
          Canvas localCanvas = paramCanvas;
          localDrawable2.draw(localCanvas);
        }
        float f10 = i + j;
        if (f7 <= f10)
          break;
        return;
        label361: float f11 = this.mAdapter.getPageWidth(i3);
        float f12 = f4 + f11;
        float f13 = j;
        f7 = f12 * f13;
        float f14 = f11 + f3;
        float f15 = f4 + f14;
      }
    }
  }

  public boolean onInterceptTouchEvent(MotionEvent paramMotionEvent)
  {
    int i = paramMotionEvent.getAction() & 0xFF;
    int j = 3;
    Object localObject1;
    if (i != j)
    {
      j = 1;
      if (i != j);
    }
    else
    {
      this.mIsBeingDragged = null;
      this.mIsUnableToDrag = null;
      this.mActivePointerId = -1;
      VelocityTracker localVelocityTracker1 = this.mVelocityTracker;
      if (localVelocityTracker1 != null)
      {
        this.mVelocityTracker.recycle();
        int k = 0;
        this.mVelocityTracker = k;
      }
      localObject1 = null;
    }
    VelocityTracker localVelocityTracker2;
    while (true)
    {
      return localObject1;
      if (i == 0)
        break;
      boolean bool1 = this.mIsBeingDragged;
      if (bool1)
      {
        bool1 = true;
        continue;
      }
      bool1 = this.mIsUnableToDrag;
      if (!bool1)
        break;
      localVelocityTracker2 = null;
    }
    switch (i)
    {
    default:
    case 2:
    case 0:
    case 6:
    }
    while (true)
    {
      localVelocityTracker2 = this.mVelocityTracker;
      if (localVelocityTracker2 == null)
      {
        localVelocityTracker2 = VelocityTracker.obtain();
        this.mVelocityTracker = localVelocityTracker2;
      }
      this.mVelocityTracker.addMovement(paramMotionEvent);
      boolean bool2 = this.mIsBeingDragged;
      break;
      int i6 = this.mActivePointerId;
      int m = -1;
      if (i6 == m)
        continue;
      int i7 = MotionEventCompat.findPointerIndex(paramMotionEvent, i6);
      float f6 = MotionEventCompat.getX(paramMotionEvent, i7);
      int n = this.mLastMotionX;
      float f7 = f6 - n;
      float f8 = Math.abs(f7);
      float f9 = MotionEventCompat.getY(paramMotionEvent, i7);
      int i1 = this.mInitialMotionY;
      float f10 = Math.abs(f9 - i1);
      float f1 = f7 < null;
      if (f1 != 0)
      {
        int i2 = this.mLastMotionX;
        boolean bool3 = isGutterDrag(i2, f7);
        if (!bool3)
        {
          int i8 = (int)f7;
          int i9 = (int)f6;
          int i10 = (int)f9;
          Object localObject2 = this;
          ViewPager localViewPager = this;
          localObject2 = ((ViewPager)localObject2).canScroll(localViewPager, null, i8, i9, i10);
          if (localObject2 != 0)
          {
            this.mLastMotionX = f6;
            this.mLastMotionY = f9;
            this.mIsUnableToDrag = true;
            localObject2 = null;
            break;
          }
        }
      }
      float f2 = this.mTouchSlop;
      f2 = f8 < f2;
      label388: boolean bool4;
      if (f2 > 0)
      {
        f2 = 1056964608 * f8 < f10;
        if (f2 > 0)
        {
          this.mIsBeingDragged = true;
          setScrollState(1);
          f2 = f7 < null;
          if (f2 > 0)
          {
            int i3 = this.mInitialMotionX;
            float f11 = this.mTouchSlop;
            float f3;
            i3 += f11;
            this.mLastMotionX = f3;
            this.mLastMotionY = f9;
            bool4 = true;
            setScrollingCacheEnabled(bool4);
          }
        }
      }
      while (true)
      {
        bool4 = this.mIsBeingDragged;
        if (!bool4)
          break;
        boolean bool5 = performDrag(f6);
        if (!bool5)
          break;
        ViewCompat.postInvalidateOnAnimation(this);
        break;
        int i4 = this.mInitialMotionX;
        float f12 = this.mTouchSlop;
        i4 -= f12;
        break label388;
        float f4 = this.mTouchSlop;
        f4 = f10 < f4;
        if (f4 <= 0)
          continue;
        boolean bool6 = true;
        this.mIsUnableToDrag = bool6;
      }
      float f5 = paramMotionEvent.getX();
      this.mInitialMotionX = f5;
      this.mLastMotionX = f5;
      f5 = paramMotionEvent.getY();
      this.mInitialMotionY = f5;
      this.mLastMotionY = f5;
      int i5 = MotionEventCompat.getPointerId(paramMotionEvent, 0);
      this.mActivePointerId = i5;
      this.mIsUnableToDrag = null;
      this.mScroller.computeScrollOffset();
      i5 = this.mScrollState;
      if (i5 == 2)
      {
        i5 = this.mScroller.getFinalX();
        int i11 = this.mScroller.getCurrX();
        i5 = Math.abs(i5 - i11);
        int i12 = this.mCloseEnough;
        if (i5 > i12)
        {
          this.mScroller.abortAnimation();
          this.mPopulatePending = null;
          populate();
          this.mIsBeingDragged = true;
          i5 = 1;
          setScrollState(i5);
          continue;
        }
      }
      completeScroll(null);
      Object localObject3 = null;
      this.mIsBeingDragged = localObject3;
      continue;
      onSecondaryPointerUp(paramMotionEvent);
    }
  }

  protected void onLayout(boolean paramBoolean, int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    boolean bool = true;
    this.mInLayout = bool;
    populate();
    Object localObject1 = null;
    this.mInLayout = localObject1;
    int i = getChildCount();
    int j = paramInt3 - paramInt1;
    int k = paramInt4 - paramInt2;
    int m = getPaddingLeft();
    int n = getPaddingTop();
    int i1 = getPaddingRight();
    int i2 = getPaddingBottom();
    int i3 = getScrollX();
    Object localObject2 = null;
    int i4 = 0;
    View localView;
    LayoutParams localLayoutParams;
    int i7;
    label192: int i9;
    if (i4 < i)
    {
      localView = getChildAt(i4);
      int i5 = localView.getVisibility();
      int i6 = 8;
      int i8;
      if (i5 != i6)
      {
        localLayoutParams = (LayoutParams)localView.getLayoutParams();
        Object localObject3 = null;
        Object localObject4 = null;
        if (localLayoutParams.isDecor)
        {
          int i10 = localLayoutParams.gravity & 0x7;
          int i11 = localLayoutParams.gravity & 0x70;
          switch (i10)
          {
          case 2:
          case 4:
          default:
            i7 = m;
            switch (i11)
            {
            default:
              i8 = n;
            case 48:
            case 16:
            case 80:
            }
          case 3:
          case 1:
          case 5:
          }
        }
      }
      while (true)
      {
        i7 += i3;
        int i12 = localView.getMeasuredWidth() + i7;
        int i13 = localView.getMeasuredHeight() + i8;
        int i14 = i12;
        int i15 = i13;
        localView.layout(i7, i8, i14, i15);
        localObject2++;
        i4++;
        break;
        i7 = m;
        int i16 = localView.getMeasuredWidth();
        m += i16;
        break label192;
        int i17 = localView.getMeasuredWidth();
        i7 = Math.max((j - i17) / 2, m);
        break label192;
        int i18 = j - i1;
        int i19 = localView.getMeasuredWidth();
        i7 = i18 - i19;
        int i20 = localView.getMeasuredWidth();
        i1 += i20;
        break label192;
        i8 = n;
        int i21 = localView.getMeasuredHeight();
        n += i21;
        continue;
        int i22 = localView.getMeasuredHeight();
        int i23 = (k - i22) / 2;
        int i24 = n;
        i9 = Math.max(i23, i24);
        continue;
        int i25 = k - i2;
        int i26 = localView.getMeasuredHeight();
        i9 = i25 - i26;
        int i27 = localView.getMeasuredHeight();
        i2 += i27;
      }
    }
    for (i4 = null; i4 < i; i4++)
    {
      localView = getChildAt(i4);
      int i28 = localView.getVisibility();
      int i29 = 8;
      if (i28 == i29)
        continue;
      localLayoutParams = (LayoutParams)localView.getLayoutParams();
      if (localLayoutParams.isDecor)
        continue;
      ItemInfo localItemInfo = infoForChild(localView);
      if (localItemInfo == null)
        continue;
      int i30 = j;
      int i31 = localItemInfo.offset;
      int i32 = (int)(i30 * i31);
      i7 = m + i32;
      i9 = n;
      if (localLayoutParams.needsMeasure)
      {
        Object localObject5 = null;
        localLayoutParams.needsMeasure = localObject5;
        int i33 = j - m - i1;
        int i34 = localLayoutParams.widthFactor;
        int i35 = View.MeasureSpec.makeMeasureSpec((int)(i33 * i34), 1073741824);
        int i36 = View.MeasureSpec.makeMeasureSpec(k - n - i2, 1073741824);
        int i37 = i35;
        localView.measure(i37, i36);
      }
      int i38 = localView.getMeasuredWidth() + i7;
      int i39 = localView.getMeasuredHeight() + i9;
      int i40 = i38;
      int i41 = i39;
      localView.layout(i7, i9, i40, i41);
    }
    int i42 = n;
    this.mTopPageBounds = i42;
    int i43 = k - i2;
    this.mBottomPageBounds = i43;
    this.mDecorChildCount = localObject2;
    Object localObject6 = null;
    this.mFirstLayout = localObject6;
  }

  protected void onMeasure(int paramInt1, int paramInt2)
  {
    int i = 0;
    int j = paramInt1;
    int k = getDefaultSize(i, j);
    int m = 0;
    int n = paramInt2;
    int i1 = getDefaultSize(m, n);
    ViewPager localViewPager = this;
    int i2 = k;
    int i3 = i1;
    localViewPager.setMeasuredDimension(i2, i3);
    int i4 = getMeasuredWidth();
    int i5 = i4 / 10;
    int i6 = this.mDefaultGutterSize;
    int i7 = Math.min(i5, i6);
    this.mGutterSize = i7;
    int i8 = getPaddingLeft();
    int i9 = i4 - i8;
    int i10 = getPaddingRight();
    int i11 = i9 - i10;
    int i12 = getMeasuredHeight();
    int i13 = getPaddingTop();
    int i14 = i12 - i13;
    int i15 = getPaddingBottom();
    int i16 = i14 - i15;
    int i17 = getChildCount();
    int i18 = 0;
    int i19 = i17;
    View localView;
    LayoutParams localLayoutParams;
    if (i18 < i19)
    {
      localView = getChildAt(i18);
      int i20 = localView.getVisibility();
      int i21 = 8;
      int i25;
      if (i20 != i21)
      {
        localLayoutParams = (LayoutParams)localView.getLayoutParams();
        if ((localLayoutParams != null) && (localLayoutParams.isDecor))
        {
          int i22 = localLayoutParams.gravity & 0x7;
          int i23 = localLayoutParams.gravity & 0x70;
          int i24 = -2147483648;
          i25 = -2147483648;
          int i26 = i23;
          int i27 = 48;
          if (i26 != i27)
          {
            int i28 = i23;
            int i29 = 80;
            if (i28 != i29)
              break label477;
          }
          int i30 = 1;
          label272: int i31 = 3;
          if (i22 != i31)
          {
            int i32 = 5;
            if (i22 != i32)
              break label483;
          }
          int i33 = 1;
          label295: if (i30 == null)
            break label489;
          i24 = 1073741824;
          label305: int i34 = i11;
          int i35 = i16;
          int i36 = localLayoutParams.width;
          int i37 = 65534;
          if (i36 != i37)
          {
            i24 = 1073741824;
            int i38 = localLayoutParams.width;
            int i39 = 65535;
            if (i38 != i39)
              i34 = localLayoutParams.width;
          }
          int i40 = localLayoutParams.height;
          int i41 = 65534;
          if (i40 != i41)
          {
            i25 = 1073741824;
            int i42 = localLayoutParams.height;
            int i43 = 65535;
            if (i42 != i43)
              i35 = localLayoutParams.height;
          }
          int i44 = i34;
          int i45 = i24;
          int i46 = View.MeasureSpec.makeMeasureSpec(i44, i45);
          int i47 = View.MeasureSpec.makeMeasureSpec(i35, i25);
          int i48 = i46;
          localView.measure(i48, i47);
          if (i30 == null)
            break label502;
          int i49 = localView.getMeasuredHeight();
          i16 -= i49;
        }
      }
      while (true)
      {
        i18++;
        break;
        label477: Object localObject1 = null;
        break label272;
        label483: Object localObject2 = null;
        break label295;
        label489: if (localObject2 == null)
          break label305;
        i25 = 1073741824;
        break label305;
        label502: if (localObject2 == null)
          continue;
        int i50 = localView.getMeasuredWidth();
        i11 -= i50;
      }
    }
    int i51 = 1073741824;
    int i52 = View.MeasureSpec.makeMeasureSpec(i11, i51);
    this.mChildWidthMeasureSpec = i52;
    int i53 = 1073741824;
    int i54 = View.MeasureSpec.makeMeasureSpec(i16, i53);
    this.mChildHeightMeasureSpec = i54;
    boolean bool = true;
    this.mInLayout = bool;
    populate();
    Object localObject3 = null;
    this.mInLayout = localObject3;
    i17 = getChildCount();
    for (i18 = null; ; i18++)
    {
      int i55 = i17;
      if (i18 >= i55)
        break;
      localView = getChildAt(i18);
      int i56 = localView.getVisibility();
      int i57 = 8;
      if (i56 == i57)
        continue;
      localLayoutParams = (LayoutParams)localView.getLayoutParams();
      if ((localLayoutParams != null) && (localLayoutParams.isDecor))
        continue;
      int i58 = i11;
      int i59 = localLayoutParams.widthFactor;
      int i60 = View.MeasureSpec.makeMeasureSpec((int)(i58 * i59), 1073741824);
      int i61 = this.mChildHeightMeasureSpec;
      int i62 = i60;
      int i63 = i61;
      localView.measure(i62, i63);
    }
  }

  protected void onPageScrolled(int paramInt1, float paramFloat, int paramInt2)
  {
    int i;
    int n;
    int i1;
    View localView;
    if (this.mDecorChildCount > 0)
    {
      i = getScrollX();
      int j = getPaddingLeft();
      int k = getPaddingRight();
      int m = getWidth();
      n = getChildCount();
      i1 = 0;
      while (i1 < n)
      {
        localView = getChildAt(i1);
        LayoutParams localLayoutParams = (LayoutParams)localView.getLayoutParams();
        if (!localLayoutParams.isDecor)
        {
          i1++;
          continue;
        }
        int i2 = localLayoutParams.gravity & 0x7;
        Object localObject = null;
        int i3;
        switch (i2)
        {
        case 2:
        case 4:
        default:
          i3 = j;
        case 3:
        case 1:
        case 5:
        }
        while (true)
        {
          int i4 = i3 + i;
          int i5 = localView.getLeft();
          int i6 = i3 - i5;
          if (i6 == 0)
            break;
          localView.offsetLeftAndRight(i6);
          break;
          i3 = j;
          int i7 = localView.getWidth();
          j += i7;
          continue;
          int i8 = localView.getMeasuredWidth();
          i3 = Math.max((m - i8) / 2, j);
          continue;
          int i9 = m - k;
          int i10 = localView.getMeasuredWidth();
          i3 = i9 - i10;
          int i11 = localView.getMeasuredWidth();
          int i12 = k + i11;
        }
      }
    }
    if (this.mOnPageChangeListener != null)
    {
      OnPageChangeListener localOnPageChangeListener1 = this.mOnPageChangeListener;
      int i13 = paramInt1;
      int i14 = paramFloat;
      int i15 = paramInt2;
      localOnPageChangeListener1.onPageScrolled(i13, i14, i15);
    }
    if (this.mInternalPageChangeListener != null)
    {
      OnPageChangeListener localOnPageChangeListener2 = this.mInternalPageChangeListener;
      int i16 = paramInt1;
      int i17 = paramFloat;
      int i18 = paramInt2;
      localOnPageChangeListener2.onPageScrolled(i16, i17, i18);
    }
    if (this.mPageTransformer != null)
    {
      i = getScrollX();
      n = getChildCount();
      i1 = null;
      if (i1 < n)
      {
        localView = getChildAt(i1);
        if (((LayoutParams)localView.getLayoutParams()).isDecor);
        while (true)
        {
          i1++;
          break;
          float f1 = localView.getLeft() - i;
          int i19 = getWidth();
          float f2 = f1 / i19;
          this.mPageTransformer.transformPage(localView, f2);
        }
      }
    }
    this.mCalledSuper = true;
  }

  protected boolean onRequestFocusInDescendants(int paramInt, Rect paramRect)
  {
    int i = getChildCount();
    int j = paramInt & 0x2;
    int m;
    int n;
    int i1;
    int i2;
    label28: boolean bool;
    if (j != 0)
    {
      m = 0;
      n = 1;
      i1 = i;
      i2 = m;
      if (i2 == i1)
        break label135;
      View localView = getChildAt(i2);
      int k = localView.getVisibility();
      if (k != 0)
        break label125;
      ItemInfo localItemInfo = infoForChild(localView);
      if (localItemInfo == null)
        break label125;
      k = localItemInfo.position;
      int i3 = this.mCurItem;
      if (k != i3)
        break label125;
      bool = localView.requestFocus(paramInt, paramRect);
      if (!bool)
        break label125;
      bool = true;
    }
    while (true)
    {
      return bool;
      m = i + -1;
      n = -1;
      i1 = -1;
      break;
      label125: i2 += n;
      break label28;
      label135: Object localObject = null;
    }
  }

  public void onRestoreInstanceState(Parcelable paramParcelable)
  {
    if (!(paramParcelable instanceof SavedState))
      super.onRestoreInstanceState(paramParcelable);
    while (true)
    {
      return;
      SavedState localSavedState = (SavedState)paramParcelable;
      Parcelable localParcelable1 = localSavedState.getSuperState();
      super.onRestoreInstanceState(localParcelable1);
      if (this.mAdapter != null)
      {
        PagerAdapter localPagerAdapter = this.mAdapter;
        Parcelable localParcelable2 = localSavedState.adapterState;
        ClassLoader localClassLoader1 = localSavedState.loader;
        localPagerAdapter.restoreState(localParcelable2, localClassLoader1);
        int i = localSavedState.position;
        setCurrentItemInternal(i, null, true);
        continue;
      }
      int j = localSavedState.position;
      this.mRestoredCurItem = j;
      Parcelable localParcelable3 = localSavedState.adapterState;
      this.mRestoredAdapterState = localParcelable3;
      ClassLoader localClassLoader2 = localSavedState.loader;
      this.mRestoredClassLoader = localClassLoader2;
    }
  }

  public Parcelable onSaveInstanceState()
  {
    Parcelable localParcelable1 = super.onSaveInstanceState();
    SavedState localSavedState = new SavedState();
    int i = this.mCurItem;
    localSavedState.position = i;
    if (this.mAdapter != null)
    {
      Parcelable localParcelable2 = this.mAdapter.saveState();
      localSavedState.adapterState = localParcelable2;
    }
    return localSavedState;
  }

  protected void onSizeChanged(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    super.onSizeChanged(paramInt1, paramInt2, paramInt3, paramInt4);
    if (paramInt1 != paramInt3)
    {
      int i = this.mPageMargin;
      int j = this.mPageMargin;
      recomputeScrollPosition(paramInt1, paramInt3, i, j);
    }
  }

  public boolean onTouchEvent(MotionEvent paramMotionEvent)
  {
    boolean bool1 = this.mFakeDragging;
    if (bool1)
      bool1 = true;
    while (true)
    {
      return bool1;
      int i = paramMotionEvent.getAction();
      if (i == 0)
      {
        i = paramMotionEvent.getEdgeFlags();
        if (i != 0)
        {
          localObject1 = null;
          continue;
        }
      }
      localObject1 = this.mAdapter;
      if (localObject1 != null)
      {
        localObject1 = this.mAdapter.getCount();
        if (localObject1 != 0)
          break;
      }
      localObject1 = null;
    }
    Object localObject1 = this.mVelocityTracker;
    if (localObject1 == null)
    {
      localObject1 = VelocityTracker.obtain();
      Object localObject2 = localObject1;
      this.mVelocityTracker = localObject2;
    }
    VelocityTracker localVelocityTracker1 = this.mVelocityTracker;
    MotionEvent localMotionEvent1 = paramMotionEvent;
    localVelocityTracker1.addMovement(localMotionEvent1);
    int i12 = paramMotionEvent.getAction();
    Object localObject3 = null;
    int j = i12 & 0xFF;
    switch (j)
    {
    case 4:
    default:
    case 0:
    case 2:
    case 1:
    case 3:
    case 5:
    case 6:
    }
    while (true)
    {
      if (localObject3 != null)
        ViewCompat.postInvalidateOnAnimation(this);
      j = 1;
      break;
      this.mScroller.abortAnimation();
      Object localObject4 = null;
      this.mPopulatePending = localObject4;
      populate();
      boolean bool9 = true;
      this.mIsBeingDragged = bool9;
      ViewPager localViewPager1 = this;
      int i14 = 1;
      localViewPager1.setScrollState(i14);
      float f1 = paramMotionEvent.getX();
      int i15 = f1;
      this.mInitialMotionX = i15;
      int i16 = f1;
      this.mLastMotionX = i16;
      f1 = paramMotionEvent.getY();
      int i17 = f1;
      this.mInitialMotionY = i17;
      int i18 = f1;
      this.mLastMotionY = i18;
      MotionEvent localMotionEvent2 = paramMotionEvent;
      int i19 = 0;
      int k = MotionEventCompat.getPointerId(localMotionEvent2, i19);
      int i20 = k;
      this.mActivePointerId = i20;
      continue;
      boolean bool2 = this.mIsBeingDragged;
      float f10;
      float f4;
      if (!bool2)
      {
        int m = this.mActivePointerId;
        MotionEvent localMotionEvent3 = paramMotionEvent;
        int i21 = m;
        int i22 = MotionEventCompat.findPointerIndex(localMotionEvent3, i21);
        float f8 = MotionEventCompat.getX(paramMotionEvent, i22);
        int n = this.mLastMotionX;
        float f9 = Math.abs(f8 - n);
        f10 = MotionEventCompat.getY(paramMotionEvent, i22);
        int i1 = this.mLastMotionY;
        float f11 = Math.abs(f10 - i1);
        int i2 = this.mTouchSlop;
        float f2 = f9 < i2;
        if (f2 > 0)
        {
          f2 = f9 < f11;
          if (f2 > 0)
          {
            boolean bool10 = true;
            this.mIsBeingDragged = bool10;
            int i3 = this.mInitialMotionX;
            float f3 = f8 - i3 < null;
            if (f3 <= 0)
              break label532;
            int i4 = this.mInitialMotionX;
            int i23 = this.mTouchSlop;
            i4 += i23;
          }
        }
      }
      while (true)
      {
        int i24 = f4;
        this.mLastMotionX = i24;
        int i25 = f10;
        this.mLastMotionY = i25;
        ViewPager localViewPager2 = this;
        int i26 = 1;
        localViewPager2.setScrollState(i26);
        boolean bool3 = true;
        ViewPager localViewPager3 = this;
        boolean bool11 = bool3;
        localViewPager3.setScrollingCacheEnabled(bool11);
        bool3 = this.mIsBeingDragged;
        if (!bool3)
          break;
        int i5 = this.mActivePointerId;
        MotionEvent localMotionEvent4 = paramMotionEvent;
        int i27 = i5;
        int i28 = MotionEventCompat.findPointerIndex(localMotionEvent4, i27);
        float f12 = MotionEventCompat.getX(paramMotionEvent, i28);
        ViewPager localViewPager4 = this;
        int i29 = f12;
        boolean bool4 = localViewPager4.performDrag(i29);
        int i13 = localObject3 | bool4;
        break;
        label532: int i6 = this.mInitialMotionX;
        int i30 = this.mTouchSlop;
        float f5;
        i6 -= i30;
      }
      boolean bool5 = this.mIsBeingDragged;
      if (!bool5)
        continue;
      VelocityTracker localVelocityTracker2 = this.mVelocityTracker;
      int i31 = this.mMaximumVelocity;
      VelocityTracker localVelocityTracker3 = localVelocityTracker2;
      int i32 = 1000;
      int i33 = i31;
      localVelocityTracker3.computeCurrentVelocity(i32, i33);
      int i7 = this.mActivePointerId;
      VelocityTracker localVelocityTracker4 = localVelocityTracker2;
      int i34 = i7;
      int i35 = (int)VelocityTrackerCompat.getXVelocity(localVelocityTracker4, i34);
      boolean bool12 = true;
      this.mPopulatePending = bool12;
      int i36 = getWidth();
      int i37 = getScrollX();
      ItemInfo localItemInfo = infoForCurrentScrollPosition();
      int i38 = localItemInfo.position;
      i7 = i37;
      int i39 = i36;
      float f6;
      i7 /= i39;
      int i40 = localItemInfo.offset;
      f6 -= i40;
      int i41 = localItemInfo.widthFactor;
      float f13 = f6 / i41;
      int i8 = this.mActivePointerId;
      MotionEvent localMotionEvent5 = paramMotionEvent;
      int i42 = i8;
      int i43 = MotionEventCompat.findPointerIndex(localMotionEvent5, i42);
      float f14 = MotionEventCompat.getX(paramMotionEvent, i43);
      int i9 = this.mInitialMotionX;
      int i44 = (int)(f14 - i9);
      ViewPager localViewPager5 = this;
      int i45 = i44;
      int i46 = localViewPager5.determineTargetPage(i38, f13, i35, i45);
      ViewPager localViewPager6 = this;
      boolean bool13 = true;
      boolean bool14 = true;
      localViewPager6.setCurrentItemInternal(i46, bool13, bool14, i35);
      int i47 = 65535;
      this.mActivePointerId = i47;
      endDrag();
      boolean bool6 = this.mLeftEdge.onRelease();
      boolean bool15 = this.mRightEdge.onRelease();
      boolean bool8 = bool6 | bool15;
      continue;
      bool6 = this.mIsBeingDragged;
      if (!bool6)
        continue;
      int i10 = this.mCurItem;
      ViewPager localViewPager7 = this;
      int i48 = i10;
      boolean bool16 = true;
      int i49 = 0;
      boolean bool17 = null;
      localViewPager7.scrollToItem(i48, bool16, i49, bool17);
      int i50 = 65535;
      this.mActivePointerId = i50;
      endDrag();
      boolean bool7 = this.mLeftEdge.onRelease();
      boolean bool18 = this.mRightEdge.onRelease();
      bool8 = bool7 | bool18;
      continue;
      int i51 = MotionEventCompat.getActionIndex(paramMotionEvent);
      int i52 = MotionEventCompat.getX(paramMotionEvent, i51);
      this.mLastMotionX = i52;
      int i11 = MotionEventCompat.getPointerId(paramMotionEvent, i51);
      int i53 = i11;
      this.mActivePointerId = i53;
      continue;
      onSecondaryPointerUp(paramMotionEvent);
      i11 = this.mActivePointerId;
      MotionEvent localMotionEvent6 = paramMotionEvent;
      int i54 = i11;
      i11 = MotionEventCompat.findPointerIndex(localMotionEvent6, i54);
      MotionEvent localMotionEvent7 = paramMotionEvent;
      int i55 = i11;
      float f7 = MotionEventCompat.getX(localMotionEvent7, i55);
      int i56 = f7;
      this.mLastMotionX = i56;
    }
  }

  boolean pageLeft()
  {
    boolean bool = true;
    if (this.mCurItem > 0)
    {
      int i = this.mCurItem;
      int j;
      j--;
      setCurrentItem(i, bool);
    }
    while (true)
    {
      return bool;
      Object localObject = null;
    }
  }

  boolean pageRight()
  {
    boolean bool = true;
    if (this.mAdapter != null)
    {
      int i = this.mCurItem;
      int j = this.mAdapter.getCount();
      int k;
      k--;
      if (i < j)
      {
        int m = this.mCurItem;
        int n;
        n++;
        setCurrentItem(m, bool);
      }
    }
    while (true)
    {
      return bool;
      Object localObject = null;
    }
  }

  void populate()
  {
    int i = this.mCurItem;
    populate(i);
  }

  void populate(int paramInt)
  {
    ItemInfo localItemInfo1 = null;
    int i = this.mCurItem;
    int i13 = i;
    int i14 = paramInt;
    if (i13 != i14)
    {
      i = this.mCurItem;
      ViewPager localViewPager1 = this;
      int i15 = i;
      localItemInfo1 = localViewPager1.infoForPosition(i15);
      int i16 = paramInt;
      this.mCurItem = i16;
    }
    PagerAdapter localPagerAdapter1 = this.mAdapter;
    if (localPagerAdapter1 == null);
    label309: label508: int i42;
    label428: label559: View localView1;
    label707: label719: Object localObject6;
    label829: label835: label976: label982: label1264: label1269: label1275: 
    do
    {
      IBinder localIBinder;
      do
      {
        boolean bool1;
        do
        {
          return;
          bool1 = this.mPopulatePending;
        }
        while (bool1);
        localIBinder = getWindowToken();
      }
      while (localIBinder == null);
      PagerAdapter localPagerAdapter2 = this.mAdapter;
      ViewPager localViewPager2 = this;
      localPagerAdapter2.startUpdate(localViewPager2);
      int i17 = this.mOffscreenPageLimit;
      int i18 = this.mCurItem - i17;
      int i20 = Math.max(0, i18);
      int i21 = this.mAdapter.getCount();
      int j = i21 + -1;
      i18 = this.mCurItem + i17;
      int i22 = Math.min(j, i18);
      int i23 = 0;
      int i24 = 0;
      int k = this.mItems.size();
      int i25 = k;
      ItemInfo localItemInfo8;
      Object localObject5;
      if (i24 < i25)
      {
        localItemInfo8 = (ItemInfo)this.mItems.get(i24);
        k = localItemInfo8.position;
        i18 = this.mCurItem;
        int i27 = k;
        int i28 = i18;
        if (i27 < i28)
          break label707;
        k = localItemInfo8.position;
        i18 = this.mCurItem;
        int i29 = k;
        int i30 = i18;
        if (i29 == i30)
          localObject5 = localItemInfo8;
      }
      if ((localObject5 == 0) && (i21 > 0))
      {
        k = this.mCurItem;
        ViewPager localViewPager3 = this;
        int i31 = k;
        localObject5 = localViewPager3.addNewItem(i31, i24);
      }
      Object localObject7;
      int i32;
      int i33;
      int i36;
      Object localObject4;
      int i40;
      if (localObject5 != 0)
      {
        localObject7 = null;
        i32 = i24 + -1;
        if (i32 >= 0)
        {
          ItemInfo localItemInfo2 = (ItemInfo)this.mItems.get(i32);
          localItemInfo8 = localItemInfo2;
          int i19 = ((ItemInfo)localObject5).widthFactor;
          float f4 = 1073741824 - i19;
          int m = this.mCurItem;
          i33 = m + -1;
          if (i33 >= 0)
          {
            f1 = localObject7 < f4;
            if (f1 < 0)
              break label835;
            int i34 = i33;
            int i35 = i20;
            if (i34 >= i35)
              break label835;
            if (localItemInfo8 != 0)
              break label719;
          }
          i36 = ((ItemInfo)localObject5).widthFactor;
          i32 = i24 + 1;
          float f1 = i36 < 1073741824;
          if (f1 < 0)
          {
            int n = this.mItems.size();
            int i37 = n;
            if (i32 >= i37)
              break label976;
            ItemInfo localItemInfo3 = (ItemInfo)this.mItems.get(i32);
            localItemInfo8 = localItemInfo3;
            int i1 = this.mCurItem;
            i33 = i1 + 1;
            if (i33 < i21)
            {
              float f2 = i36 < 1073741824;
              if ((f2 < 0) || (i33 <= i22))
                break label1105;
              if (localItemInfo8 != 0)
                break label982;
            }
          }
          ViewPager localViewPager4 = this;
          ItemInfo localItemInfo9 = localItemInfo1;
          localViewPager4.calculatePageOffsets((ItemInfo)localObject5, i24, localItemInfo9);
        }
      }
      else
      {
        localObject4 = this.mAdapter;
        int i38 = this.mCurItem;
        if (localObject5 == 0)
          break label1264;
        Object localObject1 = ((ItemInfo)localObject5).object;
        Object localObject8 = localObject4;
        ViewPager localViewPager5 = this;
        int i39 = i38;
        Object localObject9 = localObject1;
        localObject8.setPrimaryItem(localViewPager5, i39, localObject9);
        PagerAdapter localPagerAdapter3 = this.mAdapter;
        ViewPager localViewPager6 = this;
        localPagerAdapter3.finishUpdate(localViewPager6);
        if (this.mDrawingOrder == 0)
          break label1269;
        i40 = 1;
        if (i40 != null)
        {
          if (this.mDrawingOrderedChildren != null)
            break label1275;
          ArrayList localArrayList1 = new ArrayList();
          this.mDrawingOrderedChildren = localArrayList1;
        }
      }
      Object localObject10;
      while (true)
      {
        int i41 = getChildCount();
        for (i42 = null; i42 < i41; i42++)
        {
          localView1 = getChildAt(i42);
          LayoutParams localLayoutParams = (LayoutParams)localView1.getLayoutParams();
          localLayoutParams.childIndex = i42;
          if ((!localLayoutParams.isDecor) && (localLayoutParams.widthFactor == null))
          {
            localItemInfo8 = infoForChild(localView1);
            if (localItemInfo8 != null)
            {
              int i43 = localItemInfo8.widthFactor;
              localLayoutParams.widthFactor = i43;
              int i44 = localItemInfo8.position;
              localLayoutParams.position = i44;
            }
          }
          if (i40 == null)
            continue;
          this.mDrawingOrderedChildren.add(localView1);
        }
        i24++;
        break;
        int i26 = 0;
        break label309;
        int i2 = i26.position;
        int i45 = i33;
        int i46 = i2;
        Object localObject2;
        if (i45 == i46)
        {
          boolean bool2 = i26.scrolling;
          if (!bool2)
          {
            this.mItems.remove(i32);
            localObject2 = this.mAdapter;
            localObject4 = i26.object;
            Object localObject11 = localObject2;
            ViewPager localViewPager7 = this;
            int i47 = i33;
            Object localObject12 = localObject4;
            localObject11.destroyItem(localViewPager7, i47, localObject12);
            i32--;
            i24--;
            if (i32 < 0)
              break label829;
            localObject2 = (ItemInfo)this.mItems.get(i32);
          }
        }
        for (localObject6 = localObject2; ; localObject6 = null)
        {
          i33--;
          break;
        }
        if (localObject6 != 0)
        {
          int i3 = ((ItemInfo)localObject6).position;
          int i48 = i33;
          int i49 = i3;
          if (i48 == i49)
          {
            int i4 = ((ItemInfo)localObject6).widthFactor;
            f3 = localObject7 + i4;
            i32--;
            ItemInfo localItemInfo4;
            if (i32 >= 0)
              localItemInfo4 = (ItemInfo)this.mItems.get(i32);
            for (localObject6 = localItemInfo4; ; localObject6 = null)
              break;
          }
        }
        int i5 = i32 + 1;
        ViewPager localViewPager8 = this;
        int i50 = i33;
        int i51 = i5;
        localObject6 = localViewPager8.addNewItem(i50, i51);
        int i6 = ((ItemInfo)localObject6).widthFactor;
        float f3 = f3 + i6;
        i24++;
        ItemInfo localItemInfo5;
        if (i32 >= 0)
          localItemInfo5 = (ItemInfo)this.mItems.get(i32);
        for (localObject6 = localItemInfo5; ; localObject6 = null)
          break;
        localObject6 = null;
        break label428;
        int i7 = ((ItemInfo)localObject6).position;
        int i52 = i33;
        int i53 = i7;
        Object localObject3;
        if (i52 == i53)
        {
          boolean bool3 = ((ItemInfo)localObject6).scrolling;
          if (!bool3)
          {
            this.mItems.remove(i32);
            localObject3 = this.mAdapter;
            localObject4 = ((ItemInfo)localObject6).object;
            Object localObject13 = localObject3;
            ViewPager localViewPager9 = this;
            int i54 = i33;
            Object localObject14 = localObject4;
            localObject13.destroyItem(localViewPager9, i54, localObject14);
            localObject3 = this.mItems.size();
            int i55 = localObject3;
            if (i32 >= i55)
              break label1099;
            localObject3 = (ItemInfo)this.mItems.get(i32);
          }
        }
        for (localObject6 = localObject3; ; localObject6 = null)
        {
          i33++;
          break;
        }
        float f5;
        if (localObject6 != 0)
        {
          int i8 = ((ItemInfo)localObject6).position;
          int i56 = i33;
          int i57 = i8;
          if (i56 == i57)
          {
            int i9 = ((ItemInfo)localObject6).widthFactor;
            i36 += i9;
            i32++;
            int i10 = this.mItems.size();
            int i58 = i10;
            ItemInfo localItemInfo6;
            if (i32 < i58)
              localItemInfo6 = (ItemInfo)this.mItems.get(i32);
            for (localObject6 = localItemInfo6; ; localObject6 = null)
              break;
          }
        }
        ViewPager localViewPager10 = this;
        int i59 = i33;
        localObject6 = localViewPager10.addNewItem(i59, i32);
        i32++;
        int i11 = ((ItemInfo)localObject6).widthFactor;
        f5 += i11;
        int i12 = this.mItems.size();
        int i60 = i12;
        if (i32 < i60)
          localItemInfo7 = (ItemInfo)this.mItems.get(i32);
        for (localObject6 = localItemInfo7; ; localObject6 = null)
          break;
        ItemInfo localItemInfo7 = null;
        break label508;
        localObject10 = null;
        break label559;
        this.mDrawingOrderedChildren.clear();
      }
      if (localObject10 == null)
        continue;
      ArrayList localArrayList2 = this.mDrawingOrderedChildren;
      ViewPositionComparator localViewPositionComparator = sPositionComparator;
      Collections.sort(localArrayList2, localViewPositionComparator);
    }
    while (!hasFocus());
    label1099: label1105: View localView2 = findFocus();
    if (localView2 != null)
      localObject6 = infoForAnyChild(localView2);
    while (true)
    {
      if (localObject6 != 0)
      {
        int i61 = ((ItemInfo)localObject6).position;
        int i62 = this.mCurItem;
        int i63 = i61;
        int i64 = i62;
        if (i63 == i64)
          break;
      }
      for (i42 = null; ; i42++)
      {
        int i65 = getChildCount();
        if (i42 >= i65)
          break;
        localView1 = getChildAt(i42);
        localObject6 = infoForChild(localView1);
        if (localObject6 == null)
          continue;
        int i66 = ((ItemInfo)localObject6).position;
        int i67 = this.mCurItem;
        int i68 = i66;
        int i69 = i67;
        if (i68 != i69)
          continue;
        int i70 = 2;
        if (localView1.requestFocus(i70))
          break;
      }
      localObject6 = null;
    }
  }

  public void removeView(View paramView)
  {
    if (this.mInLayout)
      removeViewInLayout(paramView);
    while (true)
    {
      return;
      super.removeView(paramView);
    }
  }

  public void setAdapter(PagerAdapter paramPagerAdapter)
  {
    boolean bool = true;
    ViewPager.1 local1 = null;
    int i = null;
    if (this.mAdapter != null)
    {
      PagerAdapter localPagerAdapter1 = this.mAdapter;
      PagerObserver localPagerObserver1 = this.mObserver;
      localPagerAdapter1.unregisterDataSetObserver(localPagerObserver1);
      this.mAdapter.startUpdate(this);
      for (int j = 0; ; j++)
      {
        int k = this.mItems.size();
        if (j >= k)
          break;
        ItemInfo localItemInfo = (ItemInfo)this.mItems.get(j);
        PagerAdapter localPagerAdapter2 = this.mAdapter;
        int m = localItemInfo.position;
        Object localObject = localItemInfo.object;
        localPagerAdapter2.destroyItem(this, m, localObject);
      }
      this.mAdapter.finishUpdate(this);
      this.mItems.clear();
      removeNonDecorViews();
      this.mCurItem = i;
      scrollTo(i, i);
    }
    PagerAdapter localPagerAdapter3 = this.mAdapter;
    this.mAdapter = paramPagerAdapter;
    if (this.mAdapter != null)
    {
      if (this.mObserver == null)
      {
        PagerObserver localPagerObserver2 = new PagerObserver(local1);
        this.mObserver = localPagerObserver2;
      }
      PagerAdapter localPagerAdapter4 = this.mAdapter;
      PagerObserver localPagerObserver3 = this.mObserver;
      localPagerAdapter4.registerDataSetObserver(localPagerObserver3);
      this.mPopulatePending = i;
      this.mFirstLayout = bool;
      if (this.mRestoredCurItem < 0)
        break label306;
      PagerAdapter localPagerAdapter5 = this.mAdapter;
      Parcelable localParcelable = this.mRestoredAdapterState;
      ClassLoader localClassLoader = this.mRestoredClassLoader;
      localPagerAdapter5.restoreState(localParcelable, localClassLoader);
      int n = this.mRestoredCurItem;
      setCurrentItemInternal(n, i, bool);
      this.mRestoredCurItem = -1;
      this.mRestoredAdapterState = local1;
      this.mRestoredClassLoader = local1;
    }
    while (true)
    {
      if ((this.mAdapterChangeListener != null) && (localPagerAdapter3 != paramPagerAdapter))
        this.mAdapterChangeListener.onAdapterChanged(localPagerAdapter3, paramPagerAdapter);
      return;
      label306: populate();
    }
  }

  void setChildrenDrawingOrderEnabledCompat(boolean paramBoolean)
  {
    if (this.mSetChildrenDrawingOrderEnabled == null);
    try
    {
      Class[] arrayOfClass = new Class[1];
      Class localClass = Boolean.TYPE;
      arrayOfClass[0] = localClass;
      Method localMethod1 = ViewGroup.class.getDeclaredMethod("setChildrenDrawingOrderEnabled", arrayOfClass);
      this.mSetChildrenDrawingOrderEnabled = localMethod1;
    }
    catch (NoSuchMethodException localNoSuchMethodException)
    {
      try
      {
        while (true)
        {
          Method localMethod2 = this.mSetChildrenDrawingOrderEnabled;
          Object[] arrayOfObject = new Object[1];
          Boolean localBoolean = Boolean.valueOf(paramBoolean);
          arrayOfObject[0] = localBoolean;
          localMethod2.invoke(this, arrayOfObject);
          return;
          localNoSuchMethodException = localNoSuchMethodException;
          Log.e("ViewPager", "Can't find setChildrenDrawingOrderEnabled", localNoSuchMethodException);
        }
      }
      catch (Exception localException)
      {
        while (true)
          Log.e("ViewPager", "Error changing children drawing order", localException);
      }
    }
  }

  public void setCurrentItem(int paramInt)
  {
    boolean bool1 = null;
    this.mPopulatePending = bool1;
    boolean bool2 = this.mFirstLayout;
    if (!bool2)
      bool2 = true;
    while (true)
    {
      setCurrentItemInternal(paramInt, bool2, bool1);
      return;
      boolean bool3 = bool1;
    }
  }

  public void setCurrentItem(int paramInt, boolean paramBoolean)
  {
    this.mPopulatePending = null;
    setCurrentItemInternal(paramInt, paramBoolean, null);
  }

  void setCurrentItemInternal(int paramInt, boolean paramBoolean1, boolean paramBoolean2)
  {
    setCurrentItemInternal(paramInt, paramBoolean1, paramBoolean2, 0);
  }

  void setCurrentItemInternal(int paramInt1, boolean paramBoolean1, boolean paramBoolean2, int paramInt2)
  {
    boolean bool1 = true;
    boolean bool2 = null;
    if ((this.mAdapter == null) || (this.mAdapter.getCount() <= 0))
      setScrollingCacheEnabled(bool2);
    while (true)
    {
      return;
      if ((paramBoolean2) || (this.mCurItem != paramInt1) || (this.mItems.size() == 0))
        break;
      setScrollingCacheEnabled(bool2);
    }
    if (paramInt1 < 0)
      paramInt1 = 0;
    while (true)
    {
      int i = this.mOffscreenPageLimit;
      int j = this.mCurItem + i;
      if (paramInt1 <= j)
      {
        int k = this.mCurItem - i;
        if (paramInt1 >= k)
          break;
      }
      for (int m = null; ; m++)
      {
        int n = this.mItems.size();
        if (m >= n)
          break;
        ((ItemInfo)this.mItems.get(m)).scrolling = bool1;
      }
      int i1 = this.mAdapter.getCount();
      if (paramInt1 < i1)
        continue;
      paramInt1 = this.mAdapter.getCount() + -1;
    }
    if (this.mCurItem != paramInt1);
    while (true)
    {
      populate(paramInt1);
      scrollToItem(paramInt1, paramBoolean1, paramInt2, bool1);
      break;
      Object localObject = bool2;
    }
  }

  OnPageChangeListener setInternalPageChangeListener(OnPageChangeListener paramOnPageChangeListener)
  {
    OnPageChangeListener localOnPageChangeListener = this.mInternalPageChangeListener;
    this.mInternalPageChangeListener = paramOnPageChangeListener;
    return localOnPageChangeListener;
  }

  public void setOffscreenPageLimit(int paramInt)
  {
    int i = 1;
    if (paramInt < i)
    {
      String str = "Requested offscreen page limit " + paramInt + " too small; defaulting to " + i;
      Log.w("ViewPager", str);
      paramInt = 1;
    }
    int j = this.mOffscreenPageLimit;
    if (paramInt != j)
    {
      this.mOffscreenPageLimit = paramInt;
      populate();
    }
  }

  void setOnAdapterChangeListener(OnAdapterChangeListener paramOnAdapterChangeListener)
  {
    this.mAdapterChangeListener = paramOnAdapterChangeListener;
  }

  public void setOnPageChangeListener(OnPageChangeListener paramOnPageChangeListener)
  {
    this.mOnPageChangeListener = paramOnPageChangeListener;
  }

  public void setPageMargin(int paramInt)
  {
    int i = this.mPageMargin;
    this.mPageMargin = paramInt;
    int j = getWidth();
    recomputeScrollPosition(j, j, paramInt, i);
    requestLayout();
  }

  public void setPageMarginDrawable(int paramInt)
  {
    Drawable localDrawable = getContext().getResources().getDrawable(paramInt);
    setPageMarginDrawable(localDrawable);
  }

  public void setPageMarginDrawable(Drawable paramDrawable)
  {
    this.mMarginDrawable = paramDrawable;
    if (paramDrawable != null)
      refreshDrawableState();
    int i;
    if (paramDrawable == null)
      i = 1;
    while (true)
    {
      setWillNotDraw(i);
      invalidate();
      return;
      Object localObject = null;
    }
  }

  public void setPageTransformer(boolean paramBoolean, PageTransformer paramPageTransformer)
  {
    Object localObject1 = 1;
    Object localObject2 = null;
    int i = Build.VERSION.SDK_INT;
    Object localObject3;
    label38: int k;
    if (i >= 11)
    {
      if (paramPageTransformer == null)
        break label85;
      int j = localObject1;
      localObject3 = this.mPageTransformer;
      if (localObject3 == null)
        break label92;
      localObject3 = localObject1;
      if (j == localObject3)
        break label99;
      k = localObject1;
      label48: this.mPageTransformer = paramPageTransformer;
      setChildrenDrawingOrderEnabledCompat(j);
      if (j == null)
        break label106;
      if (paramBoolean)
        localObject1 = 2;
    }
    label85: label92: label99: label106: for (this.mDrawingOrder = localObject1; ; this.mDrawingOrder = localObject2)
    {
      if (k != null)
        populate();
      return;
      Object localObject4 = localObject2;
      break;
      localObject3 = localObject2;
      break label38;
      Object localObject5 = localObject2;
      break label48;
    }
  }

  void smoothScrollTo(int paramInt1, int paramInt2)
  {
    smoothScrollTo(paramInt1, paramInt2, 0);
  }

  void smoothScrollTo(int paramInt1, int paramInt2, int paramInt3)
  {
    if (getChildCount() == 0)
      setScrollingCacheEnabled(null);
    int i;
    int j;
    int k;
    int m;
    while (true)
    {
      return;
      i = getScrollX();
      j = getScrollY();
      k = paramInt1 - i;
      m = paramInt2 - j;
      if ((k != 0) || (m != 0))
        break;
      completeScroll(null);
      populate();
      setScrollState(0);
    }
    setScrollingCacheEnabled(true);
    setScrollState(2);
    int n = getWidth();
    int i1 = n / 2;
    float f1 = Math.abs(k);
    float f2 = 1065353216 * f1;
    float f3 = n;
    float f4 = f2 / f3;
    float f5 = Math.min(1065353216, f4);
    float f6 = i1;
    float f7 = i1;
    float f8 = distanceInfluenceForSnapDuration(f5);
    float f9 = f7 * f8;
    float f10 = f6 + f9;
    Object localObject = null;
    paramInt3 = Math.abs(paramInt3);
    float f12;
    if (paramInt3 > 0)
    {
      float f11 = paramInt3;
      f12 = Math.abs(f10 / f11);
    }
    float f18;
    for (int i2 = Math.round(1148846080 * f12) * 4; ; i2 = (int)((1065353216 + f18) * 1120403456))
    {
      int i3 = Math.min(i2, 600);
      this.mScroller.startScroll(i, j, k, m, i2);
      ViewCompat.postInvalidateOnAnimation(this);
      break;
      float f13 = n;
      PagerAdapter localPagerAdapter = this.mAdapter;
      int i4 = this.mCurItem;
      float f14 = localPagerAdapter.getPageWidth(i4);
      float f15 = f13 * f14;
      float f16 = Math.abs(k);
      float f17 = this.mPageMargin + f15;
      f18 = f16 / f17;
    }
  }

  protected boolean verifyDrawable(Drawable paramDrawable)
  {
    boolean bool = super.verifyDrawable(paramDrawable);
    int i;
    if (!bool)
    {
      Drawable localDrawable = this.mMarginDrawable;
      if (paramDrawable != localDrawable);
    }
    else
    {
      i = 1;
    }
    while (true)
    {
      return i;
      Object localObject = null;
    }
  }

  @Signature({"Ljava/lang/Object;", "Ljava/util/Comparator", "<", "Landroid/view/View;", ">;"})
  class ViewPositionComparator
    implements Comparator
  {
    public int compare(View paramView1, View paramView2)
    {
      ViewPager.LayoutParams localLayoutParams1 = (ViewPager.LayoutParams)paramView1.getLayoutParams();
      ViewPager.LayoutParams localLayoutParams2 = (ViewPager.LayoutParams)paramView2.getLayoutParams();
      boolean bool1 = localLayoutParams1.isDecor;
      boolean bool2 = localLayoutParams2.isDecor;
      if (bool1 != bool2)
      {
        bool1 = localLayoutParams1.isDecor;
        if (bool1)
          bool1 = true;
      }
      while (true)
      {
        return bool1;
        int i = -1;
        continue;
        i = localLayoutParams1.position;
        int j = localLayoutParams2.position;
        i -= j;
      }
    }
  }

  public class LayoutParams extends ViewGroup.LayoutParams
  {
    int childIndex;
    public int gravity;
    public boolean isDecor;
    boolean needsMeasure;
    int position;
    float widthFactor = null;

    public LayoutParams()
    {
      super(-1);
    }

    public LayoutParams(AttributeSet arg2)
    {
      super(localAttributeSet);
      int[] arrayOfInt = ViewPager.LAYOUT_ATTRS;
      TypedArray localTypedArray = this$1.obtainStyledAttributes(localAttributeSet, arrayOfInt);
      int i = localTypedArray.getInteger(0, 48);
      this.gravity = i;
      localTypedArray.recycle();
    }
  }

  class PagerObserver extends DataSetObserver
  {
    private PagerObserver()
    {
    }

    public void onChanged()
    {
      ViewPager.this.dataSetChanged();
    }

    public void onInvalidated()
    {
      ViewPager.this.dataSetChanged();
    }
  }

  class MyAccessibilityDelegate extends AccessibilityDelegateCompat
  {
    MyAccessibilityDelegate()
    {
    }

    public void onInitializeAccessibilityEvent(View paramView, AccessibilityEvent paramAccessibilityEvent)
    {
      super.onInitializeAccessibilityEvent(paramView, paramAccessibilityEvent);
      String str = ViewPager.class.getName();
      paramAccessibilityEvent.setClassName(str);
    }

    public void onInitializeAccessibilityNodeInfo(View paramView, AccessibilityNodeInfoCompat paramAccessibilityNodeInfoCompat)
    {
      int i = 1;
      super.onInitializeAccessibilityNodeInfo(paramView, paramAccessibilityNodeInfoCompat);
      String str = ViewPager.class.getName();
      paramAccessibilityNodeInfoCompat.setClassName(str);
      if ((ViewPager.this.mAdapter != null) && (ViewPager.this.mAdapter.getCount() > i));
      while (true)
      {
        paramAccessibilityNodeInfoCompat.setScrollable(i);
        if ((ViewPager.this.mAdapter != null) && (ViewPager.this.mCurItem >= 0))
        {
          int j = ViewPager.this.mCurItem;
          int k = ViewPager.this.mAdapter.getCount();
          int m;
          m--;
          if (j < k)
            paramAccessibilityNodeInfoCompat.addAction(4096);
        }
        if ((ViewPager.this.mAdapter != null) && (ViewPager.this.mCurItem > 0))
        {
          int n = ViewPager.this.mCurItem;
          int i1 = ViewPager.this.mAdapter.getCount();
          if (n < i1)
            paramAccessibilityNodeInfoCompat.addAction(8192);
        }
        return;
        Object localObject = null;
      }
    }

    public boolean performAccessibilityAction(View paramView, int paramInt, Bundle paramBundle)
    {
      int i = 1;
      Object localObject2 = null;
      if (super.performAccessibilityAction(paramView, paramInt, paramBundle));
      while (true)
      {
        return i;
        Object localObject1;
        int i1;
        switch (paramInt)
        {
        default:
          localObject1 = localObject2;
          break;
        case 4096:
          if ((ViewPager.this.mAdapter != null) && (ViewPager.this.mCurItem >= 0))
          {
            int j = ViewPager.this.mCurItem;
            int k = ViewPager.this.mAdapter.getCount();
            int m;
            m--;
            if (j < k)
            {
              ViewPager localViewPager1 = ViewPager.this;
              int n = ViewPager.this.mCurItem;
              i1++;
              localViewPager1.setCurrentItem(n);
              continue;
            }
          }
          localObject1 = localObject2;
          break;
        case 8192:
          if ((ViewPager.this.mAdapter != null) && (ViewPager.this.mCurItem > 0))
          {
            int i2 = ViewPager.this.mCurItem;
            int i3 = ViewPager.this.mAdapter.getCount();
            if (i2 < i3)
            {
              ViewPager localViewPager2 = ViewPager.this;
              int i4 = ViewPager.this.mCurItem;
              i1--;
              localViewPager2.setCurrentItem(i4);
              continue;
            }
          }
          localObject1 = localObject2;
        }
      }
    }
  }

  public class SavedState extends View.BaseSavedState
  {

    @Signature({"Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/view/ViewPager$SavedState;", ">;"})
    public static final Parcelable.Creator CREATOR = ParcelableCompat.newCreator(new ViewPager.SavedState.1());
    Parcelable adapterState;
    ClassLoader loader;
    int position;

    SavedState(ClassLoader arg2)
    {
      super();
      ClassLoader localClassLoader;
      if (localClassLoader == null)
        localClassLoader = getClass().getClassLoader();
      int i = this$1.readInt();
      this.position = i;
      Parcelable localParcelable = this$1.readParcelable(localClassLoader);
      this.adapterState = localParcelable;
      this.loader = localClassLoader;
    }

    public SavedState()
    {
      super();
    }

    public String toString()
    {
      StringBuilder localStringBuilder1 = new StringBuilder().append("FragmentPager.SavedState{");
      String str = Integer.toHexString(System.identityHashCode(this));
      StringBuilder localStringBuilder2 = localStringBuilder1.append(str).append(" position=");
      int i = this.position;
      return i + "}";
    }

    public void writeToParcel(Parcel paramParcel, int paramInt)
    {
      super.writeToParcel(paramParcel, paramInt);
      int i = this.position;
      paramParcel.writeInt(i);
      Parcelable localParcelable = this.adapterState;
      paramParcel.writeParcelable(localParcelable, paramInt);
    }
  }

  abstract interface Decor
  {
  }

  abstract interface OnAdapterChangeListener
  {
    public abstract void onAdapterChanged(PagerAdapter paramPagerAdapter1, PagerAdapter paramPagerAdapter2);
  }

  public abstract interface PageTransformer
  {
    public abstract void transformPage(View paramView, float paramFloat);
  }

  public class SimpleOnPageChangeListener
    implements ViewPager.OnPageChangeListener
  {
    public void onPageScrollStateChanged(int paramInt)
    {
    }

    public void onPageScrolled(int paramInt1, float paramFloat, int paramInt2)
    {
    }

    public void onPageSelected(int paramInt)
    {
    }
  }

  public abstract interface OnPageChangeListener
  {
    public abstract void onPageScrollStateChanged(int paramInt);

    public abstract void onPageScrolled(int paramInt1, float paramFloat, int paramInt2);

    public abstract void onPageSelected(int paramInt);
  }

  class ItemInfo
  {
    Object object;
    float offset;
    int position;
    boolean scrolling;
    float widthFactor;
  }
}