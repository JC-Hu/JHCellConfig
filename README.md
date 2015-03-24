JHCellConfig
=======

- Flexible way to build a UITableView contains different kinds of cells, without switch...case, super easy to modify.
- 一种十分灵活易变的适用于创建有多种cell的UITableView的方法，不需要使用switch...case，在调整不同种cell的顺序、及增删某种cell时极其方便


本类相当于将tableView中cell所需的基本信息存储下来，以便放到数组中管理
----

关于如何使用请看demo，注释写了很多



优点：改变不同类型cell的顺序、增删时，极为方便，只需改变VC中数据源数组即可，无需在多个tableView代理方法中逐个修改


缺点：大家帮我找一找，什么样的需求会难以实现，感谢^_^


*   加入了“高级评论”的示例代码，根据数据源数组来显示评论列表，不确定个数、不确定评论内容长度（即cell高度不确定），可在工程中搜索 高级评论 查看相关代码。

*   加入了cell上按钮触发事件绑定的示例代码，手势等同理。

*   对不同种cell进行不同设置时，通过 其对应的 cellConfig.title 进行判断。

    （这样，不论你将dataArray如何修改，插入、删除、改变顺序，都无须再次修改这里的判断）



**      此方法的核心思想就是两个字 “化简”。

        通常写多种cell时，不同cell有不同设置，需要在多个代理方法中进行判断，而且很多是用switch...case来写。这样一旦修改，就需要修改多处。

        而通过JHCellConfig类提供的方法进行化简后，要改两种cell的顺序，就只需交换两行对应的代码；要删除或添加某种cell，就只需注释/删除或添加一行代码。




>   y = x + 3x + 5x  化简-> y = 9x

>   PM 提需求: 把x换成a！

>   y = x + 3x + 5x 需修改3处，y = 9x只需修改1处






我会不定期更新此demo，加上一些“高级”用法，即应对不同需求时的用法，可以关注下面的微信公众号，更新时我会给你们发消息

-------
> Email：jchu_dlcn@icloud.com

> 新浪微博：@胡竞尘_要做全面发展的好青年

> QQ：601541744

> 微信公众号：hujingchen4096