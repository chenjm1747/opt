package android.support.v4.app;

import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;

public class ListFragment extends Fragment
{
  static final int INTERNAL_EMPTY_ID = 16711681;
  static final int INTERNAL_LIST_CONTAINER_ID = 16711683;
  static final int INTERNAL_PROGRESS_CONTAINER_ID = 16711682;
  ListAdapter mAdapter;
  CharSequence mEmptyText;
  View mEmptyView;
  private final Handler mHandler;
  ListView mList;
  View mListContainer;
  boolean mListShown;
  private final AdapterView.OnItemClickListener mOnClickListener;
  View mProgressContainer;
  private final Runnable mRequestFocus;
  TextView mStandardEmptyView;

  public ListFragment()
  {
    Handler localHandler = new Handler();
    this.mHandler = localHandler;
    ListFragment.1 local1 = new ListFragment.1(this);
    this.mRequestFocus = local1;
    ListFragment.2 local2 = new ListFragment.2(this);
    this.mOnClickListener = local2;
  }

  private void ensureList()
  {
    boolean bool = null;
    if (this.mList != null)
      return;
    View localView1 = getView();
    if (localView1 == null)
      throw new IllegalStateException("Content view not yet created");
    if ((localView1 instanceof ListView))
    {
      ListView localListView1 = (ListView)localView1;
      this.mList = localView1;
      label46: this.mListShown = true;
      ListView localListView2 = this.mList;
      AdapterView.OnItemClickListener localOnItemClickListener = this.mOnClickListener;
      localListView2.setOnItemClickListener(localOnItemClickListener);
      if (this.mAdapter == null)
        break label326;
      ListAdapter localListAdapter = this.mAdapter;
      this.mAdapter = null;
      setListAdapter(localListAdapter);
    }
    while (true)
    {
      Handler localHandler = this.mHandler;
      Runnable localRunnable = this.mRequestFocus;
      localHandler.post(localRunnable);
      break;
      TextView localTextView1 = (TextView)localView1.findViewById(16711681);
      this.mStandardEmptyView = localTextView1;
      if (this.mStandardEmptyView == null)
      {
        View localView2 = localView1.findViewById(16908292);
        this.mEmptyView = localView2;
      }
      View localView5;
      while (true)
      {
        View localView3 = localView1.findViewById(16711682);
        this.mProgressContainer = localView3;
        View localView4 = localView1.findViewById(16711683);
        this.mListContainer = localView4;
        localView5 = localView1.findViewById(16908298);
        if ((localView5 instanceof ListView))
          break;
        if (localView5 == null)
        {
          throw new RuntimeException("Your content must have a ListView whose id attribute is 'android.R.id.list'");
          this.mStandardEmptyView.setVisibility(8);
          continue;
        }
        throw new RuntimeException("Content has view with id attribute 'android.R.id.list' that is not a ListView class");
      }
      ListView localListView3 = (ListView)localView5;
      this.mList = localView5;
      if (this.mEmptyView != null)
      {
        ListView localListView4 = this.mList;
        View localView6 = this.mEmptyView;
        localListView4.setEmptyView(localView6);
        break label46;
      }
      if (this.mEmptyText == null)
        break label46;
      TextView localTextView2 = this.mStandardEmptyView;
      CharSequence localCharSequence = this.mEmptyText;
      localTextView2.setText(localCharSequence);
      ListView localListView5 = this.mList;
      TextView localTextView3 = this.mStandardEmptyView;
      localListView5.setEmptyView(localTextView3);
      break label46;
      label326: if (this.mProgressContainer == null)
        continue;
      setListShown(bool, bool);
    }
  }

  private void setListShown(boolean paramBoolean1, boolean paramBoolean2)
  {
    int i = 17432577;
    int j = 17432576;
    int k = 8;
    int m = 0;
    ensureList();
    if (this.mProgressContainer == null)
      throw new IllegalStateException("Can't be used with a custom content view");
    if (this.mListShown == paramBoolean1)
      return;
    this.mListShown = paramBoolean1;
    if (paramBoolean1)
    {
      if (paramBoolean2)
      {
        View localView1 = this.mProgressContainer;
        Animation localAnimation1 = AnimationUtils.loadAnimation(getActivity(), i);
        localView1.startAnimation(localAnimation1);
        View localView2 = this.mListContainer;
        Animation localAnimation2 = AnimationUtils.loadAnimation(getActivity(), j);
        localView2.startAnimation(localAnimation2);
      }
      while (true)
      {
        this.mProgressContainer.setVisibility(k);
        this.mListContainer.setVisibility(m);
        break;
        this.mProgressContainer.clearAnimation();
        this.mListContainer.clearAnimation();
      }
    }
    if (paramBoolean2)
    {
      View localView3 = this.mProgressContainer;
      Animation localAnimation3 = AnimationUtils.loadAnimation(getActivity(), j);
      localView3.startAnimation(localAnimation3);
      View localView4 = this.mListContainer;
      Animation localAnimation4 = AnimationUtils.loadAnimation(getActivity(), i);
      localView4.startAnimation(localAnimation4);
    }
    while (true)
    {
      this.mProgressContainer.setVisibility(m);
      this.mListContainer.setVisibility(k);
      break;
      this.mProgressContainer.clearAnimation();
      this.mListContainer.clearAnimation();
    }
  }

