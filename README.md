# YHWaterLayOutForSwift
瀑布流的实现
## 效果图
效果图如图所示：
![](http://ww2.sinaimg.cn/large/006HJ39wgy1fejrb1ncbgj30a90ii7a8.jpg)
## 使用方法  

该框架 只需要直接拖拽 `YHWaterLayOut.swift`文件  到需要的工程中， 挂上代理、实现代理方法即可。
 -  初始化
 ```
 let  layout = YHWaterLayOut()//初始化布局

        layout.delegate = self;//设置代理

   self.collectionView.collectionViewLayout = layout//赋值布局
```

- 代理方法
  ```
  /**
    * waterLayout:布局对象
    * width  计算出来的cell宽度
    * indexPath cell所在行
    * return  由cell宽度以及原图的尺寸计算出来的等比例高度
    */
   func  WaterLayOut(_waterLayout: YHWaterLayOut, cellForWidth width: CGFloat, heightForRowAtIndexPath indexPath:IndexPath) -> CGFloat

   /**
    * waterLayout:布局对象
    * return 使用者设置的列数
    */
   @objc optional func  waterLayOutForCellCloumnNum(_waterLayout : YHWaterLayOut)->NSInteger

   /**
    * waterLayout:布局对象
    * return 使用者设置的列数
    */
   @objc optional func  waterLayOutForCellCloumnMargin(_waterLayout : YHWaterLayOut)->CGFloat

   /**
    * waterLayout:布局对象
    * return 使用者设置的行间距
    */
   @objc optional func  waterLayOutForCellRowMargin(_waterLayout : YHWaterLayOut)->CGFloat

   /**
    * waterLayout:布局对象
    * return 使用者设置的四周边距
    */
   @objc optional func  waterLayOutForCellInSets(_waterLayout : YHWaterLayOut)->UIEdgeInsets
```
