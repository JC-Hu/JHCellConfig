# JHCellConfig

![Pod Version](https://img.shields.io/cocoapods/v/JHCellConfig.svg?style=flat)
![Pod Platform](https://img.shields.io/cocoapods/p/JHCellConfig.svg?style=flat)
![Pod License](https://img.shields.io/cocoapods/l/JHCellConfig.svg?style=flat)

```ruby
pod 'JHCellConfig', '~> 2.1.0'
```

适用于UITableView的“蝇量级”框架。
将业务复杂度集中，减少代码量，提高可阅读性。

- 本类的思想，是将tableView中cell的相关逻辑集中起来，
- 放到数组中管理，而不是将业务逻辑分散在各个代理方法中。
- 特别是使用基类BaseTableViewController进行转接后，具体业务vc不需要实现tableView cell相关的代理方法（header/footer除外）

----

如下动图，只需注释/取消注释几行代码，即可隐藏/显示对应cell，无需在多个代理方法中修改。

![image](https://github.com/JC-Hu/JHCellConfig/blob/master/123.gif)

----
## 使用
1. 参照Demo，在tableVC基类BaseTableViewController中，声明一个管理`cellConfig`实例的可变数组如`dataArray`，并实现tableView的代理方法，使用`cellConfig`的相关方法来处理，实现“转接”。
2. 在具体业务cell中，实现`JHCellConfigProtocol`协议中的方法，更新界面的`-(void)updateContentWithCellConfig:`和获取高度`+(CGFloat)cellHeightWithCellConfig:`方法，分别会在tableView的`cellForRow`和`heightForRow`时调用。
3. 在具体业务vc中，根据页面需求，生成`cellConfig`实例并添加到`dataArray`中

```objective-c
for (Comment *model in self.commentDataArray) {
JHCellConfig *cellConfig = [JHCellConfig cellConfigWithCellClass:[AdvanceCommentCell class] dataModel:model];
cellConfig.selectBlock = ^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell) {
// 点击事件
};
[self.dataArray addObject:cellConfig];
}
```
4.如需刷新UI，更新`dataArray`后调用`[tableView reloadData]`


----
## Tips
##### 关于Nib/Xib支持
1. cell使用Nib（Xib），调用`useNib`或将`isNib`属性置为`YES`（默认用类名做nib文件名，如需自定义，可提前registerNib）

```objective-c
JHCellConfig *cell = [JHCellConfig cellConfigWithCellClass:[ListTableViewCell class] dataModel:model].useNib;
```


##### 关于cell的生成(复用)
1. 生成/复用cell时会自动调用更新UI的方法
2. cell`重用ID`默认使用类名，想自定义可以使用`cellConfig.reuseID`属性

##### 关于cell的高度
1. 建议仿照Demo，在Cell.m中实现`+ (CGFloat)cellHeightWithCellConfig:`协议方法，在此方法中返回cell高度
2. 如cell为固定高度，也可使用`cellConfig.constantHeight`属性，会优先使用。（个人不建议，会导致代码风格不统一，不易阅读）
3. v2.1.0新增高度自动计算特性，可根据约束自动计算cell高度（参照FDTemplateLayoutCell）

```objective-c
#import "JHCellConfig+DynamicHeight.h"
// 返回cell高度
+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig
{
// 自动计算
return [cellConfig dynamicHeightCalResult]; // 简易方法,会自动缓存计算结果

// 完整方法
//    return [cellConfig dynamicHeightWithConfiguration:^(id cell) {
//        // 在此block可在高度计算前对cell进行操作，会在updateContentWithCellConfig:后执行
//        // do something
//    }
//                                           identifier:nil // 指定reuseId，默认为cell类名
//                                           usingCache:NO];// 可设置为不缓存计算结果

}
```
4. 使用高度自动计算时，如需不缓存高度，请使用上面的“完整方法”来计算高度，并且`usingCache:`传`NO`

##### 关于cell的点击事件
1. 提供了`cellConfig.selectBlock`属性来处理点击事件，需在tableView `didSelectRow`时调用（建议参照Demo在基类处理）

## 最后
请多看Demo
请多看Demo
请多看Demo

