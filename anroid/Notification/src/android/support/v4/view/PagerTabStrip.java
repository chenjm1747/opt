package android.support.v4.view;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.view.MotionEvent;
import android.view.ViewConfiguration;
import android.widget.TextView;

public class PagerTabStrip extends PagerTitleStrip
{
  private static final int FULL_UNDERLINE_HEIGHT = 1;
  private static final int INDICATOR_HEIGHT = 3;
  private static final int MIN_PADDING_BOTTOM = 6;
  private static final int MIN_STRIP_HEIGHT = 32;
  private static final int MIN_TEXT_SPACING = 64;
  private static final int TAB_PADDING = 16;
  private static final int TAB_SPACING = 32;
  private static final String TAG = "PagerTabStrip";
  private boolean mDrawFullUnderline;
  private boolean mDrawFullUnderlineSet;
  private int mFullUnderlineHeight;
  private boolean mIgnoreTap;
  private int mIndicatorColor;
  private int mIndicatorHeight;
  private float mInitialMotionX;
  private float mInitialMotionY;
  private int mMinPaddingBottom;
  private int mMinStripHeight;
  private int mMinTextSpacing;
  private int mTabAlpha;
  private int mTabPadding;
  private final Paint mTabPaint;
  private final Rect mTempRect;
  private int mTouchSlop;

  public PagerTabStrip(Context paramContext)
  {
    this(paramContext, null);
  }

  public PagerTabStrip(Context paramContext, AttributeSet paramAttributeSet)
  {
    super(paramContext, paramAttributeSet);
    Paint localPaint1 = new Paint();
    this.mTabPaint = localPaint1;
    Rect localRect = new Rect();
    this.mTempRect = localRect;
    this.mTabAlpha = 255;
    this.mDrawFullUnderline = null;
    this.mDrawFullUnderlineSet = null;
    int i = this.mTextColor;
    this.mIndicatorColor = i;
    Paint localPaint2 = this.mTabPaint;
    int j = this.mIndicatorColor;
    localPaint2.setColor(j);
    int k = paramContext.getResources().getDisplayMetrics().density;
    int m = (int)(1077936128 * k + 1056964608);
    this.mIndicatorHeight = m;
    int n = (int)(1086324736 * k + 1056964608);
    this.mMinPaddingBottom = n;
    int i1 = (int)(1115684864 * k);
    this.mMinTextSpacing = i1;
    int i2 = (int)(1098907648 * k + 1056964608);
    this.mTabPadding = i2;
    int i3 = (int)(1065353216 * k + 1056964608);
    this.mFullUnderlineHeight = i3;
    int i4 = (int)(1107296256 * k + 1056964608);
    this.mMinStripHeight = i4;
    int i5 = ViewConfiguration.get(paramContext).getScaledTouchSlop();
    this.mTouchSlop = i5;
    int i6 = getPaddingLeft();
    int i7 = getPaddingTop();
    int i8 = getPaddingRight();
    int i9 = getPaddingBottom();
    setPadding(i6, i7, i8, i9);
    int i10 = getTextSpacing();
    setTextSpacing(i10);
    setWillNotDraw(null);
    this.mPrevText.setFocusable(bool);
    TextView localTextView1 = this.mPrevText;
    PagerTabStrip.1 local1 = new PagerTabStrip.1(this);
    localTextView1.setOnClickListener(local1);
    this.mNextText.setFocusable(bool);
    TextView localTextView2 = this.mNextText;
    PagerTabStrip.2 local2 = new PagerTabStrip.2(this);
    localTextView2.setOnClickListener(local2);
    if (getBackground() == null)
      this.mDrawFullUnderline = bool;
  }

  public boolean getDrawFullUnderline()
  {
    return this.mDrawFullUnderline;
  }

  int getMinHeight()
  {
    int i = super.getMinHeight();
    int j = this.mMinStripHeight;
    return Math.max(i, j);
  }

  public int getTabIndicatorColor()
  {
    return this.mIndicatorColor;
  }

  protected void onDraw(Canvas paramCanvas)
  {
    int i = 16777215;
    super.onDraw(paramCanvas);
    int j = getHeight();
    int k = j;
    int m = this.mCurrText.getLeft();
    int n = this.mTabPadding;
    int i1 = m - n;
    int i2 = this.mCurrText.getRight();
    int i3 = this.mTabPadding;
    int i4 = i2 + i3;
    int i5 = this.mIndicatorHeight;
    int i6 = k - i5;
    Paint localPaint1 = this.mTabPaint;
    int i7 = this.mTabAlpha << 24;
    int i8 = this.mIndicatorColor & i;
    int i9 = i7 | i8;
    localPaint1.setColor(i9);
    float f1 = i1;
    float f2 = i6;
    float f3 = i4;
    float f4 = k;
    Paint localPaint2 = this.mTabPaint;
    paramCanvas.drawRect(f1, f2, f3, f4, localPaint2);
    if (this.mDrawFullUnderline)
    {
      Paint localPaint3 = this.mTabPaint;
      int i10 = this.mIndicatorColor & i;
      int i11 = 0xFF000000 | i10;
      localPaint3.setColor(i11);
      float f5 = getPaddingLeft();
      int i12 = this.mFullUnderlineHeight;
      float f6 = j - i12;
      int i13 = getWidth();
      int i14 = getPaddingRight();
      float f7 = i13 - i14;
      float f8 = j;
      Paint localPaint4 = this.mTabPaint;
      paramCanvas.drawRect(f5, f6, f7, f8, localPaint4);
    }
  }

