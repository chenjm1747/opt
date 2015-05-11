package android.support.v4.view;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.DataSetObserver;
import android.graphics.drawable.Drawable;
import android.os.Build.VERSION;
import android.text.TextUtils.TruncateAt;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.view.View.MeasureSpec;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.widget.TextView;
import dalvik.annotation.Signature;
import java.lang.ref.WeakReference;

public class PagerTitleStrip extends ViewGroup
  implements ViewPager.Decor
{
  private static final int[] ATTRS = { 16842804, 16842901, 16842904, 16842927 };
  private static final PagerTitleStripImpl IMPL;
  private static final float SIDE_ALPHA = 0.6F;
  private static final String TAG = "PagerTitleStrip";
  private static final int[] TEXT_ATTRS;
  private static final int TEXT_SPACING = 16;
  TextView mCurrText;
  private int mGravity;
  private int mLastKnownCurrentPage = -1;
  private float mLastKnownPositionOffset = -1082130432;
  TextView mNextText;
  private int mNonPrimaryAlpha;
  private final PageListener mPageListener;
  ViewPager mPager;
  TextView mPrevText;
  private int mScaledTextSpacing;
  int mTextColor;
  private boolean mUpdatingPositions;
  private boolean mUpdatingText;

  @Signature({"Ljava/lang/ref/WeakReference", "<", "Landroid/support/v4/view/PagerAdapter;", ">;"})
  private WeakReference mWatchingAdapter;

  static
  {
    int[] arrayOfInt = new int[1];
    arrayOfInt[0] = 16843660;
    TEXT_ATTRS = arrayOfInt;
    if (Build.VERSION.SDK_INT >= 14)
      IMPL = new PagerTitleStripImplIcs();
    while (true)
    {
      return;
      IMPL = new PagerTitleStripImplBase();
    }
  }

  public PagerTitleStrip(Context paramContext)
  {
    this(paramContext, null);
  }

  public PagerTitleStrip(Context paramContext, AttributeSet paramAttributeSet)
  {
    super(paramContext, paramAttributeSet);
    PageListener localPageListener = new PageListener(null);
    this.mPageListener = localPageListener;
    TextView localTextView1 = new TextView(paramContext);
    this.mPrevText = localTextView1;
    addView(localTextView1);
    TextView localTextView2 = new TextView(paramContext);
    this.mCurrText = localTextView2;
    addView(localTextView2);
    TextView localTextView3 = new TextView(paramContext);
    this.mNextText = localTextView3;
    addView(localTextView3);
    int[] arrayOfInt1 = ATTRS;
    TypedArray localTypedArray1 = paramContext.obtainStyledAttributes(paramAttributeSet, arrayOfInt1);
    int k = localTypedArray1.getResourceId(j, j);
    if (k != 0)
    {
      this.mPrevText.setTextAppearance(paramContext, k);
      this.mCurrText.setTextAppearance(paramContext, k);
      this.mNextText.setTextAppearance(paramContext, k);
    }
    int m = localTypedArray1.getDimensionPixelSize(1, j);
    if (m != 0)
    {
      float f = m;
      setTextSize(j, f);
    }
    if (localTypedArray1.hasValue(i))
    {
      int n = localTypedArray1.getColor(i, j);
      this.mPrevText.setTextColor(n);
      this.mCurrText.setTextColor(n);
      this.mNextText.setTextColor(n);
    }
    int i1 = localTypedArray1.getInteger(3, 80);
    this.mGravity = i1;
    localTypedArray1.recycle();
    int i2 = this.mCurrText.getTextColors().getDefaultColor();
    this.mTextColor = i2;
    setNonPrimaryAlpha(1058642330);
    TextView localTextView4 = this.mPrevText;
    TextUtils.TruncateAt localTruncateAt1 = TextUtils.TruncateAt.END;
    localTextView4.setEllipsize(localTruncateAt1);
    TextView localTextView5 = this.mCurrText;
    TextUtils.TruncateAt localTruncateAt2 = TextUtils.TruncateAt.END;
    localTextView5.setEllipsize(localTruncateAt2);
    TextView localTextView6 = this.mNextText;
    TextUtils.TruncateAt localTruncateAt3 = TextUtils.TruncateAt.END;
    localTextView6.setEllipsize(localTruncateAt3);
    boolean bool = null;
    if (k != 0)
    {
      int[] arrayOfInt2 = TEXT_ATTRS;
      TypedArray localTypedArray2 = paramContext.obtainStyledAttributes(k, arrayOfInt2);
      bool = localTypedArray2.getBoolean(j, j);
      localTypedArray2.recycle();
    }
    if (bool != null)
    {
      setSingleLineAllCaps(this.mPrevText);
      setSingleLineAllCaps(this.mCurrText);
      setSingleLineAllCaps(this.mNextText);
    }
    while (true)
    {
      int i3 = paramContext.getResources().getDisplayMetrics().density;
      int i4 = (int)(1098907648 * i3);
      this.mScaledTextSpacing = i4;
      return;
      this.mPrevText.setSingleLine();
      this.mCurrText.setSingleLine();
      this.mNextText.setSingleLine();
    }
  }

  private static void setSingleLineAllCaps(TextView paramTextView)
  {
    IMPL.setSingleLineAllCaps(paramTextView);
  }

  int getMinHeight()
  {
    int i = null;
    Drawable localDrawable = getBackground();
    if (localDrawable != null)
      i = localDrawable.getIntrinsicHeight();
    return i;
  }

  public int getTextSpacing()
  {
    return this.mScaledTextSpacing;
  }

  protected void onAttachedToWindow()
  {
    super.onAttachedToWindow();
    ViewParent localViewParent = getParent();
    boolean bool = localViewParent instanceof ViewPager;
    if (!bool)
      throw new IllegalStateException("PagerTitleStrip must be a direct child of a ViewPager.");
    ViewPager localViewPager = (ViewPager)localViewParent;
    PagerAdapter localPagerAdapter = localViewPager.getAdapter();
    Object localObject = this.mPageListener;
    localViewPager.setInternalPageChangeListener((ViewPager.OnPageChangeListener)localObject);
    localObject = this.mPageListener;
    localViewPager.setOnAdapterChangeListener((ViewPager.OnAdapterChangeListener)localObject);
    this.mPager = localViewPager;
    localObject = this.mWatchingAdapter;
    if (localObject != null);
    for (localObject = (PagerAdapter)this.mWatchingAdapter.get(); ; localObject = null)
    {
      updateAdapter((PagerAdapter)localObject, localPagerAdapter);
      return;
    }
  }

  protected void onDetachedFromWindow()
  {
    int i = 0;
    super.onDetachedFromWindow();
    if (this.mPager != null)
    {
      PagerAdapter localPagerAdapter = this.mPager.getAdapter();
      updateAdapter(localPagerAdapter, i);
      this.mPager.setInternalPageChangeListener(i);
      this.mPager.setOnAdapterChangeListener(i);
      this.mPager = i;
    }
  }

  protected void onLayout(boolean paramBoolean, int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    Object localObject = null;
    if (this.mPager != null)
    {
      int i;
      if (this.mLastKnownPositionOffset >= localObject)
        i = this.mLastKnownPositionOffset;
      int j = this.mLastKnownCurrentPage;
      updateTextPositions(j, i, true);
    }
  }

  protected void onMeasure(int paramInt1, int paramInt2)
  {
    int i = View.MeasureSpec.getMode(paramInt1);
    int j = View.MeasureSpec.getMode(paramInt2);
    int k = View.MeasureSpec.getSize(paramInt1);
    int m = View.MeasureSpec.getSize(paramInt2);
    if (i != 1073741824)
      throw new IllegalStateException("Must measure with an exact width");
    int n = m;
    int i1 = getMinHeight();
    int i2 = getPaddingTop();
    int i3 = getPaddingBottom();
    int i4 = i2 + i3;
    int i5 = n - i4;
    int i6 = View.MeasureSpec.makeMeasureSpec((int)(k * 1061997773), -2147483648);
    int i7 = View.MeasureSpec.makeMeasureSpec(i5, -2147483648);
    this.mPrevText.measure(i6, i7);
    this.mCurrText.measure(i6, i7);
    this.mNextText.measure(i6, i7);
    if (j == 1073741824)
      setMeasuredDimension(k, m);
    while (true)
    {
      return;
      int i8 = this.mCurrText.getMeasuredHeight() + i4;
      int i9 = Math.max(i1, i8);
      setMeasuredDimension(k, i9);
    }
  }

  public void requestLayout()
  {
    if (!this.mUpdatingText)
      super.requestLayout();
  }

  public void setGravity(int paramInt)
  {
    this.mGravity = paramInt;
    requestLayout();
  }

  public void setNonPrimaryAlpha(float paramFloat)
  {
    int i = (int)(1132396544 * paramFloat) & 0xFF;
    this.mNonPrimaryAlpha = i;
    int j = this.mNonPrimaryAlpha << 24;
    int k = this.mTextColor & 0xFFFFFF;
    int m = j | k;
    this.mPrevText.setTextColor(m);
    this.mNextText.setTextColor(m);
  }

  public void setTextColor(int paramInt)
  {
    this.mTextColor = paramInt;
    this.mCurrText.setTextColor(paramInt);
    int i = this.mNonPrimaryAlpha << 24;
    int j = this.mTextColor & 0xFFFFFF;
    int k = i | j;
    this.mPrevText.setTextColor(k);
    this.mNextText.setTextColor(k);
  }

  public void setTextSize(int paramInt, float paramFloat)
  {
    this.mPrevText.setTextSize(paramInt, paramFloat);
    this.mCurrText.setTextSize(paramInt, paramFloat);
    this.mNextText.setTextSize(paramInt, paramFloat);
  }

  public void setTextSpacing(int paramInt)
  {
    this.mScaledTextSpacing = paramInt;
    requestLayout();
  }

  void updateAdapter(PagerAdapter paramPagerAdapter1, PagerAdapter paramPagerAdapter2)
  {
    if (paramPagerAdapter1 != null)
    {
      PageListener localPageListener1 = this.mPageListener;
      paramPagerAdapter1.unregisterDataSetObserver(localPageListener1);
      this.mWatchingAdapter = null;
    }
    if (paramPagerAdapter2 != null)
    {
      PageListener localPageListener2 = this.mPageListener;
      paramPagerAdapter2.registerDataSetObserver(localPageListener2);
      WeakReference localWeakReference = new WeakReference(paramPagerAdapter2);
      this.mWatchingAdapter = localWeakReference;
    }
    if (this.mPager != null)
    {
      this.mLastKnownCurrentPage = -1;
      this.mLastKnownPositionOffset = -1082130432;
      int i = this.mPager.getCurrentItem();
      updateText(i, paramPagerAdapter2);
      requestLayout();
    }
  }

  void updateText(int paramInt, PagerAdapter paramPagerAdapter)
  {
    int i = 1;
    int j = -2147483648;
    boolean bool1 = null;
    int k;
    CharSequence localCharSequence;
    TextView localTextView;
    if (paramPagerAdapter != null)
    {
      k = paramPagerAdapter.getCount();
      this.mUpdatingText = i;
      localCharSequence = null;
      if ((paramInt >= i) && (paramPagerAdapter != null))
      {
        i = paramInt + -1;
        localCharSequence = paramPagerAdapter.getPageTitle(i);
      }
      localObject = this.mPrevText;
      ((TextView)localObject).setText(localCharSequence);
      localTextView = this.mCurrText;
      if ((paramPagerAdapter == null) || (paramInt >= k))
        break label287;
    }
    label287: for (Object localObject = paramPagerAdapter.getPageTitle(paramInt); ; localObject = null)
    {
      localTextView.setText((CharSequence)localObject);
      localCharSequence = null;
      if ((paramInt + 1 < k) && (paramPagerAdapter != null))
      {
        int m = paramInt + 1;
        localCharSequence = paramPagerAdapter.getPageTitle(m);
      }
      this.mNextText.setText(localCharSequence);
      int n = getWidth();
      int i1 = getPaddingLeft();
      int i2 = n - i1;
      int i3 = getPaddingRight();
      int i4 = i2 - i3;
      int i5 = getHeight();
      int i6 = getPaddingTop();
      int i7 = i5 - i6;
      int i8 = getPaddingBottom();
      int i9 = i7 - i8;
      int i10 = View.MeasureSpec.makeMeasureSpec((int)(i4 * 1061997773), j);
      int i11 = View.MeasureSpec.makeMeasureSpec(i9, j);
      this.mPrevText.measure(i10, i11);
      this.mCurrText.measure(i10, i11);
      this.mNextText.measure(i10, i11);
      this.mLastKnownCurrentPage = paramInt;
      if (!this.mUpdatingPositions)
      {
        int i12 = this.mLastKnownPositionOffset;
        updateTextPositions(paramInt, i12, bool1);
      }
      this.mUpdatingText = bool1;
      return;
      boolean bool2 = bool1;
      break;
    }
  }

  void updateTextPositions(int paramInt, float paramFloat, boolean paramBoolean)
  {
    int i = this.mLastKnownCurrentPage;
    int j = paramInt;
    int k = i;
    int n;
    int i2;
    int i4;
    int i5;
    int i6;
    int i7;
    int i8;
    int i9;
    int i17;
    int i18;
    int i25;
    int i26;
    int i27;
    int i34;
    int i35;
    int i36;
    int i37;
    if (j != k)
    {
      PagerAdapter localPagerAdapter1 = this.mPager.getAdapter();
      PagerTitleStrip localPagerTitleStrip = this;
      int m = paramInt;
      PagerAdapter localPagerAdapter2 = localPagerAdapter1;
      localPagerTitleStrip.updateText(m, localPagerAdapter2);
      boolean bool = true;
      this.mUpdatingPositions = bool;
      n = this.mPrevText.getMeasuredWidth();
      int i1 = this.mCurrText.getMeasuredWidth();
      i2 = this.mNextText.getMeasuredWidth();
      int i3 = i1 / 2;
      i4 = getWidth();
      i5 = getHeight();
      i6 = getPaddingLeft();
      i7 = getPaddingRight();
      i8 = getPaddingTop();
      i9 = getPaddingBottom();
      int i10 = i6 + i3;
      int i11 = i7 + i3;
      int i12 = i4 - i10 - i11;
      float f = paramFloat + 1056964608;
      if (f > 1065353216)
        f -= 1065353216;
      int i13 = i4 - i11;
      int i14 = (int)(i12 * f);
      int i15 = i13 - i14;
      int i16 = i1 / 2;
      i17 = i15 - i16;
      i18 = i17 + i1;
      int i19 = this.mPrevText.getBaseline();
      int i20 = this.mCurrText.getBaseline();
      int i21 = this.mNextText.getBaseline();
      int i22 = Math.max(i19, i20);
      int i23 = i21;
      int i24 = Math.max(i22, i23);
      i25 = i24 - i19;
      i26 = i24 - i20;
      i27 = i24 - i21;
      int i28 = this.mPrevText.getMeasuredHeight();
      int i29 = i25 + i28;
      int i30 = this.mCurrText.getMeasuredHeight();
      int i31 = i26 + i30;
      int i32 = this.mNextText.getMeasuredHeight();
      int i33 = i27 + i32;
      i34 = Math.max(Math.max(i29, i31), i33);
      switch (this.mGravity & 0x70)
      {
      default:
        i35 = i8 + i25;
        i36 = i8 + i26;
        i37 = i8 + i27;
      case 16:
      case 80:
      }
    }
    while (true)
    {
      TextView localTextView1 = this.mCurrText;
      int i38 = this.mCurrText.getMeasuredHeight() + i36;
      TextView localTextView2 = localTextView1;
      int i39 = i36;
      int i40 = i38;
      localTextView2.layout(i17, i39, i18, i40);
      int i41 = this.mScaledTextSpacing;
      int i42 = i17 - i41 - n;
      int i43 = i6;
      int i44 = i42;
      int i45 = Math.min(i43, i44);
      TextView localTextView3 = this.mPrevText;
      int i46 = i45 + n;
      int i47 = this.mPrevText.getMeasuredHeight() + i35;
      TextView localTextView4 = localTextView3;
      int i48 = i45;
      int i49 = i35;
      int i50 = i46;
      int i51 = i47;
      localTextView4.layout(i48, i49, i50, i51);
      int i52 = i4 - i7 - i2;
      int i53 = this.mScaledTextSpacing + i18;
      int i54 = Math.max(i52, i53);
      TextView localTextView5 = this.mNextText;
      int i55 = i54 + i2;
      int i56 = this.mNextText.getMeasuredHeight() + i37;
      TextView localTextView6 = localTextView5;
      int i57 = i54;
      int i58 = i37;
      int i59 = i55;
      int i60 = i56;
      localTextView6.layout(i57, i58, i59, i60);
      int i61 = paramFloat;
      this.mLastKnownPositionOffset = i61;
      Object localObject = null;
      this.mUpdatingPositions = localObject;
      while (true)
      {
        return;
        if (paramBoolean)
          break;
        int i62 = this.mLastKnownPositionOffset;
        if (paramFloat != i62)
          break;
      }
      int i63 = (i5 - i8 - i9 - i34) / 2;
      i35 = i63 + i25;
      i36 = i63 + i26;
      i37 = i63 + i27;
      continue;
      int i64 = i5 - i9 - i34;
      i35 = i64 + i25;
      i36 = i64 + i26;
      i37 = i64 + i27;
    }
  }

  class PageListener extends DataSetObserver
    implements ViewPager.OnPageChangeListener, ViewPager.OnAdapterChangeListener
  {
    private int mScrollState;

    private PageListener()
    {
    }

    public void onAdapterChanged(PagerAdapter paramPagerAdapter1, PagerAdapter paramPagerAdapter2)
    {
      PagerTitleStrip.this.updateAdapter(paramPagerAdapter1, paramPagerAdapter2);
    }

    public void onChanged()
    {
      float f = null;
      PagerTitleStrip localPagerTitleStrip1 = PagerTitleStrip.this;
      int i = PagerTitleStrip.this.mPager.getCurrentItem();
      PagerAdapter localPagerAdapter = PagerTitleStrip.this.mPager.getAdapter();
      localPagerTitleStrip1.updateText(i, localPagerAdapter);
      if (PagerTitleStrip.this.mLastKnownPositionOffset >= f)
        f = PagerTitleStrip.this.mLastKnownPositionOffset;
      PagerTitleStrip localPagerTitleStrip2 = PagerTitleStrip.this;
      int j = PagerTitleStrip.this.mPager.getCurrentItem();
      localPagerTitleStrip2.updateTextPositions(j, f, true);
    }

    public void onPageScrollStateChanged(int paramInt)
    {
      this.mScrollState = paramInt;
    }

    public void onPageScrolled(int paramInt1, float paramFloat, int paramInt2)
    {
      if (paramFloat > 1056964608)
        paramInt1++;
      PagerTitleStrip.this.updateTextPositions(paramInt1, paramFloat, null);
    }

    public void onPageSelected(int paramInt)
    {
      float f = null;
      if (this.mScrollState == 0)
      {
        PagerTitleStrip localPagerTitleStrip1 = PagerTitleStrip.this;
        int i = PagerTitleStrip.this.mPager.getCurrentItem();
        PagerAdapter localPagerAdapter = PagerTitleStrip.this.mPager.getAdapter();
        localPagerTitleStrip1.updateText(i, localPagerAdapter);
        if (PagerTitleStrip.this.mLastKnownPositionOffset >= f)
          f = PagerTitleStrip.this.mLastKnownPositionOffset;
        PagerTitleStrip localPagerTitleStrip2 = PagerTitleStrip.this;
        int j = PagerTitleStrip.this.mPager.getCurrentItem();
        localPagerTitleStrip2.updateTextPositions(j, f, true);
      }
    }
  }

  class PagerTitleStripImplIcs
    implements PagerTitleStrip.PagerTitleStripImpl
  {
    public void setSingleLineAllCaps(TextView paramTextView)
    {
      PagerTitleStripIcs.setSingleLineAllCaps(paramTextView);
    }
  }

  class PagerTitleStripImplBase
    implements PagerTitleStrip.PagerTitleStripImpl
  {
    public void setSingleLineAllCaps(TextView paramTextView)
    {
      paramTextView.setSingleLine();
    }
  }

  abstract interface PagerTitleStripImpl
  {
    public abstract void setSingleLineAllCaps(TextView paramTextView);
  }
}