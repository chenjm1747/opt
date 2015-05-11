package android.support.v4.app;

import android.content.Context;
import android.content.res.TypedArray;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.Parcelable.Creator;
import android.util.AttributeSet;
import android.view.View;
import android.view.View.BaseSavedState;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TabHost;
import android.widget.TabHost.OnTabChangeListener;
import android.widget.TabHost.TabContentFactory;
import android.widget.TabHost.TabSpec;
import android.widget.TabWidget;
import dalvik.annotation.Signature;
import java.util.ArrayList;

public class FragmentTabHost extends TabHost
  implements TabHost.OnTabChangeListener
{
  private boolean mAttached;
  private int mContainerId;
  private Context mContext;
  private FragmentManager mFragmentManager;
  private TabInfo mLastTab;
  private TabHost.OnTabChangeListener mOnTabChangeListener;
  private FrameLayout mRealTabContent;

  @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/FragmentTabHost$TabInfo;", ">;"})
  private final ArrayList mTabs;

  public FragmentTabHost(Context paramContext)
  {
    super(paramContext, null);
    ArrayList localArrayList = new ArrayList();
    this.mTabs = localArrayList;
    initFragmentTabHost(paramContext, null);
  }

  public FragmentTabHost(Context paramContext, AttributeSet paramAttributeSet)
  {
    super(paramContext, paramAttributeSet);
    ArrayList localArrayList = new ArrayList();
    this.mTabs = localArrayList;
    initFragmentTabHost(paramContext, paramAttributeSet);
  }

  private FragmentTransaction doTabChanged(String paramString, FragmentTransaction paramFragmentTransaction)
  {
    Object localObject = null;
    for (int i = 0; ; i++)
    {
      int j = this.mTabs.size();
      if (i >= j)
        break;
      TabInfo localTabInfo = (TabInfo)this.mTabs.get(i);
      if (!localTabInfo.tag.equals(paramString))
        continue;
      localObject = localTabInfo;
    }
    if (localObject == null)
    {
      String str1 = "No tab known for tag " + paramString;
      throw new IllegalStateException(str1);
    }
    if (this.mLastTab != localObject)
    {
      if (paramFragmentTransaction == null)
        paramFragmentTransaction = this.mFragmentManager.beginTransaction();
      if ((this.mLastTab != null) && (this.mLastTab.fragment != null))
      {
        Fragment localFragment1 = this.mLastTab.fragment;
        paramFragmentTransaction.detach(localFragment1);
      }
      if (localObject != null)
      {
        if (localObject.fragment != null)
          break label230;
        Context localContext = this.mContext;
        String str2 = localObject.clss.getName();
        Bundle localBundle = localObject.args;
        Fragment localFragment2 = Fragment.instantiate(localContext, str2, localBundle);
        TabInfo.access$102(localObject, localFragment2);
        int k = this.mContainerId;
        Fragment localFragment3 = localObject.fragment;
        String str3 = localObject.tag;
        paramFragmentTransaction.add(k, localFragment3, str3);
      }
    }
    while (true)
    {
      this.mLastTab = localObject;
      return paramFragmentTransaction;
      label230: Fragment localFragment4 = localObject.fragment;
      paramFragmentTransaction.attach(localFragment4);
    }
  }

  private void ensureContent()
  {
    if (this.mRealTabContent == null)
    {
      int i = this.mContainerId;
      FrameLayout localFrameLayout = (FrameLayout)findViewById(i);
      this.mRealTabContent = localFrameLayout;
      if (this.mRealTabContent == null)
      {
        StringBuilder localStringBuilder = new StringBuilder().append("No tab content FrameLayout found for id ");
        int j = this.mContainerId;
        String str = j;
        throw new IllegalStateException(str);
      }
    }
  }

  private void initFragmentTabHost(Context paramContext, AttributeSet paramAttributeSet)
  {
    int i = 16908307;
    int j = 1;
    float f = null;
    int k = -1;
    int m = 0;
    int[] arrayOfInt = new int[j];
    arrayOfInt[m] = 16842995;
    TypedArray localTypedArray = paramContext.obtainStyledAttributes(paramAttributeSet, arrayOfInt, m, m);
    int n = localTypedArray.getResourceId(m, m);
    this.mContainerId = n;
    localTypedArray.recycle();
    super.setOnTabChangedListener(this);
    if (findViewById(i) == null)
    {
      LinearLayout localLinearLayout = new LinearLayout(paramContext);
      localLinearLayout.setOrientation(j);
      FrameLayout.LayoutParams localLayoutParams = new FrameLayout.LayoutParams(k, k);
      addView(localLinearLayout, localLayoutParams);
      TabWidget localTabWidget = new TabWidget(paramContext);
      localTabWidget.setId(i);
      localTabWidget.setOrientation(m);
      LinearLayout.LayoutParams localLayoutParams1 = new LinearLayout.LayoutParams(k, -1, f);
      localLinearLayout.addView(localTabWidget, localLayoutParams1);
      FrameLayout localFrameLayout1 = new FrameLayout(paramContext);
      localFrameLayout1.setId(16908305);
      LinearLayout.LayoutParams localLayoutParams2 = new LinearLayout.LayoutParams(m, m, f);
      localLinearLayout.addView(localFrameLayout1, localLayoutParams2);
      FrameLayout localFrameLayout2 = new FrameLayout(paramContext);
      this.mRealTabContent = localFrameLayout2;
      FrameLayout localFrameLayout3 = this.mRealTabContent;
      int i1 = this.mContainerId;
      localFrameLayout3.setId(i1);
      LinearLayout.LayoutParams localLayoutParams3 = new LinearLayout.LayoutParams(k, m, 1065353216);
      localLinearLayout.addView(localFrameLayout2, localLayoutParams3);
    }
  }

  @Signature({"(", "Landroid/widget/TabHost$TabSpec;", "Ljava/lang/Class", "<*>;", "Landroid/os/Bundle;", ")V"})
  public void addTab(TabHost.TabSpec paramTabSpec, Class paramClass, Bundle paramBundle)
  {
    Context localContext = this.mContext;
    DummyTabFactory localDummyTabFactory = new DummyTabFactory();
    paramTabSpec.setContent(localDummyTabFactory);
    String str = paramTabSpec.getTag();
    TabInfo localTabInfo = new TabInfo(paramClass, paramBundle);
    if (this.mAttached)
    {
      Fragment localFragment1 = this.mFragmentManager.findFragmentByTag(str);
      TabInfo.access$102(localTabInfo, localFragment1);
      if ((localTabInfo.fragment != null) && (!localTabInfo.fragment.isDetached()))
      {
        FragmentTransaction localFragmentTransaction = this.mFragmentManager.beginTransaction();
        Fragment localFragment2 = localTabInfo.fragment;
        localFragmentTransaction.detach(localFragment2);
        localFragmentTransaction.commit();
      }
    }
    this.mTabs.add(localTabInfo);
    addTab(paramTabSpec);
  }

  protected void onAttachedToWindow()
  {
    super.onAttachedToWindow();
    String str1 = getCurrentTabTag();
    FragmentTransaction localFragmentTransaction = null;
    int i = 0;
    int j = this.mTabs.size();
    if (i < j)
    {
      TabInfo localTabInfo = (TabInfo)this.mTabs.get(i);
      FragmentManager localFragmentManager = this.mFragmentManager;
      String str2 = localTabInfo.tag;
      Fragment localFragment1 = localFragmentManager.findFragmentByTag(str2);
      TabInfo.access$102(localTabInfo, localFragment1);
      if ((localTabInfo.fragment != null) && (!localTabInfo.fragment.isDetached()))
      {
        if (!localTabInfo.tag.equals(str1))
          break label114;
        this.mLastTab = localTabInfo;
      }
      while (true)
      {
        i++;
        break;
        label114: if (localFragmentTransaction == null)
          localFragmentTransaction = this.mFragmentManager.beginTransaction();
        Fragment localFragment2 = localTabInfo.fragment;
        localFragmentTransaction.detach(localFragment2);
      }
    }
    this.mAttached = true;
    localFragmentTransaction = doTabChanged(str1, localFragmentTransaction);
    if (localFragmentTransaction != null)
    {
      localFragmentTransaction.commit();
      this.mFragmentManager.executePendingTransactions();
    }
  }

  protected void onDetachedFromWindow()
  {
    super.onDetachedFromWindow();
    this.mAttached = null;
  }

  protected void onRestoreInstanceState(Parcelable paramParcelable)
  {
    SavedState localSavedState = (SavedState)paramParcelable;
    Parcelable localParcelable = localSavedState.getSuperState();
    super.onRestoreInstanceState(localParcelable);
    String str = localSavedState.curTab;
    setCurrentTabByTag(str);
  }

  protected Parcelable onSaveInstanceState()
  {
    Parcelable localParcelable = super.onSaveInstanceState();
    SavedState localSavedState = new SavedState();
    String str = getCurrentTabTag();
    localSavedState.curTab = str;
    return localSavedState;
  }

  public void onTabChanged(String paramString)
  {
    if (this.mAttached)
    {
      FragmentTransaction localFragmentTransaction = doTabChanged(paramString, null);
      if (localFragmentTransaction != null)
        localFragmentTransaction.commit();
    }
    if (this.mOnTabChangeListener != null)
      this.mOnTabChangeListener.onTabChanged(paramString);
  }

  public void setOnTabChangedListener(TabHost.OnTabChangeListener paramOnTabChangeListener)
  {
    this.mOnTabChangeListener = paramOnTabChangeListener;
  }

  @Deprecated
  public void setup()
  {
    throw new IllegalStateException("Must call setup() that takes a Context and FragmentManager");
  }

  public void setup(Context paramContext, FragmentManager paramFragmentManager)
  {
    super.setup();
    this.mContext = paramContext;
    this.mFragmentManager = paramFragmentManager;
    ensureContent();
  }

  public void setup(Context paramContext, FragmentManager paramFragmentManager, int paramInt)
  {
    super.setup();
    this.mContext = paramContext;
    this.mFragmentManager = paramFragmentManager;
    this.mContainerId = paramInt;
    ensureContent();
    this.mRealTabContent.setId(paramInt);
    if (getId() == -1)
      setId(16908306);
  }

  class SavedState extends View.BaseSavedState
  {

    @Signature({"Landroid/os/Parcelable$Creator", "<", "Landroid/support/v4/app/FragmentTabHost$SavedState;", ">;"})
    public static final Parcelable.Creator CREATOR = new FragmentTabHost.SavedState.1();
    String curTab;

    private SavedState()
    {
      super();
      String str = this$1.readString();
      this.curTab = str;
    }

    SavedState()
    {
      super();
    }

    public String toString()
    {
      StringBuilder localStringBuilder1 = new StringBuilder().append("FragmentTabHost.SavedState{");
      String str1 = Integer.toHexString(System.identityHashCode(this));
      StringBuilder localStringBuilder2 = localStringBuilder1.append(str1).append(" curTab=");
      String str2 = this.curTab;
      return str2 + "}";
    }

    public void writeToParcel(Parcel paramParcel, int paramInt)
    {
      super.writeToParcel(paramParcel, paramInt);
      String str = this.curTab;
      paramParcel.writeString(str);
    }
  }

  class DummyTabFactory
    implements TabHost.TabContentFactory
  {
    public DummyTabFactory()
    {
    }

    public View createTabContent(String paramString)
    {
      Context localContext = FragmentTabHost.this;
      View localView = new View(localContext);
      localView.setMinimumWidth(0);
      localView.setMinimumHeight(0);
      return localView;
    }
  }

  final class TabInfo
  {
    private final Bundle args;

    @Signature({"Ljava/lang/Class", "<*>;"})
    private final Class clss;
    private Fragment fragment;

    @Signature({"(", "Ljava/lang/String;", "Ljava/lang/Class", "<*>;", "Landroid/os/Bundle;", ")V"})
    TabInfo(Class paramBundle, Bundle arg3)
    {
      this.clss = paramBundle;
      Object localObject;
      this.args = localObject;
    }
  }
}