  public boolean onTouchEvent(MotionEvent paramMotionEvent)
  {
    Object localObject1 = 1;
    Object localObject2 = null;
    int m = paramMotionEvent.getAction();
    if ((m != 0) && (this.mIgnoreTap))
      return localObject2;
    float f5 = paramMotionEvent.getX();
    float f6 = paramMotionEvent.getY();
    switch (m)
    {
    default:
    case 0:
    case 2:
    case 1:
    }
    while (true)
    {
      localObject2 = localObject1;
      break;
      this.mInitialMotionX = f5;
      this.mInitialMotionY = f6;
      this.mIgnoreTap = localObject2;
      continue;
      int i = this.mInitialMotionX;
      float f1 = Math.abs(f5 - i);
      float f7 = this.mTouchSlop;
      f1 <= f7;
      if (f1 <= 0)
      {
        int j = this.mInitialMotionY;
        float f2 = Math.abs(f6 - j);
        float f8 = this.mTouchSlop;
        f2 <= f8;
        if (f2 <= 0)
          continue;
      }
      this.mIgnoreTap = localObject1;
      continue;
      int k = this.mCurrText.getLeft();
      int n = this.mTabPadding;
      float f3 = k - n;
      f3 = f5 < f3;
      int i2;
      if (f3 < 0)
      {
        localObject3 = this.mPager;
        int i1 = this.mPager.getCurrentItem();
        i2--;
        ((ViewPager)localObject3).setCurrentItem(i1);
        continue;
      }
      Object localObject3 = this.mCurrText.getRight();
      Object localObject4 = this.mTabPadding;
      float f4 = localObject3 + localObject4;
      f4 = f5 < f4;
      if (f4 <= 0)
        continue;
      ViewPager localViewPager = this.mPager;
      int i3 = this.mPager.getCurrentItem();
      i2++;
      localViewPager.setCurrentItem(i3);
    }
  }

  public void setBackgroundColor(int paramInt)
  {
    super.setBackgroundColor(paramInt);
    boolean bool = this.mDrawFullUnderlineSet;
    int i;
    if (!bool)
    {
      i = 0xFF000000 & paramInt;
      if (i != 0)
        break label31;
      i = 1;
    }
    while (true)
    {
      this.mDrawFullUnderline = i;
      return;
      label31: Object localObject = null;
    }
  }

  public void setBackgroundDrawable(Drawable paramDrawable)
  {
    super.setBackgroundDrawable(paramDrawable);
    boolean bool = this.mDrawFullUnderlineSet;
    if (!bool)
    {
      if (paramDrawable != null)
        break label26;
      bool = true;
    }
    while (true)
    {
      this.mDrawFullUnderline = bool;
      return;
      label26: Object localObject = null;
    }
  }

  public void setBackgroundResource(int paramInt)
  {
    super.setBackgroundResource(paramInt);
    boolean bool = this.mDrawFullUnderlineSet;
    if (!bool)
    {
      if (paramInt != 0)
        break label26;
      bool = true;
    }
    while (true)
    {
      this.mDrawFullUnderline = bool;
      return;
      label26: Object localObject = null;
    }
  }

  public void setDrawFullUnderline(boolean paramBoolean)
  {
    this.mDrawFullUnderline = paramBoolean;
    this.mDrawFullUnderlineSet = true;
    invalidate();
  }

  public void setPadding(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    int i = this.mMinPaddingBottom;
    if (paramInt4 < i)
      paramInt4 = this.mMinPaddingBottom;
    super.setPadding(paramInt1, paramInt2, paramInt3, paramInt4);
  }

  public void setTabIndicatorColor(int paramInt)
  {
    this.mIndicatorColor = paramInt;
    Paint localPaint = this.mTabPaint;
    int i = this.mIndicatorColor;
    localPaint.setColor(i);
    invalidate();
  }

  public void setTabIndicatorColorResource(int paramInt)
  {
    int i = getContext().getResources().getColor(paramInt);
    setTabIndicatorColor(i);
  }

  public void setTextSpacing(int paramInt)
  {
    int i = this.mMinTextSpacing;
    if (paramInt < i)
      paramInt = this.mMinTextSpacing;
    super.setTextSpacing(paramInt);
  }

  void updateTextPositions(int paramInt, float paramFloat, boolean paramBoolean)
  {
    Rect localRect = this.mTempRect;
    int i = getHeight();
    int j = this.mCurrText.getLeft();
    int k = this.mTabPadding;
    int m = j - k;
    int n = this.mCurrText.getRight();
    int i1 = this.mTabPadding;
    int i2 = n + i1;
    int i3 = this.mIndicatorHeight;
    int i4 = i - i3;
    localRect.set(m, i4, i2, i);
    super.updateTextPositions(paramInt, paramFloat, paramBoolean);
    int i5 = (int)(Math.abs(paramFloat - 1056964608) * 1073741824 * 1132396544);
    this.mTabAlpha = i5;
    int i6 = this.mCurrText.getLeft();
    int i7 = this.mTabPadding;
    int i8 = i6 - i7;
    int i9 = this.mCurrText.getRight();
    int i10 = this.mTabPadding;
    int i11 = i9 + i10;
    localRect.union(i8, i4, i11, i);
    invalidate(localRect);
  }
}