  public ListAdapter getListAdapter()
  {
    return this.mAdapter;
  }

  public ListView getListView()
  {
    ensureList();
    return this.mList;
  }

  public long getSelectedItemId()
  {
    ensureList();
    return this.mList.getSelectedItemId();
  }

  public int getSelectedItemPosition()
  {
    ensureList();
    return this.mList.getSelectedItemPosition();
  }

  public View onCreateView(LayoutInflater paramLayoutInflater, ViewGroup paramViewGroup, Bundle paramBundle)
  {
    FragmentActivity localFragmentActivity1 = getActivity();
    FrameLayout localFrameLayout1 = new FrameLayout(localFragmentActivity1);
    LinearLayout localLinearLayout = new LinearLayout(localFragmentActivity1);
    localLinearLayout.setId(16711682);
    localLinearLayout.setOrientation(1);
    localLinearLayout.setVisibility(8);
    localLinearLayout.setGravity(17);
    ProgressBar localProgressBar = new ProgressBar(localFragmentActivity1, null, 16842874);
    FrameLayout.LayoutParams localLayoutParams1 = new FrameLayout.LayoutParams(-1, -1);
    localLinearLayout.addView(localProgressBar, localLayoutParams1);
    FrameLayout.LayoutParams localLayoutParams2 = new FrameLayout.LayoutParams(-1, -1);
    localFrameLayout1.addView(localLinearLayout, localLayoutParams2);
    FrameLayout localFrameLayout2 = new FrameLayout(localFragmentActivity1);
    localFrameLayout2.setId(16711683);
    FragmentActivity localFragmentActivity2 = getActivity();
    TextView localTextView = new TextView(localFragmentActivity2);
    localTextView.setId(16711681);
    localTextView.setGravity(17);
    FrameLayout.LayoutParams localLayoutParams3 = new FrameLayout.LayoutParams(-1, -1);
    localFrameLayout2.addView(localTextView, localLayoutParams3);
    FragmentActivity localFragmentActivity3 = getActivity();
    ListView localListView = new ListView(localFragmentActivity3);
    localListView.setId(16908298);
    localListView.setDrawSelectorOnTop(null);
    FrameLayout.LayoutParams localLayoutParams4 = new FrameLayout.LayoutParams(-1, -1);
    localFrameLayout2.addView(localListView, localLayoutParams4);
    FrameLayout.LayoutParams localLayoutParams5 = new FrameLayout.LayoutParams(-1, -1);
    localFrameLayout1.addView(localFrameLayout2, localLayoutParams5);
    FrameLayout.LayoutParams localLayoutParams6 = new FrameLayout.LayoutParams(-1, -1);
    localFrameLayout1.setLayoutParams(localLayoutParams6);
    return localFrameLayout1;
  }

  public void onDestroyView()
  {
    Handler localHandler = this.mHandler;
    Runnable localRunnable = this.mRequestFocus;
    localHandler.removeCallbacks(localRunnable);
    this.mList = null;
    this.mListShown = null;
    this.mListContainer = null;
    this.mProgressContainer = null;
    this.mEmptyView = null;
    this.mStandardEmptyView = null;
    super.onDestroyView();
  }

  public void onListItemClick(ListView paramListView, View paramView, int paramInt, long paramLong)
  {
  }

  public void onViewCreated(View paramView, Bundle paramBundle)
  {
    super.onViewCreated(paramView, paramBundle);
    ensureList();
  }

  public void setEmptyText(CharSequence paramCharSequence)
  {
    ensureList();
    if (this.mStandardEmptyView == null)
      throw new IllegalStateException("Can't be used with a custom content view");
    this.mStandardEmptyView.setText(paramCharSequence);
    if (this.mEmptyText == null)
    {
      ListView localListView = this.mList;
      TextView localTextView = this.mStandardEmptyView;
      localListView.setEmptyView(localTextView);
    }
    this.mEmptyText = paramCharSequence;
  }

  public void setListAdapter(ListAdapter paramListAdapter)
  {
    boolean bool1 = null;
    boolean bool2 = true;
    boolean bool3;
    if (this.mAdapter != null)
      bool3 = bool2;
    while (true)
    {
      this.mAdapter = paramListAdapter;
      if (this.mList != null)
      {
        this.mList.setAdapter(paramListAdapter);
        if ((!this.mListShown) && (bool3 == null))
        {
          if (getView().getWindowToken() != null)
            bool1 = bool2;
          setListShown(bool2, bool1);
        }
      }
      return;
      boolean bool4 = bool1;
    }
  }

  public void setListShown(boolean paramBoolean)
  {
    setListShown(paramBoolean, true);
  }

  public void setListShownNoAnimation(boolean paramBoolean)
  {
    setListShown(paramBoolean, null);
  }

  public void setSelection(int paramInt)
  {
    ensureList();
    this.mList.setSelection(paramInt);
  }
}