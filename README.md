JHCellConfig
=======

- Flexible way to build a UITableView contains different kinds of cells, super easy to modify.
- 一种十分灵活易变的适用于创建有多种cell的UITableView的方法，在调整不同种cell的顺序、及增删某种cell时极其方便


本类的思想，是将tableView中cell的相关逻辑集中起来，
放到数组中管理，而不是将业务逻辑分散在各个代理方法中


----

如下动图，只需注释/取消注释几行代码，即可隐藏/显示对应cell，无需在多个代理方法中修改。

![image](https://github.com/JC-Hu/JHCellConfig/blob/master/123.gif)