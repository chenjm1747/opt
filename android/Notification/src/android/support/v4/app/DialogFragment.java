package android.support.v4.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.DialogInterface.OnDismissListener;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;

public class DialogFragment extends Fragment
  implements DialogInterface.OnCancelListener, DialogInterface.OnDismissListener
{
  private static final String SAVED_BACK_STACK_ID = "android:backStackId";
  private static final String SAVED_CANCELABLE = "android:cancelable";
  private static final String SAVED_DIALOG_STATE_TAG = "android:savedDialogState";
  private static final String SAVED_SHOWS_DIALOG = "android:showsDialog";
  private static final String SAVED_STYLE = "android:style";
  private static final String SAVED_THEME = "android:theme";
  public static final int STYLE_NORMAL = 0;
  public static final int STYLE_NO_FRAME = 2;
  public static final int STYLE_NO_INPUT = 3;
  public static final int STYLE_NO_TITLE = 1;
  int mBackStackId = -1;
  boolean mCancelable = true;
  Dialog mDialog;
  boolean mDismissed;
  boolean mShownByMe;
  boolean mShowsDialog = true;
  int mStyle = null;
  int mTheme = null;
  boolean mViewDestroyed;

  public void dismiss()
  {
    dismissInternal(null);
  }

  public void dismissAllowingStateLoss()
  {
    dismissInternal(true);
  }

  void dismissInternal(boolean paramBoolean)
  {
    int i = 1;
    if (this.mDismissed);
    while (true)
    {
      return;
      this.mDismissed = i;
      this.mShownByMe = null;
      if (this.mDialog != null)
      {
        this.mDialog.dismiss();
        this.mDialog = null;
      }
      this.mViewDestroyed = i;
      if (this.mBackStackId >= 0)
      {
        FragmentManager localFragmentManager = getFragmentManager();
        int j = this.mBackStackId;
        localFragmentManager.popBackStack(j, i);
        this.mBackStackId = -1;
        continue;
      }
      FragmentTransaction localFragmentTransaction = getFragmentManager().beginTransaction();
      localFragmentTransaction.remove(this);
      if (paramBoolean)
      {
        localFragmentTransaction.commitAllowingStateLoss();
        continue;
      }
      localFragmentTransaction.commit();
    }
  }

  public Dialog getDialog()
  {
    return this.mDialog;
  }

  public LayoutInflater getLayoutInflater(Bundle paramBundle)
  {
    boolean bool = this.mShowsDialog;
    Object localObject1;
    if (!bool)
      localObject1 = super.getLayoutInflater(paramBundle);
    while (true)
    {
      return localObject1;
      localObject1 = onCreateDialog(paramBundle);
      this.mDialog = ((Dialog)localObject1);
      int i = this.mStyle;
      switch (i)
      {
      default:
      case 3:
      case 1:
      case 2:
      }
      while (true)
      {
        localObject2 = this.mDialog;
        if (localObject2 == null)
          break label116;
        localObject2 = (LayoutInflater)this.mDialog.getContext().getSystemService("layout_inflater");
        break;
        localObject2 = this.mDialog.getWindow();
        ((Window)localObject2).addFlags(24);
        localObject2 = this.mDialog;
        ((Dialog)localObject2).requestWindowFeature(1);
      }
      label116: Object localObject2 = (LayoutInflater)this.mActivity.getSystemService("layout_inflater");
    }
  }

  public boolean getShowsDialog()
  {
    return this.mShowsDialog;
  }

  public int getTheme()
  {
    return this.mTheme;
  }

  public boolean isCancelable()
  {
    return this.mCancelable;
  }

  public void onActivityCreated(Bundle paramBundle)
  {
    super.onActivityCreated(paramBundle);
    if (!this.mShowsDialog);
    while (true)
    {
      return;
      View localView = getView();
      if (localView != null)
      {
        if (localView.getParent() != null)
          throw new IllegalStateException("DialogFragment can not be attached to a container view");
        this.mDialog.setContentView(localView);
      }
      Dialog localDialog1 = this.mDialog;
      FragmentActivity localFragmentActivity = getActivity();
      localDialog1.setOwnerActivity(localFragmentActivity);
      Dialog localDialog2 = this.mDialog;
      boolean bool = this.mCancelable;
      localDialog2.setCancelable(bool);
      this.mDialog.setOnCancelListener(this);
      this.mDialog.setOnDismissListener(this);
      if (paramBundle == null)
        continue;
      Bundle localBundle = paramBundle.getBundle("android:savedDialogState");
      if (localBundle == null)
        continue;
      this.mDialog.onRestoreInstanceState(localBundle);
    }
  }

  public void onAttach(Activity paramActivity)
  {
    super.onAttach(paramActivity);
    if (!this.mShownByMe)
      this.mDismissed = null;
  }

  public void onCancel(DialogInterface paramDialogInterface)
  {
  }

  public void onCreate(Bundle paramBundle)
  {
    int i = 1;
    int j = 0;
    super.onCreate(paramBundle);
    int k = this.mContainerId;
    if (k == 0);
    for (k = i; ; k = j)
    {
      this.mShowsDialog = k;
      if (paramBundle != null)
      {
        int m = paramBundle.getInt("android:style", j);
        this.mStyle = m;
        int n = paramBundle.getInt("android:theme", j);
        this.mTheme = n;
        boolean bool1 = paramBundle.getBoolean("android:cancelable", i);
        this.mCancelable = bool1;
        boolean bool2 = this.mShowsDialog;
        boolean bool3 = paramBundle.getBoolean("android:showsDialog", i);
        this.mShowsDialog = bool3;
        int i1 = paramBundle.getInt("android:backStackId", -1);
        this.mBackStackId = i1;
      }
      return;
    }
  }

  public Dialog onCreateDialog(Bundle paramBundle)
  {
    FragmentActivity localFragmentActivity = getActivity();
    int i = getTheme();
    return new Dialog(localFragmentActivity, i);
  }

  public void onDestroyView()
  {
    super.onDestroyView();
    if (this.mDialog != null)
    {
      this.mViewDestroyed = true;
      this.mDialog.dismiss();
      this.mDialog = null;
    }
  }

  public void onDetach()
  {
    super.onDetach();
    if ((!this.mShownByMe) && (!this.mDismissed))
      this.mDismissed = true;
  }

  public void onDismiss(DialogInterface paramDialogInterface)
  {
    if (!this.mViewDestroyed)
      dismissInternal(true);
  }

  public void onSaveInstanceState(Bundle paramBundle)
  {
    super.onSaveInstanceState(paramBundle);
    if (this.mDialog != null)
    {
      Bundle localBundle = this.mDialog.onSaveInstanceState();
      if (localBundle != null)
        paramBundle.putBundle("android:savedDialogState", localBundle);
    }
    if (this.mStyle != 0)
    {
      int i = this.mStyle;
      paramBundle.putInt("android:style", i);
    }
    if (this.mTheme != 0)
    {
      int j = this.mTheme;
      paramBundle.putInt("android:theme", j);
    }
    if (!this.mCancelable)
    {
      boolean bool1 = this.mCancelable;
      paramBundle.putBoolean("android:cancelable", bool1);
    }
    if (!this.mShowsDialog)
    {
      boolean bool2 = this.mShowsDialog;
      paramBundle.putBoolean("android:showsDialog", bool2);
    }
    if (this.mBackStackId != -1)
    {
      int k = this.mBackStackId;
      paramBundle.putInt("android:backStackId", k);
    }
  }

  public void onStart()
  {
    super.onStart();
    if (this.mDialog != null)
    {
      this.mViewDestroyed = null;
      this.mDialog.show();
    }
  }

  public void onStop()
  {
    super.onStop();
    if (this.mDialog != null)
      this.mDialog.hide();
  }

  public void setCancelable(boolean paramBoolean)
  {
    this.mCancelable = paramBoolean;
    if (this.mDialog != null)
      this.mDialog.setCancelable(paramBoolean);
  }

  public void setShowsDialog(boolean paramBoolean)
  {
    this.mShowsDialog = paramBoolean;
  }

  public void setStyle(int paramInt1, int paramInt2)
  {
    this.mStyle = paramInt1;
    if ((this.mStyle == 2) || (this.mStyle == 3))
      this.mTheme = 16973913;
    if (paramInt2 != 0)
      this.mTheme = paramInt2;
  }

  public int show(FragmentTransaction paramFragmentTransaction, String paramString)
  {
    this.mDismissed = null;
    this.mShownByMe = true;
    paramFragmentTransaction.add(this, paramString);
    this.mViewDestroyed = null;
    int i = paramFragmentTransaction.commit();
    this.mBackStackId = i;
    return this.mBackStackId;
  }

  public void show(FragmentManager paramFragmentManager, String paramString)
  {
    this.mDismissed = null;
    this.mShownByMe = true;
    FragmentTransaction localFragmentTransaction = paramFragmentManager.beginTransaction();
    localFragmentTransaction.add(this, paramString);
    localFragmentTransaction.commit();
  }
}