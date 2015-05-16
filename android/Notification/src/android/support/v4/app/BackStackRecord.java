package android.support.v4.app;

import android.support.v4.util.LogWriter;
import android.util.Log;
import dalvik.annotation.Signature;
import java.io.FileDescriptor;
import java.io.PrintWriter;
import java.util.ArrayList;

final class BackStackRecord extends FragmentTransaction
  implements FragmentManager.BackStackEntry, Runnable
{
  static final int OP_ADD = 1;
  static final int OP_ATTACH = 7;
  static final int OP_DETACH = 6;
  static final int OP_HIDE = 4;
  static final int OP_NULL = 0;
  static final int OP_REMOVE = 3;
  static final int OP_REPLACE = 2;
  static final int OP_SHOW = 5;
  static final String TAG = "FragmentManager";
  boolean mAddToBackStack;
  boolean mAllowAddToBackStack = true;
  int mBreadCrumbShortTitleRes;
  CharSequence mBreadCrumbShortTitleText;
  int mBreadCrumbTitleRes;
  CharSequence mBreadCrumbTitleText;
  boolean mCommitted;
  int mEnterAnim;
  int mExitAnim;
  Op mHead;
  int mIndex = -1;
  final FragmentManagerImpl mManager;
  String mName;
  int mNumOp;
  int mPopEnterAnim;
  int mPopExitAnim;
  Op mTail;
  int mTransition;
  int mTransitionStyle;

  public BackStackRecord(FragmentManagerImpl paramFragmentManagerImpl)
  {
    this.mManager = paramFragmentManagerImpl;
  }

  private void doAddOp(int paramInt1, Fragment paramFragment, String paramString, int paramInt2)
  {
    FragmentManagerImpl localFragmentManagerImpl = this.mManager;
    paramFragment.mFragmentManager = localFragmentManagerImpl;
    if (paramString != null)
    {
      if (paramFragment.mTag != null)
      {
        String str1 = paramFragment.mTag;
        if (!paramString.equals(str1))
        {
          StringBuilder localStringBuilder1 = new StringBuilder().append("Can't change tag of fragment ").append(paramFragment).append(": was ");
          String str2 = paramFragment.mTag;
          String str3 = str2 + " now " + paramString;
          throw new IllegalStateException(str3);
        }
      }
      paramFragment.mTag = paramString;
    }
    if (paramInt1 != 0)
    {
      if ((paramFragment.mFragmentId != 0) && (paramFragment.mFragmentId != paramInt1))
      {
        StringBuilder localStringBuilder2 = new StringBuilder().append("Can't change container ID of fragment ").append(paramFragment).append(": was ");
        int i = paramFragment.mFragmentId;
        String str4 = i + " now " + paramInt1;
        throw new IllegalStateException(str4);
      }
      paramFragment.mFragmentId = paramInt1;
      paramFragment.mContainerId = paramInt1;
    }
    Op localOp = new Op();
    localOp.cmd = paramInt2;
    localOp.fragment = paramFragment;
    addOp(localOp);
  }

  public FragmentTransaction add(int paramInt, Fragment paramFragment)
  {
    doAddOp(paramInt, paramFragment, null, 1);
    return this;
  }

  public FragmentTransaction add(int paramInt, Fragment paramFragment, String paramString)
  {
    doAddOp(paramInt, paramFragment, paramString, 1);
    return this;
  }

  public FragmentTransaction add(Fragment paramFragment, String paramString)
  {
    doAddOp(0, paramFragment, paramString, 1);
    return this;
  }

  void addOp(Op paramOp)
  {
    if (this.mHead == null)
    {
      this.mTail = paramOp;
      this.mHead = paramOp;
    }
    while (true)
    {
      int i = this.mEnterAnim;
      paramOp.enterAnim = i;
      int j = this.mExitAnim;
      paramOp.exitAnim = j;
      int k = this.mPopEnterAnim;
      paramOp.popEnterAnim = k;
      int m = this.mPopExitAnim;
      paramOp.popExitAnim = m;
      int n = this.mNumOp;
      int i1;
      i1++;
      this.mNumOp = n;
      return;
      Op localOp = this.mTail;
      paramOp.prev = localOp;
      this.mTail.next = paramOp;
      this.mTail = paramOp;
    }
  }

  public FragmentTransaction addToBackStack(String paramString)
  {
    if (!this.mAllowAddToBackStack)
      throw new IllegalStateException("This FragmentTransaction is not allowed to be added to the back stack.");
    this.mAddToBackStack = true;
    this.mName = paramString;
    return this;
  }

  public FragmentTransaction attach(Fragment paramFragment)
  {
    Op localOp = new Op();
    localOp.cmd = 7;
    localOp.fragment = paramFragment;
    addOp(localOp);
    return this;
  }

  void bumpBackStackNesting(int paramInt)
  {
    boolean bool = this.mAddToBackStack;
    if (!bool);
    while (true)
    {
      return;
      FragmentManagerImpl.DEBUG = bool;
      if (bool)
      {
        String str1 = "Bump nesting in " + this + " by " + paramInt;
        Log.v("FragmentManager", str1);
      }
      for (Op localOp = this.mHead; localOp != null; localOp = localOp.next)
      {
        if (localOp.fragment != null)
        {
          Fragment localFragment1 = localOp.fragment;
          int i = localFragment1.mBackStackNesting + paramInt;
          localFragment1.mBackStackNesting = i;
          FragmentManagerImpl.DEBUG = localFragment1;
          if (localFragment1 != null)
          {
            StringBuilder localStringBuilder1 = new StringBuilder().append("Bump nesting of ");
            Fragment localFragment2 = localOp.fragment;
            StringBuilder localStringBuilder2 = localStringBuilder1.append(localFragment2).append(" to ");
            int j = localOp.fragment.mBackStackNesting;
            String str2 = j;
            Log.v("FragmentManager", str2);
          }
        }
        if (localOp.removed == null)
          continue;
        for (int k = localOp.removed.size() + -1; k >= 0; k--)
        {
          Fragment localFragment3 = (Fragment)localOp.removed.get(k);
          int m = localFragment3.mBackStackNesting + paramInt;
          localFragment3.mBackStackNesting = m;
          FragmentManagerImpl.DEBUG = m;
          if (m == 0)
            continue;
          StringBuilder localStringBuilder3 = new StringBuilder().append("Bump nesting of ").append(localFragment3).append(" to ");
          int n = localFragment3.mBackStackNesting;
          String str3 = n;
          Log.v("FragmentManager", str3);
        }
      }
    }
  }

  public int commit()
  {
    return commitInternal(null);
  }

  public int commitAllowingStateLoss()
  {
    return commitInternal(true);
  }

  int commitInternal(boolean paramBoolean)
  {
    FileDescriptor localFileDescriptor = null;
    boolean bool = this.mCommitted;
    if (bool)
      throw new IllegalStateException("commit already called");
    FragmentManagerImpl.DEBUG = bool;
    if (bool)
    {
      String str = "Commit: " + this;
      Log.v("FragmentManager", str);
      LogWriter localLogWriter = new LogWriter("FragmentManager");
      PrintWriter localPrintWriter = new PrintWriter(localLogWriter);
      dump("  ", localFileDescriptor, localPrintWriter, localFileDescriptor);
    }
    this.mCommitted = true;
    int i;
    if (this.mAddToBackStack)
      i = this.mManager.allocBackStackIndex(this);
    for (this.mIndex = i; ; this.mIndex = -1)
    {
      this.mManager.enqueueAction(this, paramBoolean);
      return this.mIndex;
    }
  }

  public FragmentTransaction detach(Fragment paramFragment)
  {
    Op localOp = new Op();
    localOp.cmd = 6;
    localOp.fragment = paramFragment;
    addOp(localOp);
    return this;
  }

  public FragmentTransaction disallowAddToBackStack()
  {
    if (this.mAddToBackStack)
      throw new IllegalStateException("This transaction is already being added to the back stack");
    this.mAllowAddToBackStack = null;
    return this;
  }

  public void dump(String paramString, FileDescriptor paramFileDescriptor, PrintWriter paramPrintWriter, String[] paramArrayOfString)
  {
    dump(paramString, paramPrintWriter, true);
  }

  public void dump(String paramString, PrintWriter paramPrintWriter, boolean paramBoolean)
  {
    if (paramBoolean)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.print("mName=");
      String str1 = this.mName;
      paramPrintWriter.print(str1);
      paramPrintWriter.print(" mIndex=");
      int i = this.mIndex;
      paramPrintWriter.print(i);
      paramPrintWriter.print(" mCommitted=");
      boolean bool = this.mCommitted;
      paramPrintWriter.println(bool);
      if (this.mTransition != 0)
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mTransition=#");
        String str2 = Integer.toHexString(this.mTransition);
        paramPrintWriter.print(str2);
        paramPrintWriter.print(" mTransitionStyle=#");
        String str3 = Integer.toHexString(this.mTransitionStyle);
        paramPrintWriter.println(str3);
      }
      if ((this.mEnterAnim != 0) || (this.mExitAnim != 0))
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mEnterAnim=#");
        String str4 = Integer.toHexString(this.mEnterAnim);
        paramPrintWriter.print(str4);
        paramPrintWriter.print(" mExitAnim=#");
        String str5 = Integer.toHexString(this.mExitAnim);
        paramPrintWriter.println(str5);
      }
      if ((this.mPopEnterAnim != 0) || (this.mPopExitAnim != 0))
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mPopEnterAnim=#");
        String str6 = Integer.toHexString(this.mPopEnterAnim);
        paramPrintWriter.print(str6);
        paramPrintWriter.print(" mPopExitAnim=#");
        String str7 = Integer.toHexString(this.mPopExitAnim);
        paramPrintWriter.println(str7);
      }
      if ((this.mBreadCrumbTitleRes != 0) || (this.mBreadCrumbTitleText != null))
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mBreadCrumbTitleRes=#");
        String str8 = Integer.toHexString(this.mBreadCrumbTitleRes);
        paramPrintWriter.print(str8);
        paramPrintWriter.print(" mBreadCrumbTitleText=");
        CharSequence localCharSequence1 = this.mBreadCrumbTitleText;
        paramPrintWriter.println(localCharSequence1);
      }
      if ((this.mBreadCrumbShortTitleRes != 0) || (this.mBreadCrumbShortTitleText != null))
      {
        paramPrintWriter.print(paramString);
        paramPrintWriter.print("mBreadCrumbShortTitleRes=#");
        String str9 = Integer.toHexString(this.mBreadCrumbShortTitleRes);
        paramPrintWriter.print(str9);
        paramPrintWriter.print(" mBreadCrumbShortTitleText=");
        CharSequence localCharSequence2 = this.mBreadCrumbShortTitleText;
        paramPrintWriter.println(localCharSequence2);
      }
    }
    if (this.mHead != null)
    {
      paramPrintWriter.print(paramString);
      paramPrintWriter.println("Operations:");
      String str10 = paramString + "    ";
      Op localOp = this.mHead;
      for (int j = 0; localOp != null; j++)
      {
        String str11;
        int m;
        switch (localOp.cmd)
        {
        default:
          StringBuilder localStringBuilder = new StringBuilder().append("cmd=");
          int k = localOp.cmd;
          str11 = k;
          paramPrintWriter.print(paramString);
          paramPrintWriter.print("  Op #");
          paramPrintWriter.print(j);
          paramPrintWriter.print(": ");
          paramPrintWriter.print(str11);
          paramPrintWriter.print(" ");
          Fragment localFragment = localOp.fragment;
          paramPrintWriter.println(localFragment);
          if (paramBoolean)
          {
            if ((localOp.enterAnim != 0) || (localOp.exitAnim != 0))
            {
              paramPrintWriter.print(paramString);
              paramPrintWriter.print("enterAnim=#");
              String str12 = Integer.toHexString(localOp.enterAnim);
              paramPrintWriter.print(str12);
              paramPrintWriter.print(" exitAnim=#");
              String str13 = Integer.toHexString(localOp.exitAnim);
              paramPrintWriter.println(str13);
            }
            if ((localOp.popEnterAnim != 0) || (localOp.popExitAnim != 0))
            {
              paramPrintWriter.print(paramString);
              paramPrintWriter.print("popEnterAnim=#");
              String str14 = Integer.toHexString(localOp.popEnterAnim);
              paramPrintWriter.print(str14);
              paramPrintWriter.print(" popExitAnim=#");
              String str15 = Integer.toHexString(localOp.popExitAnim);
              paramPrintWriter.println(str15);
            }
          }
          if ((localOp.removed == null) || (localOp.removed.size() <= 0))
            break label892;
          m = null;
          label721: int n = localOp.removed.size();
          if (m >= n)
            break label892;
          paramPrintWriter.print(str10);
          if (localOp.removed.size() != 1)
            break;
          paramPrintWriter.print("Removed: ");
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        }
        while (true)
        {
          Object localObject = localOp.removed.get(m);
          paramPrintWriter.println(localObject);
          m++;
          break label721;
          str11 = "NULL";
          break;
          str11 = "ADD";
          break;
          str11 = "REPLACE";
          break;
          str11 = "REMOVE";
          break;
          str11 = "HIDE";
          break;
          str11 = "SHOW";
          break;
          str11 = "DETACH";
          break;
          str11 = "ATTACH";
          break;
          if (m == 0)
            paramPrintWriter.println("Removed:");
          paramPrintWriter.print(str10);
          paramPrintWriter.print("  #");
          paramPrintWriter.print(m);
          paramPrintWriter.print(": ");
        }
        label892: localOp = localOp.next;
      }
    }
  }

  public CharSequence getBreadCrumbShortTitle()
  {
    int i = this.mBreadCrumbShortTitleRes;
    int j;
    if (i != 0)
    {
      localObject = this.mManager.mActivity;
      j = this.mBreadCrumbShortTitleRes;
    }
    for (Object localObject = ((FragmentActivity)localObject).getText(j); ; localObject = this.mBreadCrumbShortTitleText)
      return localObject;
  }

  public int getBreadCrumbShortTitleRes()
  {
    return this.mBreadCrumbShortTitleRes;
  }

  public CharSequence getBreadCrumbTitle()
  {
    int i = this.mBreadCrumbTitleRes;
    int j;
    if (i != 0)
    {
      localObject = this.mManager.mActivity;
      j = this.mBreadCrumbTitleRes;
    }
    for (Object localObject = ((FragmentActivity)localObject).getText(j); ; localObject = this.mBreadCrumbTitleText)
      return localObject;
  }

  public int getBreadCrumbTitleRes()
  {
    return this.mBreadCrumbTitleRes;
  }

  public int getId()
  {
    return this.mIndex;
  }

  public String getName()
  {
    return this.mName;
  }

  public int getTransition()
  {
    return this.mTransition;
  }

  public int getTransitionStyle()
  {
    return this.mTransitionStyle;
  }

  public FragmentTransaction hide(Fragment paramFragment)
  {
    Op localOp = new Op();
    localOp.cmd = 4;
    localOp.fragment = paramFragment;
    addOp(localOp);
    return this;
  }

  public boolean isAddToBackStackAllowed()
  {
    return this.mAllowAddToBackStack;
  }

  public boolean isEmpty()
  {
    int i = this.mNumOp;
    if (i == 0)
      i = 1;
    while (true)
    {
      return i;
      Object localObject = null;
    }
  }

  public void popFromBackStack(boolean paramBoolean)
  {
    FileDescriptor localFileDescriptor = null;
    boolean bool1 = null;
    int i = -1;
    boolean bool2;
    FragmentManagerImpl.DEBUG = bool2;
    if (bool2)
    {
      String str1 = "popFromBackStack: " + this;
      Log.v("FragmentManager", str1);
      LogWriter localLogWriter = new LogWriter("FragmentManager");
      PrintWriter localPrintWriter = new PrintWriter(localLogWriter);
      dump("  ", localFileDescriptor, localPrintWriter, localFileDescriptor);
    }
    bumpBackStackNesting(i);
    Op localOp = this.mTail;
    if (localOp != null)
    {
      Fragment localFragment1;
      switch (localOp.cmd)
      {
      default:
        StringBuilder localStringBuilder = new StringBuilder().append("Unknown cmd: ");
        int j = localOp.cmd;
        String str2 = j;
        throw new IllegalArgumentException(str2);
      case 1:
        localFragment1 = localOp.fragment;
        int k = localOp.popExitAnim;
        localFragment1.mNextAnim = k;
        FragmentManagerImpl localFragmentManagerImpl1 = this.mManager;
        int m = FragmentManagerImpl.reverseTransit(this.mTransition);
        int n = this.mTransitionStyle;
        localFragmentManagerImpl1.removeFragment(localFragment1, m, n);
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      }
      while (true)
      {
        localOp = localOp.prev;
        break;
        localFragment1 = localOp.fragment;
        if (localFragment1 != null)
        {
          int i1 = localOp.popExitAnim;
          localFragment1.mNextAnim = i1;
          FragmentManagerImpl localFragmentManagerImpl2 = this.mManager;
          int i2 = FragmentManagerImpl.reverseTransit(this.mTransition);
          int i3 = this.mTransitionStyle;
          localFragmentManagerImpl2.removeFragment(localFragment1, i2, i3);
        }
        if (localOp.removed == null)
          continue;
        for (int i4 = null; ; i4++)
        {
          int i5 = localOp.removed.size();
          if (i4 >= i5)
            break;
          Fragment localFragment2 = (Fragment)localOp.removed.get(i4);
          int i6 = localOp.popEnterAnim;
          localFragment2.mNextAnim = i6;
          this.mManager.addFragment(localFragment2, bool1);
        }
        localFragment1 = localOp.fragment;
        int i7 = localOp.popEnterAnim;
        localFragment1.mNextAnim = i7;
        this.mManager.addFragment(localFragment1, bool1);
        continue;
        localFragment1 = localOp.fragment;
        int i8 = localOp.popEnterAnim;
        localFragment1.mNextAnim = i8;
        FragmentManagerImpl localFragmentManagerImpl3 = this.mManager;
        int i9 = FragmentManagerImpl.reverseTransit(this.mTransition);
        int i10 = this.mTransitionStyle;
        localFragmentManagerImpl3.showFragment(localFragment1, i9, i10);
        continue;
        localFragment1 = localOp.fragment;
        int i11 = localOp.popExitAnim;
        localFragment1.mNextAnim = i11;
        FragmentManagerImpl localFragmentManagerImpl4 = this.mManager;
        int i12 = FragmentManagerImpl.reverseTransit(this.mTransition);
        int i13 = this.mTransitionStyle;
        localFragmentManagerImpl4.hideFragment(localFragment1, i12, i13);
        continue;
        localFragment1 = localOp.fragment;
        int i14 = localOp.popEnterAnim;
        localFragment1.mNextAnim = i14;
        FragmentManagerImpl localFragmentManagerImpl5 = this.mManager;
        int i15 = FragmentManagerImpl.reverseTransit(this.mTransition);
        int i16 = this.mTransitionStyle;
        localFragmentManagerImpl5.attachFragment(localFragment1, i15, i16);
        continue;
        localFragment1 = localOp.fragment;
        int i17 = localOp.popEnterAnim;
        localFragment1.mNextAnim = i17;
        FragmentManagerImpl localFragmentManagerImpl6 = this.mManager;
        int i18 = FragmentManagerImpl.reverseTransit(this.mTransition);
        int i19 = this.mTransitionStyle;
        localFragmentManagerImpl6.detachFragment(localFragment1, i18, i19);
      }
    }
    if (paramBoolean)
    {
      FragmentManagerImpl localFragmentManagerImpl7 = this.mManager;
      int i20 = this.mManager.mCurState;
      int i21 = FragmentManagerImpl.reverseTransit(this.mTransition);
      int i22 = this.mTransitionStyle;
      localFragmentManagerImpl7.moveToState(i20, i21, i22, true);
    }
    if (this.mIndex >= 0)
    {
      FragmentManagerImpl localFragmentManagerImpl8 = this.mManager;
      int i23 = this.mIndex;
      localFragmentManagerImpl8.freeBackStackIndex(i23);
      this.mIndex = i;
    }
  }

  public FragmentTransaction remove(Fragment paramFragment)
  {
    Op localOp = new Op();
    localOp.cmd = 3;
    localOp.fragment = paramFragment;
    addOp(localOp);
    return this;
  }

  public FragmentTransaction replace(int paramInt, Fragment paramFragment)
  {
    return replace(paramInt, paramFragment, null);
  }

  public FragmentTransaction replace(int paramInt, Fragment paramFragment, String paramString)
  {
    if (paramInt == 0)
      throw new IllegalArgumentException("Must use non-zero containerViewId");
    doAddOp(paramInt, paramFragment, paramString, 2);
    return this;
  }

  public void run()
  {
    int i = 1;
    boolean bool1 = null;
    boolean bool2;
    FragmentManagerImpl.DEBUG = bool2;
    if (bool2)
    {
      String str1 = "Run: " + this;
      Log.v("FragmentManager", str1);
    }
    if ((this.mAddToBackStack) && (this.mIndex < 0))
      throw new IllegalStateException("addToBackStack() called after commit()");
    bumpBackStackNesting(i);
    Op localOp = this.mHead;
    if (localOp != null)
    {
      Fragment localFragment1;
      switch (localOp.cmd)
      {
      default:
        StringBuilder localStringBuilder1 = new StringBuilder().append("Unknown cmd: ");
        int j = localOp.cmd;
        String str2 = j;
        throw new IllegalArgumentException(str2);
      case 1:
        localFragment1 = localOp.fragment;
        int k = localOp.enterAnim;
        localFragment1.mNextAnim = k;
        this.mManager.addFragment(localFragment1, bool1);
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      }
      while (true)
      {
        localOp = localOp.next;
        break;
        localFragment1 = localOp.fragment;
        if (this.mManager.mAdded != null)
        {
          int m = null;
          int n = this.mManager.mAdded.size();
          if (m < n)
          {
            ArrayList localArrayList1 = this.mManager.mAdded;
            Fragment localFragment2 = (Fragment)localArrayList1.get(m);
            FragmentManagerImpl.DEBUG = localArrayList1;
            if (localArrayList1 != null)
            {
              String str3 = "OP_REPLACE: adding=" + localFragment1 + " old=" + localFragment2;
              Log.v("FragmentManager", str3);
            }
            if (localFragment1 != null)
            {
              int i1 = localFragment2.mContainerId;
              int i2 = localFragment1.mContainerId;
              if (i1 != i2);
            }
            else
            {
              if (localFragment2 != localFragment1)
                break label378;
              localFragment1 = null;
              localOp.fragment = localFragment1;
            }
            while (true)
            {
              m++;
              break;
              label378: if (localOp.removed == null)
              {
                ArrayList localArrayList2 = new ArrayList();
                localOp.removed = localArrayList2;
              }
              localOp.removed.add(localFragment2);
              int i3 = localOp.exitAnim;
              localFragment2.mNextAnim = i3;
              if (this.mAddToBackStack)
              {
                int i4 = localFragment2.mBackStackNesting;
                bool2++;
                localFragment2.mBackStackNesting = i4;
                FragmentManagerImpl.DEBUG = i4;
                if (i4 != 0)
                {
                  StringBuilder localStringBuilder2 = new StringBuilder().append("Bump nesting of ").append(localFragment2).append(" to ");
                  int i5 = localFragment2.mBackStackNesting;
                  String str4 = i5;
                  Log.v("FragmentManager", str4);
                }
              }
              FragmentManagerImpl localFragmentManagerImpl1 = this.mManager;
              int i6 = this.mTransition;
              int i7 = this.mTransitionStyle;
              localFragmentManagerImpl1.removeFragment(localFragment2, i6, i7);
            }
          }
        }
        if (localFragment1 == null)
          continue;
        int i8 = localOp.enterAnim;
        localFragment1.mNextAnim = i8;
        this.mManager.addFragment(localFragment1, bool1);
        continue;
        localFragment1 = localOp.fragment;
        int i9 = localOp.exitAnim;
        localFragment1.mNextAnim = i9;
        FragmentManagerImpl localFragmentManagerImpl2 = this.mManager;
        int i10 = this.mTransition;
        int i11 = this.mTransitionStyle;
        localFragmentManagerImpl2.removeFragment(localFragment1, i10, i11);
        continue;
        localFragment1 = localOp.fragment;
        int i12 = localOp.exitAnim;
        localFragment1.mNextAnim = i12;
        FragmentManagerImpl localFragmentManagerImpl3 = this.mManager;
        int i13 = this.mTransition;
        int i14 = this.mTransitionStyle;
        localFragmentManagerImpl3.hideFragment(localFragment1, i13, i14);
        continue;
        localFragment1 = localOp.fragment;
        int i15 = localOp.enterAnim;
        localFragment1.mNextAnim = i15;
        FragmentManagerImpl localFragmentManagerImpl4 = this.mManager;
        int i16 = this.mTransition;
        int i17 = this.mTransitionStyle;
        localFragmentManagerImpl4.showFragment(localFragment1, i16, i17);
        continue;
        localFragment1 = localOp.fragment;
        int i18 = localOp.exitAnim;
        localFragment1.mNextAnim = i18;
        FragmentManagerImpl localFragmentManagerImpl5 = this.mManager;
        int i19 = this.mTransition;
        int i20 = this.mTransitionStyle;
        localFragmentManagerImpl5.detachFragment(localFragment1, i19, i20);
        continue;
        localFragment1 = localOp.fragment;
        int i21 = localOp.enterAnim;
        localFragment1.mNextAnim = i21;
        FragmentManagerImpl localFragmentManagerImpl6 = this.mManager;
        int i22 = this.mTransition;
        int i23 = this.mTransitionStyle;
        localFragmentManagerImpl6.attachFragment(localFragment1, i22, i23);
      }
    }
    FragmentManagerImpl localFragmentManagerImpl7 = this.mManager;
    int i24 = this.mManager.mCurState;
    int i25 = this.mTransition;
    int i26 = this.mTransitionStyle;
    localFragmentManagerImpl7.moveToState(i24, i25, i26, i);
    if (this.mAddToBackStack)
      this.mManager.addBackStackState(this);
  }

  public FragmentTransaction setBreadCrumbShortTitle(int paramInt)
  {
    this.mBreadCrumbShortTitleRes = paramInt;
    this.mBreadCrumbShortTitleText = null;
    return this;
  }

  public FragmentTransaction setBreadCrumbShortTitle(CharSequence paramCharSequence)
  {
    this.mBreadCrumbShortTitleRes = null;
    this.mBreadCrumbShortTitleText = paramCharSequence;
    return this;
  }

  public FragmentTransaction setBreadCrumbTitle(int paramInt)
  {
    this.mBreadCrumbTitleRes = paramInt;
    this.mBreadCrumbTitleText = null;
    return this;
  }

  public FragmentTransaction setBreadCrumbTitle(CharSequence paramCharSequence)
  {
    this.mBreadCrumbTitleRes = null;
    this.mBreadCrumbTitleText = paramCharSequence;
    return this;
  }

  public FragmentTransaction setCustomAnimations(int paramInt1, int paramInt2)
  {
    return setCustomAnimations(paramInt1, paramInt2, 0, 0);
  }

  public FragmentTransaction setCustomAnimations(int paramInt1, int paramInt2, int paramInt3, int paramInt4)
  {
    this.mEnterAnim = paramInt1;
    this.mExitAnim = paramInt2;
    this.mPopEnterAnim = paramInt3;
    this.mPopExitAnim = paramInt4;
    return this;
  }

  public FragmentTransaction setTransition(int paramInt)
  {
    this.mTransition = paramInt;
    return this;
  }

  public FragmentTransaction setTransitionStyle(int paramInt)
  {
    this.mTransitionStyle = paramInt;
    return this;
  }

  public FragmentTransaction show(Fragment paramFragment)
  {
    Op localOp = new Op();
    localOp.cmd = 5;
    localOp.fragment = paramFragment;
    addOp(localOp);
    return this;
  }

  public String toString()
  {
    StringBuilder localStringBuilder = new StringBuilder(128);
    localStringBuilder.append("BackStackEntry{");
    String str1 = Integer.toHexString(System.identityHashCode(this));
    localStringBuilder.append(str1);
    if (this.mIndex >= 0)
    {
      localStringBuilder.append(" #");
      int i = this.mIndex;
      localStringBuilder.append(i);
    }
    if (this.mName != null)
    {
      localStringBuilder.append(" ");
      String str2 = this.mName;
      localStringBuilder.append(str2);
    }
    localStringBuilder.append("}");
    return localStringBuilder.toString();
  }

  final class Op
  {
    int cmd;
    int enterAnim;
    int exitAnim;
    Fragment fragment;
    Op next;
    int popEnterAnim;
    int popExitAnim;
    Op prev;

    @Signature({"Ljava/util/ArrayList", "<", "Landroid/support/v4/app/Fragment;", ">;"})
    ArrayList removed;
  }
}